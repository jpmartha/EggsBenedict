# EggsBenedict
[![Build Status](https://travis-ci.org/JPMartha/EggsBenedict.svg)](https://travis-ci.org/JPMartha/EggsBenedict) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) → [English](../README.md)

__EggsBenedict__ は Swift で Instagram アプリに画像を渡すためのライブラリです。

<img src="./Images/EggsBenedict.gif" width=272>

このライブラリは Instagram ドキュメントに記載されている手順に従います。

> __Instagram ドキュメント__

> - [Document Interaction](https://www.instagram.com/developer/mobile-sharing/iphone-hooks/#document-interaction)

ユーザーの iOS デバイス上でカスタム URL スキーム `instagram:// ` を開くことができる場合に次の手順を実行します。

1. JPEG 形式で `"jpmarthaeggsbenedict"` という名前と拡張子 `".ig"` または `".igo"` を付けて tmp フォルダに書き込みます。
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

このライブラリは [Carthage](https://github.com/Carthage/Carthage) を使用することができます。

1. [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile) を作成し、`github "JPMartha/EggsBenedict" ~> 0.9.5` と追記します。
2. `carthage update --platform iOS` を実行します。
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

## はじめ方

1. Xcode プロジェクトの Info.plist に `LSApplicationQueriesSchemes` キーを追加します。

  Key                                           |Type    |Value
  ------------------------------------|--------|-----------
  LSApplicationQueriesSchemes | Array | instagram

2. `SharingFlowType` を指定して `SharingFlow` クラスのインスタンスを作成します。
  
  ```swift
  let sharingFlow = SharingFlow(type: .IGOExclusivegram)
  ```
  
  #### SharingFlowType 列挙型

  [Instagramドキュメント](https://www.instagram.com/developer/mobile-sharing/iphone-hooks/#document-interaction)によると、Instagram アプリへ画像を渡す方法は2種類あります。`SharingFlowType` はそれらに従った列挙型です。

  - `IGPhoto`
  
    Instagram アプリと public/jpeg に対応したほかのアプリが表示されます。

  - `IGOExclusivegram` （オススメ）
  
    Instagram アプリだけが表示されます。（ドキュメントにはそのように記載されていますが実際にはいくつか表示されます）

3. `presentOpenInMenuWithImage` メソッドを呼びます。必須のパラメータが2つ、任意のパラメータが2つあります。

  ```swift
  sharingFlow.presentOpenInMenuWithImage(YourImage, view: YourView, documentInteractionControllerDelegate: nil) { (result) -> Void in
      // エラー処理
  }
  ```
  
  #### パラメータ
  
  - image: `UIImage!`
  
    Instagram アプリに渡す画像です。
    
  - view: `UIView!`
  
    メニューを表示するビューです。
    
  - documentInteractionControllerDelegate: `UIDocumentInteractionControllerDelegate?`
  
    Document Interaction の通知を受け取りたい場合はデリゲートを設定します。必要なければ `nil` を指定します。
    
  - completion: `((result: Result<Any>) -> Void)?`
  
    メニューを表示したあとに実行するブロックです。必要なければ `nil` を指定します。
    
    - エラー処理の例
    
      ```swift
      switch result {
      case .Success(let imagePath):
          print("Success: \(imagePath)")
      case .Failure(let error):
          print("Error: \(error)")
      }
      ```

## 画像の削除

tmp フォルダに保存した画像を削除するには作成したインスタンスの `removeTemporaryImage` メソッドを呼びます。

  ```swift
  sharingFlow.removeTemporaryImage { (result) -> Void in
      // エラー処理
  }
  ```
  
#### パラメータ
  
  - completion: `((result: Result<Any>) -> Void)?`
  
    画像を削除したあとに実行するブロックです。必要なければ `nil` を指定します。
    
    - エラー処理の例
    
      ```swift
      switch result {
      case .Success(let imagePath):
          print("Success: \(imagePath)")
      case .Failure(let error):
          print("Error: \(error)")
      }
      ```

## ライセンス

__EggsBenedict__ は [MIT License](LICENSE) でリリースしています。
