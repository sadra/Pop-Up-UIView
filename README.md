# Pop-Up-UIView
This is an example to create a Pop Up UIView (<b>Swift 2.3</b>)

![Alt text](/art-assets/popUpUIView.gif?raw=true "popUpUIView")


## 1st
Create a new view file (`.xib`), this is the PopUp View.

## 2nd 
Import the `popUpViewController.swift` from this repo into your project

## 3d
Assign the popUpView to your popUpView Controller:
- in the .xib file select the <b>File's Owner</b> (from righte side). then, in Custom Class of <I>Identity Inspector</I> tab, write popUpViewController.
- then from Outlets in <I>Connection Inspector</I>, Connect `view` to UIView of your .xib file 

![Alt text](/art-assets/popUIViewOutlet.jpg?raw=true "popUpUIViewOutlets")


## 4th
Now, you should make and instance of controller and handle the popUp after click or sth
- In your main ViewController (that controller you want to show popUpUIView), create an Instance of Controller:
```swift
    let popUpController = popUpViewController()
```
- Then in delcare the Instance in <b>viewDidLoad</b>:
```swift
    popUpController.crateInstanceOfPopUp(self.view, theViewController: self, sizeOfPopUpViewContainer: SIZE_OF_POPUPVIEW_CONTAINER)
```
- and for the last step, call the `openPopUpView` every where you want to do that (like after a button click):
```swift
    popUpController.openPopUpView()
```

## More
- you must know, whenever you call `openPopUpView()` it detect popUp situation (like it is open or closed), so you dont need to delcare and handle it, it's automated
- you can add everything in your opUpView and use it in controller, like a UIButton I used in this example
