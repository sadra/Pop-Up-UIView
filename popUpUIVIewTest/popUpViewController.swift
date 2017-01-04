//
//  popUpViewController.swift
//  popUpUIVIewTest
//
//  Created by Sadra on 1/2/17.
//  Copyright © 2017 isapanah. All rights reserved.
//

import UIKit

class popUpViewController: UIViewController {
    
    var popUpViewControllerInstance : popUpViewController! = nil
    
    var theParentView: UIView!
    
    var sizeOfPopUpViewContainer:Int!
    
    var popUpViewIsOpen:Bool = false
    
    var needMoreGesture:Bool = false
    
    var backgroundColor:UIColor = UIColor.darkGrayColor()
    
    
    let fullView: CGFloat = 100
    var partialView: CGFloat {
        return UIScreen.mainScreen().bounds.height - (theParentView.frame.maxY + UIApplication.sharedApplication().statusBarFrame.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(popUpViewController.panGesture))
        view.addGestureRecognizer(gesture)
        
    }
    
    
    //Preapare popUpView befor appearing
    override func viewWillAppear(animated: Bool) {
        
        prepareBackgroundView()
        
    }
    
    //After the ParentView did appear, make the popUp translate to up with some bounce animation
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: .CurveEaseInOut, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.mainScreen().bounds.height - CGFloat.init(self!.sizeOfPopUpViewContainer)
            self?.view.frame = CGRectMake(0, yComponent, frame!.width, frame!.height)
        }){ _ in }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Create an Instance of popUpDialog and declare the parent and child
    
    func crateInstanceOfPopUp(senderView:UIView, theViewController:UIViewController, sizeOfPopUpViewContainer:Int){
        theParentView = senderView
        popUpViewControllerInstance = self
        self.sizeOfPopUpViewContainer = sizeOfPopUpViewContainer
        theViewController.addChildViewController(popUpViewControllerInstance)
    }
    
    func crateInstanceOfPopUp(senderView:UIView, theViewController:UIViewController, sizeOfPopUpViewContainer:Int, needMoreGesture:Bool){
        theParentView = senderView
        popUpViewControllerInstance = self
        self.sizeOfPopUpViewContainer = sizeOfPopUpViewContainer
        self.needMoreGesture = needMoreGesture
        theViewController.addChildViewController(popUpViewControllerInstance)
    }
    
    func crateInstanceOfPopUp(senderView:UIView, theViewController:UIViewController, sizeOfPopUpViewContainer:Int, backgroundColor:UIColor){
        theParentView = senderView
        popUpViewControllerInstance = self
        self.sizeOfPopUpViewContainer = sizeOfPopUpViewContainer
        self.backgroundColor = backgroundColor
        theViewController.addChildViewController(popUpViewControllerInstance)
    }
    
    func crateInstanceOfPopUp(senderView:UIView, theViewController:UIViewController, sizeOfPopUpViewContainer:Int, needMoreGesture:Bool, backgroundColor:UIColor){
        theParentView = senderView
        popUpViewControllerInstance = self
        self.sizeOfPopUpViewContainer = sizeOfPopUpViewContainer
        self.needMoreGesture = needMoreGesture
        self.backgroundColor = backgroundColor
        theViewController.addChildViewController(popUpViewControllerInstance)
    }
    
    
    //Add popUP View ot parent view
    func addPopOverView() {
        
        popUpViewIsOpen = true
        
        popUpViewControllerInstance.view.frame.origin.y = theParentView.frame.height
        
        popUpViewControllerInstance.didMoveToParentViewController(popUpViewControllerInstance)
        theParentView.addSubview(popUpViewControllerInstance.view)
        
        let height = theParentView.frame.height
        let width  = theParentView.frame.width
        self.popUpViewControllerInstance.view.frame = CGRectMake(0, self.theParentView.frame.maxY, width, height)
    }
    
    //Preapre the BackGroundView of the child View
    func prepareBackgroundView(){
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: popUpViewControllerInstance.view.frame.width,
            height: popUpViewControllerInstance.view.frame.height))
        backgroundView.layer.backgroundColor = backgroundColor.CGColor
        backgroundView.frame = UIScreen.mainScreen().bounds
        
        view.insertSubview(backgroundView, atIndex: 0)
        
    }
    
    
    
    //PenGEsture help the view to translate and be added to the parent view
    func panGesture(recognizer: UIPanGestureRecognizer) {
        
        if (needMoreGesture) {
            let translation = recognizer.translationInView(self.view)
            let velocity = recognizer.velocityInView(self.view)
            let y = self.view.frame.minY
            if ( y + translation.y >= fullView) && (y + translation.y <= partialView ) {
                self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
                recognizer.setTranslation(CGPoint.zero, inView: self.view)
            }
            
            if recognizer.state == .Ended {
                var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
                
                duration = duration > 1.3 ? 1 : duration
                
                UIView.animateWithDuration(duration, delay: 0.0, options: [.AllowUserInteraction], animations: {
                    if  velocity.y >= 0 {
                        self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                    } else {
                        self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                    }
                    
                    }, completion: nil)
            }
        }
        
    }
    
    func openPopUpView(){
        
        if (self.popUpViewIsOpen) {
            closePopUpView()
        }else{
            addPopOverView()
        }
        
    }
    
    func closePopUpView(){
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: {
            self.popUpViewControllerInstance.view.frame = CGRectMake(0, self.theParentView.frame.height, self.theParentView.frame.width, self.theParentView.frame.height)
        }) { _ in
            self.popUpViewIsOpen = false
            self.popUpViewControllerInstance.view.removeFromSuperview()
        }
    }
    
    //Close popUpView and remove it from Parent or superView
    @IBAction func closePopUpDialog(sender: AnyObject) {
        closePopUpView()
    }
    
    
}
