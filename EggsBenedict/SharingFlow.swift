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

private enum SharingFlowError: ErrorType {
    case CannotManipulateImage
    case CannotSaveImage
}

public final class SharingFlow {
    
    lazy private var documentInteractionController = UIDocumentInteractionController()
    private var imagePath: String?
    
    public var hasInstagram: Bool {
        return UIApplication.sharedApplication().canOpenURL(NSURL(string: "instagram://")!)
    }
    
    private var filenameExtension: String!
    private var UTI: String!

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
    
    /// Send image to Instagram app.
    /// - Parameter image: The image for sending to Instagram app.
    /// - Parameter view: The view from which to display the options menu.
    public func sendImage(image: UIImage!, view: UIView!){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            guard self.hasInstagram else {
                print("Error: Not found Instagram app.")
                return
            }
            
            do {
                try self.saveTemporaryImage(image)
            } catch let sharingFlowError as SharingFlowError {
                switch sharingFlowError {
                case .CannotManipulateImage:
                    print("Error: Cannot manipulate image.")
                case .CannotSaveImage:
                    print("Error: Cannot save image.")
                }
                return
            } catch let error as NSError {
                print("Error: \(error.description)")
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.documentInteractionController.URL = NSURL.fileURLWithPath(self.imagePath!)
                self.documentInteractionController.UTI = self.UTI
                self.documentInteractionController.presentOptionsMenuFromRect(
                    view.bounds,
                    inView: view,
                    animated: true
                )
            })
        })
    }
    
    private func saveTemporaryImage(image: UIImage) throws {
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            throw SharingFlowError.CannotManipulateImage
        }
        
        let documentDirectory = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("tmp")
        imagePath = (documentDirectory as NSString).stringByAppendingPathComponent("jpmarthaeggsbenedict\(filenameExtension)")
        
        guard imageData.writeToFile(imagePath!, atomically: true) else {
            throw SharingFlowError.CannotSaveImage
        }
    }
    
    /// Remove temporary image in "tmp/" directory.
    public func removeTemporaryImage() {
        guard let imagePath = imagePath else {
            print("Error: ImagePath is nil.")
            return
        }
        
        do {
            try removeTemporaryImage(imagePath)
        } catch let error as NSError {
            print("Error: \(error.description)")
            return
        }
    }
    
    private func removeTemporaryImage(imagePath: String) throws {
        do {
            try NSFileManager().removeItemAtPath(imagePath)
        } catch let error as NSError {
            throw error
        }
    }
}
