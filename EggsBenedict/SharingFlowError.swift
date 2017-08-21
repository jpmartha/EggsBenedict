//
//  SharingFlowError.swift
//  EggsBenedict
//
//  Created by JPMartha on 2016/01/13.
//  Copyright © 2016 JPMartha. All rights reserved.
//

public enum SharingFlowError: Error, CustomDebugStringConvertible {

    case notFoundInstagramApp
    case utIisEmpty
    case imageJPEGRepresentationFailed
    case writeToFileFailed
    case imagePathIsEmpty
    
    public var debugDescription: String {
        switch self {
        case .notFoundInstagramApp:
            return "Not found Instagram app."
        case .utIisEmpty:
            return "UTI is empty."
        case .imageJPEGRepresentationFailed:
            return "\"UIImageJPEGRepresentation::\" method failed."
        case .writeToFileFailed:
            return "\"writeToFile:atomically:\" method failed."
        case .imagePathIsEmpty:
            return "ImagePath is empty."
        }
    }
}
