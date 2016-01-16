//
//  SharingFlowError.swift
//  EggsBenedict
//
//  Created by JPMartha on 2016/01/13.
//  Copyright © 2016 JPMartha. All rights reserved.
//

public enum SharingFlowError: ErrorType, CustomDebugStringConvertible {
    case NotFoundInstagramApp
    case UTIisEmpty
    case ImageJPEGRepresentationFailed
    case WriteToFileFailed
    case ImagePathIsEmpty
    
    public var debugDescription: String {
        switch self {
        case .NotFoundInstagramApp:
            return "Not found Instagram app."
        case .UTIisEmpty:
            return "UTI is empty."
        case .ImageJPEGRepresentationFailed:
            return "\"UIImageJPEGRepresentation::\" method failed."
        case .WriteToFileFailed:
            return "\"writeToFile:atomically:\" method failed."
        case .ImagePathIsEmpty:
            return "ImagePath is empty."
        }
    }
}
