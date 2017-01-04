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
- You must know, whenever you call `openPopUpView()` it detect popUp situation (like it is open or closed), so you dont need to delcare and handle it, it's automated
- You can add everything in your popUpView and use it in controller, like a UIButton I used in this example

## Update

#### Additnal attributes
When you're making an instance of popUpUIView you can define two additional attributes:
- `needMoreGesture` : by default this attribute is `false`. means, there is no <b>More Section</b>. if you want <I>more section</I> you should set this attribiute to `true`. Then you can add more UI Elemnt in your UIView 'under the main popUpView.

```swift
    popUpController.crateInstanceOfPopUp(self.view, theViewController: self, sizeOfPopUpViewContainer: 200, needMoreGesture: true)
```

- `backgroundColor` : by default this attrbiute is `DarkGray`. If you want change the background color just set your favorite color az an attribute.

```swift
    popUpController.crateInstanceOfPopUp(self.view, theViewController: self, sizeOfPopUpViewContainer: 200, backgroundColor: UIColor.redColor())
```
- As you know you can set all attribiutes once at all :D :
```swift
    popUpController.crateInstanceOfPopUp(self.view, theViewController: self, sizeOfPopUpViewContainer: 200, needMoreGesture: true, backgroundColor: UIColor.redColor())
```
