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

    let sharingFlow = SharingFlow(type: .igoExclusivegram)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareOnInstagramButton.isEnabled = sharingFlow.hasInstagramApp
    }
    
    @IBAction func shareOnInstagramButtonTapped(_ sender: UIButton) {
        sharingFlow.presentOpenInMenuWithImage(imageView.image, inView: view, documentInteractionDelegate: self) { (sharingFlowResult) -> Void in
            switch sharingFlowResult {
            case .success(let imagePath):
                print("Success: \(imagePath)")
            case let .failure(imagePath, errorType):
                print("ImagePath: \(imagePath), ErrorType: \(errorType)")
            }
        }
    }

    @IBAction func removeTmpButtonTapped(_ sender: UIButton) {
        sharingFlow.removeTemporaryImage { (sharingFlowResult) -> Void in
            switch sharingFlowResult {
            case .success(let imagePath):
                print("Success: \(imagePath)")
            case let .failure(imagePath, errorType):
                print("ImagePath: \(imagePath), ErrorType: \(errorType)")
            }
        }
    }
    
    // MARK: - UIDocumentInteractionControllerDelegate
    
    func documentInteractionControllerDidDismissOpenInMenu(_ controller: UIDocumentInteractionController) {
        print(#function)
    }
}
