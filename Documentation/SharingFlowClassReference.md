# SharingFlow Class Reference

### Creating an Instance

  - `init(type:)`
  
  ##### Declaration
  
  ```swift
  init(type: SharingFlowType)
  ```
  
  ##### Parameters

  Parameter   | Description
  --------------|---------------
  _type_         | A type of `SharingFlowType`
  
   For more information, see [SharingFlowType Enumeration](./SharingFlowTypeEnumeration.md).
  
==

### Presenting Menus

  - `presentOpenInMenuWithImage:inView:`

  Present the menu for sending image to Instagram app.
  
  ##### Declaration
  
  ```swift
  func presentOpenInMenuWithImage(_ image: UIImage!, inView view: UIView!)
  ```
  
  ##### Discussion
  
  This method calls the `presentOpenInMenuWithImage:inView:documentInteractionDelegate:completion:` method setting the `delegate` parameter and the `completion` parameter `nil`.

==

  - `presentOpenInMenuWithImage:inView:documentInteractionDelegate:`
  
  Present the menu for sending image to Instagram app.
  
  ##### Declaration
  
  ```swift
  func presentOpenInMenuWithImage(_ image: UIImage!,
      inView view: UIView!,
      documentInteractionDelegate delegate: UIDocumentInteractionControllerDelegate?)
  ```
  
  ##### Discussion
  
  This method calls the `presentOpenInMenuWithImage:inView:documentInteractionDelegate:completion:` method setting the `completion` parameter `nil`.
   
==

  - `presentOpenInMenuWithImage:inView:completion:`
  
  Present the menu for sending image to Instagram app.
  
  ##### Declaration
  
  ```swift
  func presentOpenInMenuWithImage(_ image: UIImage!,
      inView view: UIView!,
      completion: ((sharingFlowResult: SharingFlowResult<Any>) -> Void)?)
  ```
  
  ##### Discussion
  
  This method calls the `presentOpenInMenuWithImage:inView:documentInteractionDelegate:completion:` method setting the `delegate` parameter `nil`.
  
==

  - `presentOpenInMenuWithImage:inView:documentInteractionDelegate:completion:`
  
  Present the menu for sending image to Instagram app.
  
  ##### Declaration
  
  ```swift
  func presentOpenInMenuWithImage(_ image: UIImage!,
      inView view: UIView!,
      documentInteractionDelegate delegate: UIDocumentInteractionControllerDelegate?,
      completion: ((sharingFlowResult: SharingFlowResult<Any>) -> Void)?)
  ```
  
  ##### Parameters
  
  Parameter   | Description
  --------------|---------------
  _image_       | The image for sending to Instagram app.
  _view_          | The view from which to display the menu.
  _delegate_    | The delegate you want to receive document interaction notifications. You may specify `nil` for this parameter.
  _completion_ | The block to execute after the presenting menu. You may specify `nil` for this parameter.
  
  ##### Discussion

  This method is invoked if the `hasInstagramApp` property is `true`. To avoid blocking the main thread, it is invoked asynchronously with Grand Central Dispatch (GCD). 
  
  First, write a temporary image file in `tmp/` directory. The image data is written to a backup file, and then—assuming no errors occur—the backup file is renamed to the name specified by path. The image file is named `jpmarthaeggsbenedict.ig` or `jpmarthaeggsbenedict.igo` according to the `SharingFlowType` enumeration. For more information, see [NSData Class Reference](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/).
  
  Then, call the `presentOpenInMenuFromRect:inView:animated:` method of an instance of the `UIDocumentInteractionController` class in main thread.
  
  You can implement a delegate object to track user interactions with menu items displayed by the document interaction controller. For more information, see [UIDocumentInteractionControllerDelegate Protocol Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIDocumentInteractionControllerDelegate_protocol/).
  
  The completion handler is called after the `presentOpenInMenuFromRect:inView:animated:` method is called of an instance of the `UIDocumentInteractionController` class.
  
  > __[UIDocumentInteractionController Class Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIDocumentInteractionController_class/)__
  >
  > This method displays the options menu asynchronously. The document interaction controller dismisses the menu automatically when the user selects an appropriate option.
  
  ##### Handling Errors Example
  
  The following example ?? the `SharingFlowResult` enumeration at?? the completion handler.
  If `Success` ?? the path temporary image file path was written.
      
  ```swift
  sharingFlow.presentOpenInMenuWithImage(YourImage, inView view: YourView, documentInteractionDelegate: nil) { (sharingFlowResult) -> Void in
      switch sharingFlowResult {
      case .Success(let imagePath):
          print("Success: \(imagePath)")
      case .Failure(let error):
          print("Error: \(error)")
      }
  }
  ```

==

### Removing Temporary Image

  - `removeTemporaryImage`

  Remove temporary image file in `tmp/` directory.

  ##### Declaration

  ```swift
  func removeTemporaryImage()
  ```
  
  ##### Discussion
  
  It is not usually necessary to use this method because this library overwrites an existing file. 
  
  This method calls the `removeTemporaryImage:` method setting the `completion` parameter `nil`.
  
==

  - `removeTemporaryImage:`

  Remove temporary image file in `tmp/` directory.

  ##### Declaration

  ```swift
  func removeTemporaryImage(completion: ((sharingFlowResult: SharingFlowResult<Any>) -> Void)?)
  ```

  ##### Parameters

  Parameter   | Description
  --------------|---------------
  _completion_ | The block to execute after the removing temporary image finishes. You may specify `nil` for this parameter.

  ##### Discussion

  It is not usually necessary to use this method because this library overwrites an existing file.
  
  ##### Handling Errors Example
      
  ```swift
  sharingFlow.removeTemporaryImage { (sharingFlowResult) -> Void in
      switch sharingFlowResult {
      case .Success(let imagePath):
          print("Success: \(imagePath)")
      case .Failure(let error):
          print("Error: \(error)")
      }
  }
  ```

==

### Accessing the Device Attributes

  - `hasInstagramApp`

  Returns a Boolean value indicating whether or not Instagram app is installed on the iOS device.

  ##### Declaration

  ```swift
  var hasInstagramApp: Bool { get }
  ```

  ##### Discussion

  If `true`, the iOS device has Instagram app; otherwise it does not.
