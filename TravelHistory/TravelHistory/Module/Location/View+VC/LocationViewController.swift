//
//  ViewController.swift
//  TravelHistory
//
//  Created by Rajkumar on 02/01/22.
//

import UIKit
import CoreData
import CoreLocation

class LocationViewController: UIViewController {
    
    @IBOutlet weak var locationTableView: UITableView!

    weak var timer: Timer?
    
    var viewModel = LocationViewModel()
    var locationManager = CLLocationManager()
    var addTimer : TimeInterval = 60.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.viewModel.getlocationdata(onSuccess: { status  in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd yyyy, h:mm:ss a"
            let count = self.viewModel.getLocationdetails.count
            if count != 0 {
                if UserDefaults.isFirstTime() {
                    let startdate = dateFormatter.date(from: self.viewModel.getLocationdetails[count - 1].date ?? "")
                    let timeInterval = Date().timeIntervalSince(startdate ?? Date())
                    print(self.timeString(time: timeInterval))
                    if timeInterval >= 60.0 {
                        self.determineMyCurrentLocation()
                    } else {
                        self.addTimer = 60.0 - timeInterval
                    }
                } else {
                    self.determineMyCurrentLocation()
                }
            } else {
                self.determineMyCurrentLocation()
            }
        })
     }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startTimer()
    }
    
    func initViews() {
        locationTableView.register(UINib(nibName:"LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationTableViewCell")
        locationTableView.rowHeight = UITableView.automaticDimension
        locationTableView.reloadData()
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestLocation()
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: addTimer, repeats: true) { [weak self] _ in
            self?.addTimer = 600.0
            self?.determineMyCurrentLocation()
         }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    deinit {
        stopTimer()
    }
 
    func timeString(time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }

 }

extension LocationViewController : CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                print("Access notDetermined")
            case .restricted:
                print("Access restricted")
            case .denied:
                print("Access denied")
                self.showAlert(message: "Enable your location to continue")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            @unknown default:
                break
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopMonitoringSignificantLocationChanges()
        
        let userLocation:CLLocation = locations[0] as CLLocation
        let location = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        location.placemark { placemark, error in
            guard let placemark = placemark else {
                print("Error:", error ?? "nil")
                return
            }
            let date = Date()
            let df = DateFormatter()
            df.dateFormat = "MMM dd yyyy, h:mm:ss a"
            let dateString = df.string(from: date)
            let address = placemark.postalAddressFormatted ?? ""
            
            self.viewModel.savelocationdata(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, address: address, date: dateString)
            self.viewModel.getlocationdata(onSuccess: { success  in
                
            })
            
            self.locationTableView.reloadData()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

extension LocationViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getLocationdetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
        
        let contentData = self.viewModel.getLocationdetails.reversed()[indexPath.row]
        let address = contentData.address ?? ""
        let date = contentData.date ?? ""
        let lat = contentData.latitude ?? 0.0
        let long = contentData.longitude ?? 0.0
        let addressToShow = "Address : \(address)\nlat & long: \(lat) : \(long)\nDate : \(date)"
        cell.addressLabel.text = addressToShow
        return cell
     }
    
}
