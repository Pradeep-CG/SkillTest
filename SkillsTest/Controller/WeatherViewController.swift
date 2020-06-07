//
//  WeatherViewController.swift
//  SkillsTest
//
//  Created by Pradeep on 07/06/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var pageCtr: UIPageControl!
    @IBOutlet weak var mainCollection: UICollectionView!
    var selectedIndex = 0
    var cityInfoData:CityInfo?
    var cityInfoArr = [CityInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        pageCtr.numberOfPages = cityInfoArr.count
        pageCtr.currentPage = selectedIndex
        cityInfoData = cityInfoArr[selectedIndex]
    }

    func changeBackgroundImage() {

        
        ///////////////////////////////
//        [UIView transitionWithView:textFieldimageView
//          duration:0.2f
//           options:UIViewAnimationOptionTransitionCrossDissolve
//        animations:^{
//            imageView.image = newImage;
//        } completion:nil];
        

    }
    @IBAction func onExitBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityInfoArr.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherMainCell", for: indexPath) as! WeatherMainCell

        cell.cityInfoData = self.cityInfoData
        
        if let weatherDescription = cityInfoData?.des{
            cell.weatherDes.text  = weatherDescription
        }
        
        let cityName = cityInfoData?.name ?? ""
        let tempreture = cityInfoData?.temp
        let maxTempreture = cityInfoData?.maxTemp
        let minTempreture = cityInfoData?.minTemp
        
        cell.cityName.text = cityName
        cell.tempLbl.text = Common.convertTemp(temp: tempreture ?? 301.15, from: .kelvin, to: .celsius)
        cell.dayNameLbl.text = Date().dayOfWeek()!
        cell.celcius.text = Common.convertTemp(temp: maxTempreture ?? 301.15, from: .kelvin, to: .celsius)
        cell.farenhit.text = Common.convertTemp(temp: minTempreture ?? 301.15, from: .kelvin, to: .celsius)
        return cell
       }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width , height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    
    // scroll view events
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageSide = self.mainCollection.frame.width
        let offset = scrollView.contentOffset.x
        let currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        pageCtr.currentPage = currentPage
        
        cityInfoData = cityInfoArr[currentPage]
        mainCollection.reloadData()
    }
    
    
}
