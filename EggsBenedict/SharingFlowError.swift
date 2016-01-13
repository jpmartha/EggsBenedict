//
//  SharingFlowError.swift
//  EggsBenedict
//
//  Created by JPMartha on 2016/01/13.
//  Copyright © 2016年 JPMartha. All rights reserved.
//

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
