//
//  CustomTableViewCell.swift
//  SkillsTest
//
//  Created by Pradeep on 04/06/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempretureLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var latLonLbl: UILabel!
    @IBOutlet weak var farenhitLbl: UILabel!
    
    var cityInfoData:CityInfo!{
        didSet{

            if let weatherDescription = cityInfoData.des{
                imgView.image = UIImage(named: Common.getImageName(weatherDescription: weatherDescription))
                descriptionLbl.text = weatherDescription
            }
            
            let dateString = Common.convertEpocToTime(epocValue: cityInfoData.dt)
            let cityName = cityInfoData.name ?? ""
            let tempreture = cityInfoData.temp
            
            timeLbl.text = dateString
            cityLbl.text = cityName
            tempretureLbl.text = Common.convertTemp(temp: tempreture, from: .kelvin, to: .celsius)
            latLonLbl.text = "lat: \(cityInfoData.lat), lon: \(cityInfoData.lon)"
            farenhitLbl.text = Common.convertTemp(temp: tempreture, from: .kelvin, to: .fahrenheit)
            
            cityLbl.layer.shadowColor = UIColor.black.cgColor
            cityLbl.layer.shadowRadius = 1.0
            cityLbl.layer.shadowOpacity = 1.0
            cityLbl.layer.shadowOffset = CGSize(width: 2, height: 2)
            cityLbl.layer.masksToBounds = false
            
            tempretureLbl.layer.shadowColor = UIColor.black.cgColor
            tempretureLbl.layer.shadowRadius = 1.0
            tempretureLbl.layer.shadowOpacity = 1.0
            tempretureLbl.layer.shadowOffset = CGSize(width: 2, height: 2)
            tempretureLbl.layer.masksToBounds = false
            
            timeLbl.layer.shadowColor = UIColor.black.cgColor
            timeLbl.layer.shadowRadius = 1.0
            timeLbl.layer.shadowOpacity = 1.0
            timeLbl.layer.shadowOffset = CGSize(width: 2, height: 2)
            timeLbl.layer.masksToBounds = false
            
            tempretureLbl.layer.shadowColor = UIColor.black.cgColor
            tempretureLbl.layer.shadowRadius = 1.0
            tempretureLbl.layer.shadowOpacity = 1.0
            tempretureLbl.layer.shadowOffset = CGSize(width: 2, height: 2)
            tempretureLbl.layer.masksToBounds = false
            
            latLonLbl.layer.shadowColor = UIColor.black.cgColor
            latLonLbl.layer.shadowRadius = 1.0
            latLonLbl.layer.shadowOpacity = 1.0
            latLonLbl.layer.shadowOffset = CGSize(width: 2, height: 2)
            latLonLbl.layer.masksToBounds = false
            
            descriptionLbl.layer.shadowColor = UIColor.black.cgColor
            descriptionLbl.layer.shadowRadius = 1.0
            descriptionLbl.layer.shadowOpacity = 1.0
            descriptionLbl.layer.shadowOffset = CGSize(width: 2, height: 2)
            descriptionLbl.layer.masksToBounds = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
