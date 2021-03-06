# MemeGen
This Swift app for iPhone (iOS 8) let's a user add text to any photo and share it as a Meme. User data is persisted using CoreData. Memes are presented in both list and collection layouts.

## Implementation Highlights

* Memes created by the user are persisted using an SQLite Core Data store and a Meme class derived from NSManagedObject.
* The MVC design pattern is followed and a clear separation is maintained between the model and view.
* The Core Data stack is encapsulated in a separate class.
* Memes are presented using views based upon both UITableView and UICollectionView.
* Custom cells are defined for both the table and collection views.
* Navigation is implemented using UINavigationController and UITabBarController.


## Screenshots

### Create

This view allows the user to create a Meme.

![Create Meme](/../screenshots/screenshots/MemeGen_screenshot_createwithcamera.PNG?raw=true "Create Meme")

* Add text to the meme using the keyboard.
* Memes are created using UIGraphicsGetImageFromCurrentImageContext.
* Bottom text field is moved when the keyboard is shown/hidden so that it remains visible.

### Add Image

The user can add an image to the Meme by selecting the Album button...

![Add Image](/../screenshots/screenshots/MemeGen_screenshot_photos.PNG?raw=true "Add Image")

... or by selecting the Camera button.

![Take Picture](/../screenshots/screenshots/MemeGen_screenshot_camera.png?raw=true "Take Picture")

* UIImagePickerController and UIImagePickerControllerDelegate are used to allow a user to add an image from the photo gallery or capture an image from the camera.

### Share

A Meme can be shared via a text message, email, AirDrop, social media, saved to disk, etc.

![Share Meme](/../screenshots/screenshots/MemeGen_screenshot_actionsheet.png?raw=true "Share Meme")

* Selecting the Share button presents a UIActivityViewController.

### List

Memes can be displayed in a list format by selecting the table button.

![List View](/../screenshots/screenshots/MemeGen_screenshot_List.png?raw=true "List View")

* A UITableView is used to implement this view. 
* UITableViewDataSource and the UITableViewDelegate protocols are used interface with the model to supply data to the table, and to handle user interaction with the table cells respectively.
* A custom UITableViewCell is used to present the Meme, maintaining proper scale for the image.

### Collection

Memes are displayed in a collection view when the MyCollection button is selected.

![Collection view](/../screenshots/screenshots/MemeGen_screenshot_collection.png?raw=true "Collection View")

* A UICollectionView is used to implement this view.
* UICollectionViewDataSource and UICollectionViewDelegate protocols are used to supply data to the collection view from the model, and to handle user interaction with the collection items respectively.
* A custom UICollectionViewCell is used to present the Meme, maintaining proper scale for the image.

### Detail

Tap on a Meme in either the List view or Collection view to display the Meme in the Meme detail view.

![Meme Detail](/../screenshots/screenshots/MemeGen_screenshot_detail.png?raw=true "Meme Detail")

### Edit

Select the Edit button in the Meme Detail view to edit the Meme text or image and then save it.

![Meme Detail](/../screenshots/screenshots/MemeGen_screenshot_editmeme.png?raw=true "Meme Detail")


