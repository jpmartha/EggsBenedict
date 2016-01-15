//
//  SharingFlowResult.swift
//  EggsBenedict
//
//  Created by JPMartha on 2016/01/13.
//  Copyright © 2016 JPMartha. All rights reserved.
//

/**
`.Success(T)`

`.Failure(T, U)`
*/
public enum SharingFlowResult<T, U> {
    case Success(T)
    case Failure(T, U)
}
