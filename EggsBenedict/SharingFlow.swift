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
    func writeTemporaryImage(_ image: UIImage!) throws -> Bool
    func presentOpenInMenuWithImage(_ image: UIImage!, inView view: UIView!, documentInteractionDelegate delegate: UIDocumentInteractionControllerDelegate?, completion: ((_ sharingFlowResult: SharingFlowResult) -> Void)?)
}

public final class SharingFlow: InstagramSharingFlow {
    public var filenameExtension: String!
    public var UTI: String!
    internal var imagePath: String!
    lazy fileprivate var documentInteractionController = UIDocumentInteractionController()

    public init(type: SharingFlowType) {
        switch type {
        case .igPhoto:
            self.filenameExtension = ".ig"
            self.UTI = "com.instagram.photo"
        case .igoExclusivegram:
            self.filenameExtension = ".igo"
            self.UTI = "com.instagram.exclusivegram"
        }
        let temporaryDirectory = NSTemporaryDirectory() as NSString
        self.imagePath = temporaryDirectory.appendingPathComponent("jpmarthaeggsbenedict\(filenameExtension)")
    }

    /**
    - seealso: [SharingFlow Class Reference](https://github.com/JPMartha/EggsBenedict/blob/develop/Documentation/SharingFlowClassReference.md)
    - returns: A Boolean value indicating whether or not Instagram app is installed on the iOS device.
    */
    public var hasInstagramApp: Bool {
        return UIApplication.shared.canOpenURL(URL(string: "instagram://")!)
    }
    
    internal func writeTemporaryImage(_ image: UIImage!) throws -> Bool {
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            throw SharingFlowError.imageJPEGRepresentationFailed
        }
        
        return ((try? imageData.write(to: URL(fileURLWithPath: imagePath), options: [.atomic])) != nil)
    }
    
    /**
    Present the menu for sending image to Instagram app.
    - seealso: [SharingFlow Class Reference](https://github.com/JPMartha/EggsBenedict/blob/develop/Documentation/SharingFlowClassReference.md)
    - Parameters:
      - image: The image for sending to Instagram app.
      - view: The view from which to display the menu.
    */
    public func presentOpenInMenuWithImage(_ image: UIImage!, inView view: UIView!) {
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
    public func presentOpenInMenuWithImage(_ image: UIImage!, inView view: UIView!, documentInteractionDelegate delegate: UIDocumentInteractionControllerDelegate?) {
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
    public func presentOpenInMenuWithImage(_ image: UIImage!, inView view: UIView!, completion: ((_ sharingFlowResult: SharingFlowResult) -> Void)?) {
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
    public func presentOpenInMenuWithImage(_ image: UIImage!, inView view: UIView!, documentInteractionDelegate delegate: UIDocumentInteractionControllerDelegate?, completion: ((_ sharingFlowResult: SharingFlowResult) -> Void)?) {
        
        DispatchQueue.global().async {
            guard self.hasInstagramApp else {
                completion?(.failure(self.imagePath, SharingFlowError.notFoundInstagramApp))
                return
            }
            
            guard let UTI = self.UTI else {
                completion?(.failure(self.imagePath, SharingFlowError.utIisEmpty))
                return
            }
            
            let result: Bool
            do {
                result = try self.writeTemporaryImage(image)
            } catch let errorType {
                completion?(.failure(self.imagePath, errorType))
                return
            }
            
            guard result else {
                completion?(.failure(self.imagePath, SharingFlowError.writeToFileFailed))
                return
            }
            
            self.documentInteractionController.url = URL(fileURLWithPath: self.imagePath)
            self.documentInteractionController.uti = UTI
            self.documentInteractionController.delegate = delegate
            DispatchQueue.main.async(execute: {
                self.documentInteractionController.presentOpenInMenu(
                    from: view.bounds,
                    in: view,
                    animated: true
                )
                completion?(.success(self.imagePath))
            })
        }
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
    public func removeTemporaryImage(completionHandler completion: ((_ sharingFlowResult: SharingFlowResult) -> Void)?) {
        
        DispatchQueue.global().async {
            guard !self.imagePath.isEmpty else {
                completion?(.failure(self.imagePath, SharingFlowError.imagePathIsEmpty))
                return
            }
            
            do {
                try FileManager().removeItem(atPath: self.imagePath)
            } catch let errorType {
                completion?(.failure(self.imagePath, errorType))
                return
            }
            completion?(.success(self.imagePath))
        }
    }
}
