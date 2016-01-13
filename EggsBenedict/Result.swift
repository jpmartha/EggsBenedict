//
//  Result.swift
//  EggsBenedict
//
//  Created by JPMartha on 2016/01/13.
//  Copyright © 2016年 JPMartha. All rights reserved.
//

public enum Result<T> {
    case Success(T)
    case Failure(T)
}
