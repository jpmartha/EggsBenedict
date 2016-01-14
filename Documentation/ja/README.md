# EggsBenedict

[![Build Status](https://travis-ci.org/JPMartha/EggsBenedict.svg)](https://travis-ci.org/JPMartha/EggsBenedict) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [English](https://github.com/JPMartha/EggsBenedict)

__EggsBenedict__ は Swift で Instagram アプリに画像を渡すためのライブラリです。

<img src="../Images/EggsBenedict.gif" width=272>

このライブラリは Instagram ドキュメントに記載されている手順に従います。

> __Instagram ドキュメント__

> - [Document Interaction](https://www.instagram.com/developer/mobile-sharing/iphone-hooks/#document-interaction)

ユーザーの iOS デバイス上でカスタム URL スキーム `instagram:// ` を開くことができる場合に次の手順を実行します。

1. JPEG 形式で `jpmarthaeggsbenedict` という名前と拡張子 `.ig` または `.igo` を付けて `tmp/` フォルダに書き込みます。
2. Instagram アプリへコピーするためのメニューを表示します。
3. 「Instagram にコピー」アイコンをタップすると Instagram アプリが起動してフィルタ画面に遷移します。

  画像は640ピクセルの正方形で JPEG 形式が最適だとドキュメントに記載されています。
  
  > The image is preloaded and sized appropriately for Instagram. For best results, Instagram prefers opening a JPEG that is 640px by 640px square. If the image is larger, it will be resized dynamically.

#### _\- ところでなんで EggsBenedict って名前やねん？_

エッグベネディクトが好きだからです😋

## 必要条件

- Swift 2.1
- Xcode 7.2
- iOS 8.0 以降

## Xcodeプロジェクトに EggsBenedict.framework を追加

#### [Carthage](https://github.com/Carthage/Carthage) （オススメ）

1. [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile) を作成し、`github "JPMartha/EggsBenedict" ~> 0.9.8` を追記します。
2. プロジェクトのフォルダで `$ carthage update --platform iOS` を実行します。
3. TARGETS の「Build Phases」にある「Link Binary With Libraries」の「+」アイコンをクリックして Carthage/Build フォルダから `EggsBenedict.framework` を追加します。
4. TARGETS の「Build Phases」にある「+」アイコンをクリックして「New Run Script Phase」を選択し Run Script に次の内容を入力します。
  ```
  /usr/local/bin/carthage copy-frameworks
  ```
  「Input Files」に EggsBenedict.framework のパスを追加します。
  ```
  $(SRCROOT)/Carthage/Build/iOS/EggsBenedict.framework
  ```
  このスクリプトは [App Store へ提出時のバグ](http://www.openradar.me/radar?id=6409498411401216) を回避します。
  
  > This script works around an [App Store submission bug](http://www.openradar.me/radar?id=6409498411401216) triggered by universal binaries and ensures that necessary bitcode-related files are copied when archiving.

#### [CocoaPods](https://cocoapods.org)

1. [Podfile](https://guides.cocoapods.org/using/the-podfile.html) を作成し、次の内容を入力します。

  ```
  use_frameworks!
  pod 'EggsBenedict', '~> 0.9.8'
  ```

2. プロジェクトのフォルダで `$ pod install` を実行します。

## はじめ方

1. Xcode プロジェクトの Info.plist に `LSApplicationQueriesSchemes` キーを追加します。

  Key                                           |Type    |Value
  ------------------------------------|--------|-----------
  LSApplicationQueriesSchemes | Array | instagram

2. `SharingFlowType` 列挙型のタイプを指定して `SharingFlow` クラスのインスタンスを作成します。
  
  ```swift
  let sharingFlow = SharingFlow(type: .IGOExclusivegram)
  ```
  
  詳しくは [SharingFlow クラスリファレンス](./Documentation/SharingFlowClassReference.md) と [SharingFlowType 列挙型](./Documentation/SharingFlowTypeEnumeration.md) を参照してください。

3. 作成したインスタンスの `presentOpenInMenuWithImage:inView:` メソッドを呼びます。
    
  詳しくは [SharingFlow クラスリファレンス](./Documentation/SharingFlowClassReference.md) を参照してください。

## ドキュメント

- [EggsBenedict フレームワークリファレンス](./Documentation)

## ライセンス

__EggsBenedict__ は [MIT License](LICENSE) の下に提供されています。
