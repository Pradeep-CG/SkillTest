//
//  CityInputViewController.swift
//  SkillsTest
//
//  Created by Pradeep on 05/06/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

class CityInputViewController: UIViewController {

    @IBOutlet weak var cityTxtfld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cityTxtfld.becomeFirstResponder()
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        guard let text = cityTxtfld.text, !text.isEmpty else {
            return
        }
        let cityDict:[String: String] = ["textfldValue": cityTxtfld.text!]

        // Post a notification
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SearchedCity"), object: nil, userInfo: cityDict)
        
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
