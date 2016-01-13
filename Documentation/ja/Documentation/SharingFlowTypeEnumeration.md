# SharingFlowType 列挙型

Instagram アプリへ画像を渡す方法は2種類あります。`SharingFlowType` はそれらに従った列挙型です。詳しくは [Instagram's documentation](https://www.instagram.com/developer/mobile-sharing/iphone-hooks/#document-interaction)（英語）を参照してください。

##### 宣言

```swift
enum SharingFlowType {
    case IGPhoto
    case IGOExclusivegram
}
```

##### 定数

- `IGPhoto`
  
  Instagram アプリと public/jpeg に対応したほかのアプリが表示されます。

- `IGOExclusivegram` （オススメ）

  Instagram アプリだけが表示されます。（ドキュメントにはそのように記載されていますが実際にはいくつか表示されます）
