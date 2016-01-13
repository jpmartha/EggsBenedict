# SharingFlow クラスリファレンス

### SharingFlow クラスのインスタンス作成

  - `init(type:)`

  ##### 宣言

  ```swift
  init(type: SharingFlowType)
  ```

  ##### パラメータ

  パラメータ | 説明
  -------------|---------------
  _type_       | `SharingFlowType` のタイプ

### メニューの表示

  - `presentOpenInMenuWithImage:inView:documentInteractionDelegate:completion:`

  Instagram アプリへ画像を渡すためのメニューを表示します。

  ##### 宣言

  ```swift
  func presentOpenInMenuWithImage(_ image: UIImage!,
      inView view: UIView!,
      documentInteractionDelegate delegate: UIDocumentInteractionControllerDelegate?,
      completion: ((result: Result<Any>) -> Void)?)
  ```

  ##### パラメータ

  パラメータ | 説明
  --------------|---------------
  _image_       | Instagram アプリに渡す画像です。
  _view_          | メニューを表示するビューです。
  _delegate_    | Document Interaction の通知を受け取りたい場合はデリゲートです。必要なければ `nil` を指定します。
  _completion_ | メニューを表示したあとに実行する完了ハンドラブロックです。必要なければ `nil` を指定します。

  ##### ディスカッション

  このメソッドは `hasInstagramApp` プロパティが `true` を返す場合に実行されます。メインスレッドをブロックしないよう Grand Central Dispatch (GCD) で非同期に実行されます。
  まず `tmp`フォルダに一時的な画像ファイルを書き込みます。画像データはバックアップファイルへの書き込みでエラーが発生しないことを確認したうえで指定された名前にリネームされます。画像ファイル名は `SharingFlowType` 列挙型のタイプに応じて `jpmarthaeggsbenedict.ig` または `jpmarthaeggsbenedict.igo` になります。詳しくは [NSData Class Reference](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/) を参照してください。
  
  そしてメインスレッドで `UIDocumentInteractionController` クラスのインスタンスの `presentOpenInMenuFromRect:inView:animated:` メソッドを呼びます。
  
  Document Interaction Controller で表示されたメニューのユーザー操作を把握するデリゲートオブジェクトを実装することができます。詳しくは [UIDocumentInteractionControllerDelegate Protocol Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIDocumentInteractionControllerDelegate_protocol/) を参照してください。
  
  完了ハンドラは `UIDocumentInteractionController` クラスのインスタンスの `presentOpenInMenuFromRect:inView:animated:` メソッドが呼ばれたあとに呼ばれます。

  > __[UIDocumentInteractionController Class Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIDocumentInteractionController_class/)__
  >
  > This method displays the options menu asynchronously. The document interaction controller dismisses the menu automatically when the user selects an appropriate option.

### 画像の削除

  - `removeTemporaryImage:`

  `tmp` フォルダに書き込んだ画像を削除します。

  ##### 宣言

  ```swift
  func removeTemporaryImage(completion: ((result: Result<Any>) -> Void)?)
  ```

  ##### パラメータ

  パラメータ | 説明
  --------------|---------------
  _completion_ | 画像を削除したあとに実行する完了ハンドラブロックです。必要なければ `nil` を指定します。

  ##### ディスカッション

  このライブラリは既存ファイルを上書きするため、通常はこのメソッドを使う必要がありません。

### Accessing the Device Attributes

  - `hasInstagramApp`

  iOS デバイスに Instagram アプリがインストールされているかどうかを示す `Bool` 型の値を返します。

  ##### 宣言

  ```swift
  var hasInstagramApp: Bool { get }
  ```

  ##### ディスカッション

  `true` を返す場合は iOS デバイスに Instagram アプリが存在し、そうでなければ存在しません。
