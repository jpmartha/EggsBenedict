//
//  ViewController.swift
//  DemoApp
//
//  Created by JPMartha on 2015/12/25.
//  Copyright © 2015 JPMartha. All rights reserved.
//

import UIKit
import EggsBenedict

class ViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareOnInstagramButton: UIButton!

    let sharingFlow = SharingFlow(type: .IGOExclusivegram)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareOnInstagramButton.enabled = sharingFlow.hasInstagramApp
    }
    
    @IBAction func shareOnInstagramButtonTapped(sender: UIButton) {
        sharingFlow.presentOpenInMenuWithImage(imageView.image, inView: view, documentInteractionDelegate: self) { (sharingFlowResult) -> Void in
            switch sharingFlowResult {
            case .Success(let imagePath):
                print("Success: \(imagePath)")
            case let .Failure(imagePath, errorType):
                print("ImagePath: \(imagePath), ErrorType: \(errorType)")
            }
        }
    }

    @IBAction func removeTmpButtonTapped(sender: UIButton) {
        sharingFlow.removeTemporaryImage { (sharingFlowResult) -> Void in
            switch sharingFlowResult {
            case .Success(let imagePath):
                print("Success: \(imagePath)")
            case let .Failure(imagePath, errorType):
                print("ImagePath: \(imagePath), ErrorType: \(errorType)")
            }
        }
    }
    
    // MARK: - UIDocumentInteractionControllerDelegate
    
    func documentInteractionControllerDidDismissOpenInMenu(controller: UIDocumentInteractionController) {
        print(__FUNCTION__)
    }
}
