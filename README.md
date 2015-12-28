# EggsBenedict (Coming soon)

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

__EggsBenedict__ is a library for sharing picture on Instagram in Swift.

This library is following Instagram's sharing flow.

> Instagram's documentation

> - [Document Interaction](https://www.instagram.com/developer/mobile-sharing/iphone-hooks/#document-interaction)

_\- Why was it named "EggsBenedict"?_

The reason is because I like Eggs Benedict.

## Availability

- Swift 2.1
- Xcode 7.2
- iOS 8.0 and later

## Adding EggsBenedict.framework to your project

This library can be used with [Carthage](https://github.com/Carthage/Carthage).

If you don't install Carthage, please install it.

#### Getting started

1. Create a [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile) and add `github "JPMartha/EggsBenedict" ~> 0.9.0`.
2. Run `carthage update --platform iOS`.
3. On your application targets’ “Build Phases” settings tab, in the “Link Binary With Libraries” section, click the “+” icon and add `EggsBenedict.framework` from the Carthage/Build folder on disk.
4. On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following contents: 
  ```
  /usr/local/bin/carthage copy-frameworks
  ```
  and add the paths to EggsBenedict.framework:
  ```
  $(SRCROOT)/Carthage/Build/iOS/EggsBenedict.framework`
  ```
  
  This script works around an [App Store submission bug](http://www.openradar.me/radar?id=6409498411401216) triggered by universal binaries and ensures that necessary bitcode-related files are copied when archiving.

## Usage

1. On your application Info.plist, add `LSApplicationQueriesSchemes` key.

  Key                                           |Type    |Value
  ------------------------------------|--------|-----------
  LSApplicationQueriesSchemes | Array | instagram

2. Create an instance of `SharingFlow` class with `SharingFlowType` enumeration. 

  ```swift
  let eggsBenedict = SharingFlow(type: .IGOExclusivegram)
  ```
  
  #### SharingFlowType enumeration

  According to the [Instagram's documentation](https://www.instagram.com/developer/mobile-sharing/iphone-hooks/#document-interaction), you can use two ways in Instagram's sharing flow.

  - `IGPhoto`
  
    Show Instagram plus any other public/jpeg-conforming apps in the application list.

  - `IGOExclusivegram`
  
    Show only Instagram in the application list. (Actually, some apps are shown.)

3. Call `sendImage` method with two parameters.

  ```swift
  eggsBenedict.sendImage(YourImage, view: YourView)
  ```
  
  #### Parameters
  
  - image: `UIImage`
  
    The image for sending to Instagram app.
    
  - view: `UIView`
  
    The view from which to display the options menu.

## License

__EggsBenedict__ is released under the [MIT License](LICENSE).
