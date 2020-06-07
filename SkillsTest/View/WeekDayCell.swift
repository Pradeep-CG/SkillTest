//
//  WeekDayCell.swift
//  SkillsTest
//
//  Created by Pradeep on 07/06/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

class WeekDayCell: UITableViewCell {

    @IBOutlet weak var monCloud: UIImageView!
    @IBOutlet weak var monHigh: UILabel!
    @IBOutlet weak var monMin: UILabel!
    
    @IBOutlet weak var TueCloud: UIImageView!
    @IBOutlet weak var tueHigh: UILabel!
    @IBOutlet weak var tueMin: UILabel!
    
    @IBOutlet weak var wedCloud: UIImageView!
    @IBOutlet weak var wedHigh: UILabel!
    @IBOutlet weak var wedMin: UILabel!
    
    @IBOutlet weak var thuCloud: UIImageView!
    @IBOutlet weak var thuMax: UILabel!
    @IBOutlet weak var thuMin: UILabel!
    
    @IBOutlet weak var friCloud: UIImageView!
    @IBOutlet weak var friMax: UILabel!
    @IBOutlet weak var friMin: UILabel!
    
    @IBOutlet weak var satCloud: UIImageView!
    @IBOutlet weak var satMax: UILabel!
    @IBOutlet weak var satMin: UILabel!
    
    @IBOutlet weak var sunCloud: UIImageView!
    @IBOutlet weak var sunMax: UILabel!
    @IBOutlet weak var sunMin: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
