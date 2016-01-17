//
//  EggsBenedictTests.swift
//  EggsBenedictTests
//
//  Created by JPMartha on 2015/12/28.
//  Copyright © 2015 JPMartha. All rights reserved.
//

import XCTest
@testable import EggsBenedict

class EggsBenedictTests: XCTestCase {
    
    func testInitSharingFlowIGPhoto() {
        let sharingFlow = SharingFlow(type: .IGPhoto)
        XCTAssertEqual(sharingFlow.filenameExtension, ".ig")
        XCTAssertEqual(sharingFlow.UTI,"com.instagram.photo")
        let temporaryDirectory = NSTemporaryDirectory() as NSString
        XCTAssertEqual(sharingFlow.imagePath, temporaryDirectory.stringByAppendingPathComponent("jpmarthaeggsbenedict.ig"))
    }
    
    func testInitSharingFlowIGOExclusivegram() {
        let sharingFlow = SharingFlow(type: .IGOExclusivegram)
        XCTAssertEqual(sharingFlow.filenameExtension,".igo")
        XCTAssertEqual(sharingFlow.UTI, "com.instagram.exclusivegram")
        let temporaryDirectory = NSTemporaryDirectory() as NSString
        XCTAssertEqual(sharingFlow.imagePath, temporaryDirectory.stringByAppendingPathComponent("jpmarthaeggsbenedict.igo"))
    }
    
    func testHasInstagramApp() {
        let result = UIApplication.sharedApplication().canOpenURL(NSURL(string: "instagram://")!)
        let sharingFlow = SharingFlow(type: .IGOExclusivegram)
        XCTAssertEqual(sharingFlow.hasInstagramApp, result)
    }
    
    func testWriteTemporaryImageIGPhoto() {
        guard let image = UIImage(named: "EggsBenedict.jpg", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil) else {
            XCTFail("Image is nil.")
            return
        }
        
        let sharingFlow = SharingFlow(type: .IGPhoto)
        do {
            try sharingFlow.writeTemporaryImage(image)
        } catch let error as NSError {
            XCTFail(error.debugDescription)
            return
        }
        let temporaryDirectory = NSTemporaryDirectory() as NSString
        let testImagePath = temporaryDirectory.stringByAppendingPathComponent("jpmarthaeggsbenedict.ig")
        XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(testImagePath), testImagePath)
    }
    
    func testWriteTemporaryImageIGOExclusivegram() {
        guard let image = UIImage(named: "EggsBenedict.jpg", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil) else {
            XCTFail("Image is nil.")
            return
        }
        
        let sharingFlow = SharingFlow(type: .IGOExclusivegram)
        do {
            try sharingFlow.writeTemporaryImage(image)
        } catch let error as NSError {
            XCTFail(error.debugDescription)
            return
        }
        let temporaryDirectory = NSTemporaryDirectory() as NSString
        let testImagePath = temporaryDirectory.stringByAppendingPathComponent("jpmarthaeggsbenedict.igo")
        XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(testImagePath), testImagePath)
    }
    
    func testWriteTemporaryImageNil() {
        let sharingFlow = SharingFlow(type: .IGOExclusivegram)
        do {
            try sharingFlow.writeTemporaryImage(UIImage())
        } catch let sharingFlowError as SharingFlowError {
            XCTAssertEqual(sharingFlowError, SharingFlowError.ImageJPEGRepresentationFailed)
            return
        } catch let error as NSError {
            XCTFail(error.debugDescription)
            return
        }
        XCTFail("An unknown error occurred.")
    }
    
    func testPresentOpenInMenuWithImageInViewCompletion() {
        let sharingFlow = SharingFlow(type: .IGOExclusivegram)
        sharingFlow.presentOpenInMenuWithImage(UIImage(), inView: UIView()) { (sharingFlowResult) -> Void in
            switch sharingFlowResult {
            case .Success(_):
                XCTFail()
            case let .Failure(_, sharingFlowError as SharingFlowError):
                XCTAssertEqual(sharingFlowError, SharingFlowError.NotFoundInstagramApp)
            case let .Failure(_, error as NSError):
                XCTFail(error.debugDescription)
            default:
                XCTFail("An unknown error occurred.")
            }
        }
    }
    
    func testPresentOpenInMenuWithImageInViewDocumentInteractionDelegateCompletion() {
        let sharingFlow = SharingFlow(type: .IGOExclusivegram)
        sharingFlow.presentOpenInMenuWithImage(UIImage(), inView: UIView(), documentInteractionDelegate: nil) { (sharingFlowResult) -> Void in
            switch sharingFlowResult {
            case .Success(_):
                XCTFail()
            case let .Failure(_, sharingFlowError as SharingFlowError):
                XCTAssertEqual(sharingFlowError, SharingFlowError.NotFoundInstagramApp)
            case let .Failure(_, error as NSError):
                XCTFail(error.debugDescription)
            default:
                XCTFail("An unknown error occurred.")
            }
        }
    }
    
    func testRemoveTemporaryImageIG() {
        guard let image = UIImage(named: "EggsBenedict.jpg", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil) else {
            XCTFail("Image is nil.")
            return
        }
        
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            XCTFail(SharingFlowError.ImageJPEGRepresentationFailed.debugDescription)
            return
        }
        
        let temporaryDirectory = NSTemporaryDirectory() as NSString
        let testImagePath = temporaryDirectory.stringByAppendingPathComponent("jpmarthaeggsbenedict.ig")
        guard imageData.writeToFile(testImagePath, atomically: true) else {
            XCTFail(SharingFlowError.WriteToFileFailed.debugDescription)
            return
        }
        
        let sharingFlow = SharingFlow.init(type: .IGPhoto)
        sharingFlow.removeTemporaryImage { (sharingFlowResult) -> Void in
            XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(testImagePath), testImagePath)
        }
    }
    
    func testRemoveTemporaryImageIGO() {
        guard let image = UIImage(named: "EggsBenedict.jpg", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil) else {
            XCTFail("Image is nil.")
            return
        }
        
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            XCTFail(SharingFlowError.ImageJPEGRepresentationFailed.debugDescription)
            return
        }
        
        let temporaryDirectory = NSTemporaryDirectory() as NSString
        let testImagePath = temporaryDirectory.stringByAppendingPathComponent("jpmarthaeggsbenedict.igo")
        guard imageData.writeToFile(testImagePath, atomically: true) else {
            XCTFail(SharingFlowError.WriteToFileFailed.debugDescription)
            return
        }
        
        let sharingFlow = SharingFlow.init(type: .IGOExclusivegram)
        sharingFlow.removeTemporaryImage { (sharingFlowResult) -> Void in
            XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(testImagePath), testImagePath)
        }
    }
    
    func testSharingFlowErrorDebugDescriptionNotFoundInstagramApp() {
        XCTAssertEqual(SharingFlowError.NotFoundInstagramApp.debugDescription,
            "Not found Instagram app.")
    }
    
    func testSharingFlowErrorDebugDescriptionUTIisEmpty() {
        XCTAssertEqual(SharingFlowError.UTIisEmpty.debugDescription,
            "UTI is empty.")
    }
    
    func testSharingFlowErrorDebugDescriptionImageJPEGRepresentationFailed() {
        XCTAssertEqual(SharingFlowError.ImageJPEGRepresentationFailed.debugDescription,
            "\"UIImageJPEGRepresentation::\" method failed.")
    }
    
    func testSharingFlowErrorDebugDescriptionWriteToFileFailed() {
        XCTAssertEqual(SharingFlowError.WriteToFileFailed.debugDescription,
            "\"writeToFile:atomically:\" method failed.")
    }
    
    func testSharingFlowErrorDebugDescriptionImagePathIsEmpty() {
        XCTAssertEqual(SharingFlowError.ImagePathIsEmpty.debugDescription,
            "ImagePath is empty.")
    }
}
