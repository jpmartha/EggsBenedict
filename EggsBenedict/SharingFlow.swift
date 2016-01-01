//
//  SharingFlow.swift
//  EggsBenedict
//
//  Created by JPMartha on 2015/12/26.
//  Copyright © 2015年 JPMartha. All rights reserved.
//

import UIKit

private protocol InstagramSharingFlow {
    var hasInstagram: Bool { get }
    var filenameExtension: String { get }
    var UTI: String { get }
    func saveImage(image: UIImage!)
    func sendImage(image: UIImage!, view: UIView!)
    func removeImage()
}

private enum SharingFlowError: ErrorType {
    case CannotManipulateImage
    case CannotSaveImage
}

public class SharingFlow: InstagramSharingFlow {
    
    public init() {
        
    }

    /// Returns a Boolean value indicating whether or not Instagram app is installed on the device.
    public var hasInstagram: Bool {
        return UIApplication.sharedApplication().canOpenURL(NSURL(string: "instagram://")!)
    }
    
    private var filenameExtension: String {
        return ""
    }
    
    private var UTI: String {
        return ""
    }
    
    private var imagePath: String?
    
    lazy private var documentInteractionController = UIDocumentInteractionController()
    
    private func saveImage(image: UIImage!) {
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
    
    /// Send image to Instagram app.
    /// - Parameter image: The image for sending to Instagram app.
    /// - Parameter view: The view from which to display the options menu.
    public func sendImage(image: UIImage!, view: UIView!){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            guard self.hasInstagram else {
                print("Error: Not found Instagram app.")
                return
            }
            
            self.saveImage(image)

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
    
    /// Remove temporary image in "tmp/" directory.
    public func removeImage() {
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

public final class SharingFlowIGPhoto: SharingFlow {
    override internal var filenameExtension: String {
        return ".ig"
    }
    
    override public var UTI: String {
        return "com.instagram.photo"
    }
}

public final class SharingFlowIGOExclusivegram: SharingFlow {
    override internal var filenameExtension: String {
        return ".igo"
    }
    
    override internal var UTI: String {
        return "com.instagram.exclusivegram"
    }
}
