//
//  ViewController.swift
//  SkillsTest
//
//  Created by Pradeep on 03/06/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreData

class ViewController: UIViewController{
    
    @IBOutlet weak var tblView: UITableView!
    var cityArray = [City]()
    var tableArr = [CityInfo]()
    var httpUtility:HttpUtility?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        httpUtility = HttpUtility()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onCityNotification(_:)), name: NSNotification.Name(rawValue: "SearchedCity"), object: nil)
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
            loadTableData()
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            loadDefaultCities()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    @objc func onCityNotification(_ notification: NSNotification) {
        
        if let cityName = notification.userInfo?["textfldValue"] as? String {
            
            print("cityName = \(cityName)")
            retrieveWeatherDataFromApi(cityName: cityName)
        }
    }
    func loadDefaultCities() {
        
        let defaultCity = ["Delhi", "Mumbai","Bengaluru", "Hyderabad","Chennai","Kolkata"]
        
        for city in defaultCity {
            
            retrieveWeatherDataFromApi(cityName: city)
        }
    }
    func retrieveWeatherDataFromApi(cityName:String) {
        
        
        let weatherApiUrlString = "\(Common.weatherApi)\(cityName)\(Common.weatherApiKey)"
        print("weatherApiUrlString = \(weatherApiUrlString)")
        
        httpUtility?.getApiData(requestUrl: weatherApiUrlString, resultType: WeatherResponse.self) { (weatherResponse) in
            
            debugPrint("WeatherResponse = \(weatherResponse)")
            
            let name = weatherResponse.name
            let lat = weatherResponse.coord.lat
            let lon = weatherResponse.coord.lon
            let description = weatherResponse.weather[0].weatherDescription
            let temp = weatherResponse.main.temp
            let mxTemp = weatherResponse.main.tempMax
            let minTemp = weatherResponse.main.tempMin
            let dt = Double(weatherResponse.dt)
            
            // Save city details into CityInfo Entity
            DatabaseHelper.sharedInstance.saveCityData(list: ListModel(name: name, lat: lat, lon: lon, description: description, temp: temp, date: dt, maxTemp: mxTemp, minTemp: minTemp)) { (cityName) in
                // Save city name into City Entity
                if cityName.count > 1{
                    
                    if DatabaseHelper.sharedInstance.checkCityNameExist(cityName: cityName) {
                        print("city exist")
                    }
                    else{
                        DatabaseHelper.sharedInstance.saveCityName(searchValue: cityName) { (status) in
                            if status{
                                
                            }
                            else{
                                print("try again")
                            }
                        }
                    }
                }
                
                DispatchQueue.main.sync {
                    self.tableArr = DatabaseHelper.sharedInstance.getAllCityInfoData()
                    self.tblView.reloadData()
                } 
            }
            
        }
    }
    func loadTableData() {
        
        tableArr.removeAll()
        
        cityArray = DatabaseHelper.sharedInstance.getAllCityData()
        
        for city in cityArray {
            print("city = \(city.name!)")
            let cityName = city.name!
            retrieveWeatherDataFromApi(cityName: cityName)
        }
    }
    @IBAction func addCityBtnClicked(_ sender: Any) {
        
        let acController = GMSAutocompleteViewController()
        acController.primaryTextColor = .white
        acController.secondaryTextColor = .lightGray
        acController.tableCellSeparatorColor = .lightGray
        acController.tableCellBackgroundColor = .darkGray
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
}






extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.cityInfoData = tableArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let weatherVC = self.storyboard?.instantiateViewController(identifier: "weatherVC") as! WeatherViewController
        weatherVC.selectedIndex = indexPath.row
        weatherVC.cityInfoArr = self.tableArr
        self.navigationController?.pushViewController(weatherVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if tableArr.count > 1 {
            return true
        }
        else{
            return false
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            cityArray = DatabaseHelper.sharedInstance.deleteCityData(index: indexPath.row)
            tableArr = DatabaseHelper.sharedInstance.deleteCityInfoData(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}







extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("place name = \(place.name!)")
        
        if let placeName = place.name{
            print(placeName)
            retrieveWeatherDataFromApi(cityName: placeName)
            dismiss(animated: true, completion: nil)
        }
        
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: ", error.localizedDescription)
        dismiss(animated: true, completion: nil)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "cityInputVC") as! CityInputViewController
        self.present(vc, animated: true, completion: nil)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }
    
}
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}
