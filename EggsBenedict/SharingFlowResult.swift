//
//  SharingFlowResult.swift
//  EggsBenedict
//
//  Created by JPMartha on 2016/01/13.
//  Copyright © 2016 JPMartha. All rights reserved.
//

/**
`SharingFlowResult`
*/
public enum SharingFlowResult<T> {
    case Success(T)
    case Failure(T)
}
