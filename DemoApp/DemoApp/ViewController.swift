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
    @IBOutlet weak var shareOnInstagramButton: UIButton!

    let sharingFlow = SharingFlow(type: .IGOExclusivegram)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sharingFlow = sharingFlow {
            shareOnInstagramButton.enabled = sharingFlow.hasInstagram
        }
    }
    
    @IBAction func shareOnInstagramButtonTapped(sender: UIButton) {
        sharingFlow?.sendImage(imageView.image, view: view)
    }
}
