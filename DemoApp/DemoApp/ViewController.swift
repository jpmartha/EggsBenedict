//
//  ViewController.swift
//  DemoApp
//
//  Created by JPMartha on 2015/12/25.
//  Copyright © 2015年 JPMartha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let eggsBenedict = SharingFlow(type: .IGOExclusivegram)
    
    @IBAction func sharedOnInstagramButtonTapped(sender: UIButton) {
        saveSampleImageAndSendToInstagram()
    }
    
    func saveSampleImageAndSendToInstagram () {
        if let eggsBenedict = eggsBenedict {
            eggsBenedict.sendImage(imageView.image, view: view)
        }
    }
}
