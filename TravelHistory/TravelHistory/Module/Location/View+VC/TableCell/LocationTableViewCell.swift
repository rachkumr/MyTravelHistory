//
//  LocationTableViewCell.swift
//  TravelHistory
//
//  Created by Rajkumar on 06/08/21.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addressView.addBorderColor(borderColor: UIColor.clear, borderWidth: 1.0, cornerRadius: 10)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
