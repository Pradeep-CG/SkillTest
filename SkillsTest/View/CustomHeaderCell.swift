//
//  CustomHeaderCell.swift
//  SkillsTest
//
//  Created by Pradeep on 07/06/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

class CustomHeaderCell: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var headerLbl: UILabel!

    let timeArr = ["Now", "2AM", "3AM", "4AM", "5AM", "6AM", "7AM", "8AM", "9AM", "10AM", "11AM","12PM","1PM","2PM","3PM","4PM","5PM","6PM","7PM","8PM","9PM","10PM","11PM","12AM"]
    let imgArr = ["cloud.fill","cloud.moon.fill","moon.stars.fill","sunrise.fill","sun.max.fill","sun.max.fill","sun.max.fill","sun.max.fill","sun.max.fill","sun.max.fill","sun.max.fill","sun.max.fill","sun.max.fill","sun.max.fill","sun.max.fill","sun.max.fill","sun.max.fill","sun.max.fill","sunset.fill","moon.stars.fill","moon.stars.fill","moon.stars.fill","moon.stars.fill","moon.stars.fill"]
    let tempArr = ["27°","27°","27°","27°","Sunrise","27°","25°","25°","25°","25°","25°","25°","25°","26°","26°","26°","26°","26°","Sunset","25°","25°","25°","25°","25°","25°"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let timecell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as! TimeCell
        timecell.timeLbl.text = timeArr[indexPath.row]
        timecell.cloudImgView.image = UIImage(systemName: imgArr[indexPath.row])
        timecell.tempretureLbl.text = tempArr[indexPath.row]
        
        return timecell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: collectionView.frame.size.height)
    }
}
