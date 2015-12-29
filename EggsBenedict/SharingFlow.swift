//
//  SharingFlow.swift
//  EggsBenedict
//
//  Created by JPMartha on 2015/12/26.
//  Copyright © 2015年 JPMartha. All rights reserved.
//

import UIKit

public enum SharingFlowType {
    case IGPhoto
    case IGOExclusivegram
}

public final class SharingFlow {
    
    var documentInteractionController = UIDocumentInteractionController()
    
    var imagePath: String?
    
    var filenameExtension: String!
    var UTI: String!
    
    public var hasInstagram: Bool {
        return UIApplication.sharedApplication().canOpenURL(NSURL(string: "instagram://")!)
    }
    
    required public init?(type: SharingFlowType) {
        switch type {
        case .IGPhoto:
            self.filenameExtension = ".ig"
            self.UTI = "com.instagram.photo"
        case .IGOExclusivegram:
            self.filenameExtension = ".igo"
            self.UTI = "com.instagram.exclusivegram"
        }
    }
    
    /**
     Send image to Instagram app.
     - Parameter image: The image for sending to Instagram app.
     - Parameter view: The view from which to display the options menu.
    */
    public func sendImage(image: UIImage!, view: UIView!) {
        
        guard self.hasInstagram else {
            return
        }
        
        guard saveTemporaryImage(image) else {
            return
        }
        
        documentInteractionController.URL = NSURL.fileURLWithPath(imagePath!)
        documentInteractionController.UTI = UTI
        documentInteractionController.presentOptionsMenuFromRect(
            view.bounds,
            inView: view,
            animated: true
        )
    }
    
    private func saveTemporaryImage(image: UIImage) -> Bool {
        
        let documentDirectory = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("tmp")
        imagePath = (documentDirectory as NSString).stringByAppendingPathComponent("jpmarthaeggsbenedict\(filenameExtension)")
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        return (imageData?.writeToFile(imagePath!, atomically: true))!
    }
}
