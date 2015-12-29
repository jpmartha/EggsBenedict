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
    
    func testSharingFlowIGPhotoInitialization() {
        let sharingFlow = SharingFlow(type: .IGPhoto)
        XCTAssert(sharingFlow?.filenameExtension == ".ig")
        XCTAssert(sharingFlow?.UTI == "com.instagram.photo")
    }
    
    func testSharingFlowIGOExclusivegramInitialization() {
        let sharingFlow = SharingFlow(type: .IGOExclusivegram)
        XCTAssert(sharingFlow?.filenameExtension == ".igo")
        XCTAssert(sharingFlow?.UTI == "com.instagram.exclusivegram")
    }
}
