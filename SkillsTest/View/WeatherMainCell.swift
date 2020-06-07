//
//  WeatherMainCell.swift
//  SkillsTest
//
//  Created by Pradeep on 07/06/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

class WeatherMainCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherDes: UILabel!
    @IBOutlet weak var bkView: UIView!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var dayNameLbl: UILabel!
    @IBOutlet weak var celcius: UILabel!
    @IBOutlet weak var farenhit: UILabel!
    
    @IBOutlet weak var todayLbl: UILabel!
    
    var lastContentOffset: CGFloat = 0
    var cityInfoData:CityInfo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "customHeaderCell") as! CustomHeaderCell
        //headerCell.headerLbl.text = "Header view"
        return headerCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var rowHt:CGFloat = 0.0
        
        if indexPath.row == 0 {
            rowHt = 245.0
        }
        if indexPath.row == 1 {
            rowHt = 75.0
        }
        if indexPath.row == 2 {
            rowHt = 400.0
        }
        return rowHt
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // var cell:UITableViewCell
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "weekDayCell", for: indexPath) as! WeekDayCell
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! DescriptionCell
            
            let descriptionVal = cityInfoData?.des
            let tempreture = Common.convertTemp(temp: cityInfoData?.temp ?? 301.15, from: .kelvin, to: .celsius)
            let maxTempreture = Common.convertTemp(temp: cityInfoData?.maxTemp ?? 301.15, from: .kelvin, to: .celsius)
            let minTempreture = Common.convertTemp(temp: cityInfoData?.minTemp ?? 301.15, from: .kelvin, to: .celsius)
            cell.descriptionLbl.text = "Today:\(descriptionVal!).It's \(tempreture); The high will be \(maxTempreture). Clear tonight with a low of \(minTempreture)"
       
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailCell
            return cell
        }
        return UITableViewCell()
        
    }
    
    // this delegate is called when the scrollView (i.e your UITableView) will start scrolling
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    // while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset < scrollView.contentOffset.y {
            // did move up
            print("move up")
            
            UIView.animate(withDuration: 2.0, animations: {
                self.tempLbl.alpha = 0
                self.dayNameLbl.alpha = 0
                self.celcius.alpha = 0
                self.farenhit.alpha = 0
                self.todayLbl.alpha = 0
            }) { (status) in
                self.tempLbl.isHidden = true
                self.dayNameLbl.isHidden = true
                self.celcius.isHidden = true
                self.farenhit.isHidden = true
                self.todayLbl.isHidden = true
            }
            
        } else if self.lastContentOffset > scrollView.contentOffset.y {
            // did move down
            UIView.animate(withDuration: 2.0, animations: {
                self.tempLbl.alpha = 1
                self.dayNameLbl.alpha = 1
                self.celcius.alpha = 1
                self.farenhit.alpha = 1
                self.todayLbl.alpha = 1
            }) { (status) in
                self.tempLbl.isHidden = false
                self.dayNameLbl.isHidden = false
                self.celcius.isHidden = false
                self.farenhit.isHidden = false
                self.todayLbl.isHidden = false
            }
        } else {
            // didn't move
            print("did't move")
        }
    }
}

