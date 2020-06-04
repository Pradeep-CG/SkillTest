//
//  Common.swift
//  SkillsTest
//
//  Created by Pradeep on 03/06/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct Common {
    static let googlePlaceKey = "AIzaSyCtHp4MZMXw3Wsru68K2pARB2kHKbMBrJA"
    static let weatherApi = "https://api.openweathermap.org/data/2.5/weather?q="
    static let weatherApiKey = "&appid=66c3fd0cb6de2383542585703136321a"
    
    static func convertEpocToTime(epocValue:Double) -> String{
        
         let date = Date(timeIntervalSince1970: epocValue)
         let dateFormatter = DateFormatter()
         dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        // dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
         dateFormatter.timeZone = .current
         let localTime = dateFormatter.string(from: date)
        print("local time = \(localTime)")
        return localTime
    }
    static func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    static func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        let mf = MeasurementFormatter()

      mf.numberFormatter.maximumFractionDigits = 0
      mf.unitOptions = .providedUnit
      let input = Measurement(value: temp, unit: inputTempType)
      let output = input.converted(to: outputTempType)
      return mf.string(from: output)
    }
    
    static func getImageName(weatherDescription:String) -> String{
        
        var imageName = ""
        let val = weatherDescription
        
        if (val == "haze" || val == "smoke" || val == "sand" || val == "dust") {
            let smoky = ["smoky","smoky1","smoky2","smoky3"]
            imageName = smoky.randomElement() ?? "smoky"
        }
        else if (val == "fog" || val == "mist") {
            imageName = "fog"
        }
        else if(val == "clear sky"){
            let clearSky = ["clearSky","clearSky1","clearSky2","clearSky3","clearSky4"]
            imageName = clearSky.randomElement() ?? "clearSky"
        }
        else if(val == "scattered clouds")
        {
            let scatter = ["scattered","scattered1","scattered2","scattered3"]
            imageName = scatter.randomElement() ?? "scattered"
        }
        else if(val.contains("rain")){
            let rain = ["raining","raining1","raining2","raining3","raining4","raining5","raining6"]
            imageName = rain.randomElement() ?? "raining"
        }
            
        else if(val.contains("clouds")){
            let cloud = ["brokenClouds","brokenClouds1","brokenClouds2","fewCloud"]
            imageName = cloud.randomElement() ?? "brokenClouds"
        }
        else if(val.contains("drizzle")){
            let drizzle = ["thunderstorm", "thunderstorm1","thunderstorm2","thunderstorm3","thunderstorm4"]
            imageName = drizzle.randomElement() ?? "thunderstorm"
        }
        else {
            imageName = "fewCloud"
        }
        print("imageName = \(imageName)")
        return imageName
    }
}
