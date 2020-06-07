//
//  DatabaseHelper.swift
//  SkillsTest
//
//  Created by Pradeep on 04/06/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit
import CoreData

class DatabaseHelper: NSObject {

    static let sharedInstance = DatabaseHelper()
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveCityName(searchValue:String, completion:(_ finish:Bool) ->()) {
        
        let city = City(context: managedContext)
        city.name = searchValue
        do {
            try managedContext.save()
            print("data saved")
            completion(true)
        } catch {
            print("saving error \(error.localizedDescription)")
            completion(false)
        }
    }
    func saveCityData(list:ListModel, completion:(_ forCityName:String) ->()) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CityInfo")
        fetchRequest.predicate = NSPredicate(format: "name = %@", list.name)

        var results: [NSManagedObject] = []
        
        do {
            results = try managedContext.fetch(fetchRequest)
            if results.count > 0 {
                // Update record
                let cityInfo:CityInfo = results[0] as! CityInfo
                cityInfo.name = list.name
                cityInfo.lat = list.lat
                cityInfo.lon = list.lon
                cityInfo.des = list.description
                cityInfo.temp = list.temp
                cityInfo.dt = list.date
                cityInfo.maxTemp = list.maxTemp
                cityInfo.minTemp = list.minTemp
            }
            else{
                // Insert record
                let city = CityInfo(context: managedContext)
                city.name = list.name
                city.lat = list.lat
                city.lon = list.lon
                city.des = list.description
                city.temp = list.temp
                city.dt = list.date
                city.maxTemp = list.maxTemp
                city.minTemp = list.minTemp
            }
        }
        catch {
            print("error executing fetch request: \(error)")
        }

        do {
            try managedContext.save()
            print("data saved")
            completion(list.name)
        } catch {
            print("saving error \(error.localizedDescription)")
            completion("")
        }
        
    }

    
    func checkCityNameExist(cityName:String) -> Bool {

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "City")
            fetchRequest.predicate = NSPredicate(format: "name = %@", cityName)

            var results: [NSManagedObject] = []
            
            do {
                results = try managedContext.fetch(fetchRequest)
            }
            catch {
                print("error executing fetch request: \(error)")
            }

            return results.count > 0
        }
    

    func getAllCityData() -> [City] {
        
        var arrCity = [City]()
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "City")
        do {
            arrCity =  try managedContext.fetch(fetchReq) as! [City]
        } catch {
            print("error = \(error.localizedDescription)")
        }
        return arrCity
    }
    func getAllCityInfoData() -> [CityInfo] {
        
        var arrCityInfo = [CityInfo]()
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "CityInfo")
        do {
            arrCityInfo =  try managedContext.fetch(fetchReq) as! [CityInfo]
        } catch {
            print("error = \(error.localizedDescription)")
        }
        return arrCityInfo
    }
    func deleteCityData(index:Int) -> [City]{
        
        var cityData = self.getAllCityData()
        
        managedContext.delete(cityData[index])
        cityData.remove(at: index)
        do {
            try managedContext.save()
        } catch {
            print("error = \(error.localizedDescription)")
        }
        return cityData
    }
    
 func deleteCityInfoData(index:Int) -> [CityInfo]{
     
     var cityInfoData = self.getAllCityInfoData()
     
     managedContext.delete(cityInfoData[index])
     cityInfoData.remove(at: index)
     do {
         try managedContext.save()
     } catch {
         print("error = \(error.localizedDescription)")
     }
     return cityInfoData
 }
 
}

