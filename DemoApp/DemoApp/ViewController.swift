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
        
        shareOnInstagramButton.enabled = sharingFlow.hasInstagram
    }
    
    @IBAction func shareOnInstagramButtonTapped(sender: UIButton) {
        sharingFlow.sendImage(imageView.image, view: view) { (result) -> Void in
            switch result {
            case .Success:
                print("Success!")
            case let .Failure(error as SharingFlowError):
                print(error.debugDescription)
            case let .Failure(error as NSError):
                print(error.debugDescription)
            case let .Failure(error):
                print(error)
            }
        }
    }

    @IBAction func removeTmpButtonTapped(sender: UIButton) {
        do {
            try sharingFlow.removeTemporaryImage()
        } catch let sharingFlowError as SharingFlowError {
            print("Error: \(sharingFlowError.debugDescription)")
        } catch let error as NSError {
            print("Error: \(error.debugDescription)")
        }
    }
}
