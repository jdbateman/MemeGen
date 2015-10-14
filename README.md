# MemeGen
This Swift app for iPhone (iOS 8) let's you add text to photos and share them. Uses CoreData.

## Implementation Highlights

* Memes created by the user are persisted using an SQLite Core Data store.
* The Core Data stack is encapsulated in a separate class.

## Screenshots

### Create

This view allows the user to create a Meme.

![Create Meme](/../screenshots/screenshots/MemeGen_screenshot_createwithcamera.PNG?raw=true "Create Meme")

* UIImagePickerController is used to allow a user to add an image from the photo gallery or capture an image from the camera.
* Add text to the meme using the keyboard.
* UIGestureRecognizer is used to manage the keyboard.


### Share

A Meme can be shared via a text message, email, AirDrop, social media, saved to disk, etc.

![Share Meme](/../screenshots/screenshots/MemeGen_screenshot_actionsheet.png?raw=true "Share Meme")

* Selecting the Share button presents a UIActionSheet.

### List

Memes can be displayed in a list format by selecting the table button.

![List View](/../screenshots/screenshots/MemeGen_screenshot_List.png?raw=true "List View")

* Custom TableView cells are used to present the Meme, maintaining proper scale for the image.

### Collection

Memes are displayed in a collection view when the MyCollection button is selected.

![Collection view](/../screenshots/screenshots/MemeGen_screenshot_collection.png?raw=true "Collection View")

* Custom UICollectionView cells are used to present the Meme, maintaining proper scale for the image.

### Detail

A Meme can be selected in either the List of Collection view to display the Meme detail view.

![Meme Detail](/../screenshots/screenshots/MemeGen_screenshot_detail.png?raw=true "Meme Detail")

### Edit

Select the Edit button in the Meme Detail view to edit the Meme text or image and save it.

![Meme Detail](/../screenshots/screenshots/MemeGen_screenshot_editmeme.png?raw=true "Meme Detail")


