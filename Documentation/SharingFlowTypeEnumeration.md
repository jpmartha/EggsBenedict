# SharingFlowType Enumeration

You can use two ways in Instagram's sharing flow. The `SharingFlowType` is the enumeration following them. For more information, see [Instagram's documentation](https://www.instagram.com/developer/mobile-sharing/iphone-hooks/#document-interaction).

##### Declaration

```swift
enum SharingFlowType {
    case IGPhoto
    case IGOExclusivegram
}
```

##### Constants

- `IGPhoto`

  Show Instagram plus any other public/jpeg-conforming apps in the application list.

- `IGOExclusivegram` (preferred)

  Show only Instagram in the application list. (Actually, some apps are shown.)
