//
//  SharingFlow.swift
//  EggsBenedict
//
//  Created by JPMartha on 2015/12/26.
//  Copyright © 2015年 JPMartha. All rights reserved.
//

import UIKit

private protocol InstagramSharingFlow {
    var filenameExtension: String! { get }
    var UTI: String! { get }
    var hasInstagramApp: Bool { get }
    init(type: SharingFlowType)
    func saveTemporaryImage(image: UIImage!) throws -> String
    func presentOpenInMenuWithImage(image: UIImage!, view: UIView!, documentInteractionControllerDelegate delegate: UIDocumentInteractionControllerDelegate?, completion: ((result: Result<Any>) -> Void)?)
    func removeTemporaryImage(completion: ((result: Result<Any>) -> Void)?)
}

public enum SharingFlowType {
    case IGPhoto
    case IGOExclusivegram
}

public enum Result<T> {
    case Success(T)
    case Failure(T)
}

public enum SharingFlowError: ErrorType, CustomDebugStringConvertible {
    case NoInstagramApp
    case UTIIsEmpty
    case CannotManipulateImage
    case CannotSaveImage
    case ImagePathIsEmpty
    
    public var debugDescription: String {
        switch self {
        case .NoInstagramApp:
            return "Not found Instagram app."
        case .UTIIsEmpty:
            return "UTI is empty."
        case .CannotManipulateImage:
            return "Cannot manipulate image."
        case .CannotSaveImage:
            return "Cannot save image."
        case .ImagePathIsEmpty:
            return "ImagePath is empty."
        }
    }
}

public final class SharingFlow: InstagramSharingFlow {
    public var filenameExtension: String!
    public var UTI: String!
    private var imagePath: String!
    lazy private var documentInteractionController = UIDocumentInteractionController()

    public init(type: SharingFlowType) {
        switch type {
        case .IGPhoto:
            self.filenameExtension = ".ig"
            self.UTI = "com.instagram.photo"
        case .IGOExclusivegram:
            self.filenameExtension = ".igo"
            self.UTI = "com.instagram.exclusivegram"
        }
    }

    /// Returns a Boolean value indicating whether or not Instagram app is installed on the device.
    public var hasInstagramApp: Bool {
        return UIApplication.sharedApplication().canOpenURL(NSURL(string: "instagram://")!)
    }
    
    internal func saveTemporaryImage(image: UIImage!) throws -> String {
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            throw SharingFlowError.CannotManipulateImage
        }
        
        let temporaryDirectory = NSTemporaryDirectory() as NSString
        let temporaryImagePath = temporaryDirectory.stringByAppendingPathComponent("jpmarthaeggsbenedict\(filenameExtension)")
        
        guard imageData.writeToFile(temporaryImagePath, atomically: true) else {
            throw SharingFlowError.CannotSaveImage
        }
        
        return temporaryImagePath
    }
    
    /// Present the menu for sending image to Instagram app.
    /// - Parameter image: The image for sending to Instagram app.
    /// - Parameter view: The view from which to display the options menu.
    /// - Parameter documentInteractionControllerDelegate: The delegate you want to receive document interaction notifications. You may specify nil for this parameter.
    /// - Parameter completion: The block to execute after the presenting an options menu. You may specify nil for this parameter.
    public func presentOpenInMenuWithImage(image: UIImage!, view: UIView!, documentInteractionControllerDelegate delegate: UIDocumentInteractionControllerDelegate?, completion: ((result: Result<Any>) -> Void)?) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            guard self.hasInstagramApp else {
                completion?(result: .Failure(SharingFlowError.NoInstagramApp))
                return
            }
            
            guard let UTI = self.UTI else {
                completion?(result: .Failure(SharingFlowError.UTIIsEmpty))
                return
            }
            
            do {
                self.imagePath = try self.saveTemporaryImage(image)
            } catch let sharingFlowError as SharingFlowError {
                completion?(result: .Failure(sharingFlowError))
                return
            } catch let error as NSError {
                completion?(result: .Failure(error))
                return
            }
            
            guard let imagePath = self.imagePath else {
                completion?(result: .Failure(SharingFlowError.ImagePathIsEmpty))
                return
            }

            self.documentInteractionController.URL = NSURL.fileURLWithPath(imagePath)
            self.documentInteractionController.UTI = UTI
            self.documentInteractionController.delegate = delegate
            
            dispatch_async(dispatch_get_main_queue(), {
                self.documentInteractionController.presentOpenInMenuFromRect(
                    view.bounds,
                    inView: view,
                    animated: true
                )
                completion?(result: .Success(imagePath))
            })
        })
    }
    
    /// Remove temporary image in "tmp/" directory.
    /// - Parameter completion: The block to execute after the removing temporary image finishes. You may specify nil for this parameter.
    public func removeTemporaryImage(completion: ((result: Result<Any>) -> Void)?) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            guard let imagePath = self.imagePath else {
                completion?(result: .Failure(SharingFlowError.ImagePathIsEmpty))
                return
            }
            
            do {
                try NSFileManager().removeItemAtPath(imagePath)
            } catch let error as NSError {
                completion?(result: .Failure(error))
                return
            }
            completion?(result: .Success(imagePath))
        })
    }
}
