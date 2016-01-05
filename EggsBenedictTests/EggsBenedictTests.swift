//
//  EggsBenedictTests.swift
//  EggsBenedictTests
//
//  Created by JPMartha on 2015/12/28.
//  Copyright © 2015年 JPMartha. All rights reserved.
//

import XCTest
@testable import EggsBenedict

class EggsBenedictTests: XCTestCase {
    
    func testSharingFlowIGPhotoInit() {
        let sharingFlow = SharingFlow(type: .IGPhoto)
        XCTAssert(sharingFlow.filenameExtension == ".ig")
        XCTAssert(sharingFlow.UTI == "com.instagram.photo")
    }
    
    func testSharingFlowIGOExclusivegramInit() {
        let sharingFlow = SharingFlow(type: .IGOExclusivegram)
        XCTAssert(sharingFlow.filenameExtension == ".igo")
        XCTAssert(sharingFlow.UTI == "com.instagram.exclusivegram")
    }
    
    func testHasInstagramApp() {
        let result = UIApplication.sharedApplication().canOpenURL(NSURL(string: "instagram://")!)
        let sharingFlow = SharingFlow(type: .IGOExclusivegram)
        XCTAssertEqual(sharingFlow.hasInstagramApp, result)
    }
    
    func testTemporaryImageIGPhoto() {
        let sharingFlow = SharingFlow(type: .IGPhoto)
        let imagePath: String
        do {
            imagePath = try sharingFlow.saveTemporaryImage(UIImage(named: "EggsBenedict"))
        } catch {
            return
        }
        
        XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(imagePath))
        
        sharingFlow.removeTemporaryImage { (result) -> Void in
            switch result {
            case .Success(let imagePath as String):
                XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(imagePath))
            default:
                break
            }
        }
    }
    
    func testTemporaryImageIGOExclusivegram() {
        let sharingFlow = SharingFlow(type: .IGOExclusivegram)
        let imagePath: String
        do {
            imagePath = try sharingFlow.saveTemporaryImage(UIImage(named: "EggsBenedict"))
        } catch {
            return
        }
        
        XCTAssertTrue(NSFileManager.defaultManager().fileExistsAtPath(imagePath))
        
        sharingFlow.removeTemporaryImage { (result) -> Void in
            switch result {
            case .Success(let imagePath as String):
                XCTAssertFalse(NSFileManager.defaultManager().fileExistsAtPath(imagePath))
            default:
                break
            }
        }
    }
}
