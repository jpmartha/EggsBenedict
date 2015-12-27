# SharingOnInstagram

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

ShareOnInstagram is a library for sharing photo on Instagram in Swift.

Open your photo in Instagram's sharing flow.
> [Document Interaction](https://www.instagram.com/developer/mobile-sharing/iphone-hooks/#document-interaction)

## Requirements

- Swift 2.1 / Xcode 7.2
- iOS 8.0 or later

## Usage

- Insert `LSApplicationQueriesSchemes` to `Info.plist`
  - Type: `Array`
  - Value: `instagram`
  
## Enumerations

### InstagramFileType

1. `IGPhoto`
> You must first save your file in PNG or JPEG (preferred) format and use the filename extension ".ig". Using the iOS Document Interaction APIs you can trigger the photo to be opened by Instagram. The Identifier for our Document Interaction UTI is com.instagram.photo, and it conforms to the public/jpeg and public/png UTIs.

2. `IGOExclusivegram`
> Alternatively, if you want to show only Instagram in the application list (instead of Instagram plus any other public/jpeg-conforming apps) you can specify the extension class igo, which is of type com.instagram.exclusivegram.

## License

SharingOnInstagram is released under the [MIT License](LICENSE.md).


