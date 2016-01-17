//
//  SharingFlowResult.swift
//  EggsBenedict
//
//  Created by JPMartha on 2016/01/13.
//  Copyright © 2016 JPMartha. All rights reserved.
//

public enum SharingFlowResult<T, ErrorType> {
    case Success(T)
    case Failure(T, ErrorType)
}