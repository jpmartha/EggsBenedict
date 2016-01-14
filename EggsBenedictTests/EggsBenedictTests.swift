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
        XCTAssert(sharingFlow.filenameExtension == ".ig")
        XCTAssert(sharingFlow.UTI == "com.instagram.photo")
    }
    
    func testInitSharingFlowIGOExclusivegram() {
        let sharingFlow = SharingFlow(type: .IGOExclusivegram)
        XCTAssert(sharingFlow.filenameExtension == ".igo")
        XCTAssert(sharingFlow.UTI == "com.instagram.exclusivegram")
    }
    
    func testHasInstagramApp() {
        let result = UIApplication.sharedApplication().canOpenURL(NSURL(string: "instagram://")!)
        let sharingFlow = SharingFlow(type: .IGOExclusivegram)
        XCTAssertEqual(sharingFlow.hasInstagramApp, result)
    }

    func testSaveAndRemoveTemporaryImage() {
        guard let image = UIImage(named: "EggsBenedict.jpg", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil) else {
            XCTFail("Image is nil.")
            return
        }
        
        let sharingFlow = SharingFlow(type: .IGOExclusivegram)
        var imagePath: String
        do {
            imagePath = try sharingFlow.saveTemporaryImage(image)
        } catch {
            XCTFail("Cannot save image.")
            return
        }
        XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(imagePath))
        
        sharingFlow.removeTemporaryImage { (result) -> Void in
            switch result {
            case .Success(let imagePath as String):
                XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(imagePath))
            case .Failure(let error):
                XCTFail("Error: \(error)")
            default:
                XCTFail()
            }
        }
    }
}
