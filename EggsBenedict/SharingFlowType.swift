//
//  SharingFlowType.swift
//  EggsBenedict
//
//  Created by JPMartha on 2016/01/13.
//  Copyright © 2016 JPMartha. All rights reserved.
//

/**
A type of Instagram's sharing flow.
- seealso: [SharingFlowType Enumeration](https://github.com/JPMartha/EggsBenedict/blob/develop/Documentation/SharingFlowTypeEnumeration.md)
- `IGPhoto`: Show Instagram plus any other public/jpeg-conforming apps in the application list.
- `IGOExclusivegram` __(preferred)__: Show only Instagram in the application list. (Actually, some apps are shown.)
*/
public enum SharingFlowType {
    case igPhoto
    case igoExclusivegram
}
