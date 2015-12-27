//
//  ViewController.swift
//  SharingOnInstagram
//
//  Created by JPMartha on 2015/12/25.
//  Copyright © 2015年 JPMartha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let insta = SharingOnInstagram(instagramFileType: .IGOExclusivegram)
    
    @IBAction func sharedOnInstagramButtonTapped(sender: UIButton) {
        saveSampleImageAndSendToInstagram()
    }
    
    func saveSampleImageAndSendToInstagram () {
        if let insta = insta {
            insta.sendImageToInstagram(UIImage(named: "OZPA")!, view: view)
        }
    }
}
