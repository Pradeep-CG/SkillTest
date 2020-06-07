//
//  DetailCell.swift
//  SkillsTest
//
//  Created by Pradeep on 07/06/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var sunriseLbl: UILabel!
    @IBOutlet weak var sunsetLbl: UILabel!
    @IBOutlet weak var chanceRainlbl: UILabel!
    
    @IBOutlet weak var humadityLbl: UILabel!
    
    @IBOutlet weak var windLbl: UILabel!
    
    @IBOutlet weak var feelLikeLbl: UILabel!
    
    @IBOutlet weak var precipitaionLbl: UILabel!
    
    
    @IBOutlet weak var pressureLbl: UILabel!
    
    @IBOutlet weak var visibilityLbl: UILabel!
    @IBOutlet weak var uvIndexLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
