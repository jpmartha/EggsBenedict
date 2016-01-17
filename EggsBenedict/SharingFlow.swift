//
//  SharingFlow.swift
//  EggsBenedict
//
//  Created by JPMartha on 2015/12/26.
//  Copyright © 2015 JPMartha. All rights reserved.
//

import UIKit

private protocol InstagramSharingFlow {
    var filenameExtension: String! { get }
    var UTI: String! { get }
    var hasInstagramApp: Bool { get }
    init(type: SharingFlowType)
    func writeTemporaryImage(image: UIImage!) throws -> Bool
    func presentOpenInMenuWithImage(image: UIImage!, inView view: UIView!, documentInteractionDelegate delegate: UIDocumentInteractionControllerDelegate?, completion: ((sharingFlowResult: SharingFlowResult<String, ErrorType>) -> Void)?)
}

public final class SharingFlow: InstagramSharingFlow {
    public var filenameExtension: String!
    public var UTI: String!
    internal var imagePath: String!
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
        let temporaryDirectory = NSTemporaryDirectory() as NSString
        self.imagePath = temporaryDirectory.stringByAppendingPathComponent("jpmarthaeggsbenedict\(filenameExtension)")
    }

    /**
    - seealso: [SharingFlow Class Reference](https://github.com/JPMartha/EggsBenedict/blob/develop/Documentation/SharingFlowClassReference.md)
    - returns: A Boolean value indicating whether or not Instagram app is installed on the iOS device.
    */
    public var hasInstagramApp: Bool {
        return UIApplication.sharedApplication().canOpenURL(NSURL(string: "instagram://")!)
    }
    
    internal func writeTemporaryImage(image: UIImage!) throws -> Bool {
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            throw SharingFlowError.ImageJPEGRepresentationFailed
        }
        
        return imageData.writeToFile(imagePath, atomically: true)
    }
    
    /**
    Present the menu for sending image to Instagram app.
    - seealso: [SharingFlow Class Reference](https://github.com/JPMartha/EggsBenedict/blob/develop/Documentation/SharingFlowClassReference.md)
    - Parameters:
      - image: The image for sending to Instagram app.
      - view: The view from which to display the menu.
    */
    public func presentOpenInMenuWithImage(image: UIImage!, inView view: UIView!) {
        presentOpenInMenuWithImage(image, inView: view, documentInteractionDelegate: nil, completion: nil)
    }
    
    /**
    Present the menu for sending image to Instagram app.
    - seealso: [SharingFlow Class Reference](https://github.com/JPMartha/EggsBenedict/blob/develop/Documentation/SharingFlowClassReference.md)
    - Parameters:
      - image: The image for sending to Instagram app.
      - view: The view from which to display the menu.
      - delegate: The delegate you want to receive document interaction notifications. You may specify `nil` for this parameter.
    */
    public func presentOpenInMenuWithImage(image: UIImage!, inView view: UIView!, documentInteractionDelegate delegate: UIDocumentInteractionControllerDelegate?) {
        presentOpenInMenuWithImage(image, inView: view, documentInteractionDelegate: delegate, completion: nil)
    }
    
    /**
    Present the menu for sending image to Instagram app.
    - seealso: [SharingFlow Class Reference](https://github.com/JPMartha/EggsBenedict/blob/develop/Documentation/SharingFlowClassReference.md)
    - Parameters:
      - image: The image for sending to Instagram app.
      - view: The view from which to display the menu.
      - completion: The block to execute after the presenting menu. You may specify `nil` for this parameter.
    */
    public func presentOpenInMenuWithImage(image: UIImage!, inView view: UIView!, completion: ((sharingFlowResult: SharingFlowResult<String, ErrorType>) -> Void)?) {
        presentOpenInMenuWithImage(image, inView: view, documentInteractionDelegate: nil, completion: completion)
    }
    
    /**
    Present the menu for sending image to Instagram app.
    - seealso: [SharingFlow Class Reference](https://github.com/JPMartha/EggsBenedict/blob/develop/Documentation/SharingFlowClassReference.md)
    - Parameters:
      - image: The image for sending to Instagram app.
      - view: The view from which to display the menu.
      - delegate: The delegate you want to receive document interaction notifications. You may specify `nil` for this parameter.
      - completion: The block to execute after the presenting menu. You may specify `nil` for this parameter.
    */
    public func presentOpenInMenuWithImage(image: UIImage!, inView view: UIView!, documentInteractionDelegate delegate: UIDocumentInteractionControllerDelegate?, completion: ((sharingFlowResult: SharingFlowResult<String, ErrorType>) -> Void)?) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            guard self.hasInstagramApp else {
                completion?(sharingFlowResult: .Failure(self.imagePath, SharingFlowError.NotFoundInstagramApp))
                return
            }
            
            guard let UTI = self.UTI else {
                completion?(sharingFlowResult: .Failure(self.imagePath, SharingFlowError.UTIisEmpty))
                return
            }
            
            let result: Bool
            do {
                result = try self.writeTemporaryImage(image)
            } catch let errorType {
                completion?(sharingFlowResult: .Failure(self.imagePath, errorType))
                return
            }
            
            guard result else {
                completion?(sharingFlowResult: .Failure(self.imagePath, SharingFlowError.WriteToFileFailed))
                return
            }

            self.documentInteractionController.URL = NSURL.fileURLWithPath(self.imagePath)
            self.documentInteractionController.UTI = UTI
            self.documentInteractionController.delegate = delegate
            dispatch_async(dispatch_get_main_queue(), {
                self.documentInteractionController.presentOpenInMenuFromRect(
                    view.bounds,
                    inView: view,
                    animated: true
                )
                completion?(sharingFlowResult: .Success(self.imagePath))
            })
        })
    }
    
    /**
    Remove temporary image file in `tmp/" directory.
    - seealso: [SharingFlow Class Reference](https://github.com/JPMartha/EggsBenedict/blob/develop/Documentation/SharingFlowClassReference.md)
    */
    public func removeTemporaryImage() {
        removeTemporaryImage(completionHandler: nil)
    }
    
    /**
    Remove temporary image file in "tmp/" directory.
    - Parameter completion: The block to execute after the removing temporary image file finishes. You may specify nil for this parameter.
    - seealso: [SharingFlow Class Reference](https://github.com/JPMartha/EggsBenedict/blob/develop/Documentation/SharingFlowClassReference.md)
    */
    public func removeTemporaryImage(completionHandler completion: ((sharingFlowResult: SharingFlowResult<String, ErrorType>) -> Void)?) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            guard !self.imagePath.isEmpty else {
                completion?(sharingFlowResult: .Failure(self.imagePath, SharingFlowError.ImagePathIsEmpty))
                return
            }
            
            do {
                try NSFileManager().removeItemAtPath(self.imagePath)
            } catch let errorType {
                completion?(sharingFlowResult: .Failure(self.imagePath, errorType))
                return
            }
            completion?(sharingFlowResult: .Success(self.imagePath))
        })
    }
}
