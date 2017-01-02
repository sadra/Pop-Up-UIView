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
            let yComponent = UIScreen.mainScreen().bounds.height - 280
            self?.view.frame = CGRectMake(0, yComponent, frame!.width, frame!.height)
        }){ _ in }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Close popUpView and remove it from Parent or superView
    @IBAction func closePopUpDialog(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: {
            self.popUpViewControllerInstance.view.frame = CGRectMake(0, self.theParentView.frame.height, self.theParentView.frame.width, self.theParentView.frame.height)
        }) { _ in
            self.popUpViewControllerInstance.view.removeFromSuperview()
        }
        
    }
    
    //Create an Instance of popUpDialog and declare the parent and child
    func crateInstanceOfPopUp(senderView:UIView, theViewController:UIViewController){
        theParentView = senderView
        popUpViewControllerInstance = self
        theViewController.addChildViewController(popUpViewControllerInstance)
    }
    
    //Add popUP View ot parent view
    func addPopOverView() {
        
        popUpViewControllerInstance.view.frame.origin.y = theParentView.frame.height
        
        popUpViewControllerInstance.didMoveToParentViewController(popUpViewControllerInstance)
        theParentView.addSubview(popUpViewControllerInstance.view)
        
        let height = theParentView.frame.height
        let width  = theParentView.frame.width
        self.popUpViewControllerInstance.view.frame = CGRectMake(0, self.theParentView.frame.maxY, width, height)
    }
    
    //Preapre the BackGroundView of the child View
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .ExtraLight)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.mainScreen().bounds
        bluredView.frame = UIScreen.mainScreen().bounds
        
        view.insertSubview(bluredView, atIndex: 0)
    }
    
    //PenGEsture help the view to translate and be added to the parent view
    func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        let y = self.view.frame.minY
        self.view.frame = CGRectMake(0, y + translation.y, view.frame.width, view.frame.height)
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }

}
