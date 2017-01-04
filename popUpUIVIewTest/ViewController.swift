//
//  ViewController.swift
//  popUpUIVIewTest
//
//  Created by Sadra on 1/2/17.
//  Copyright © 2017 isapanah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let popUpController = popUpViewController()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Define popUp attribiutes
        popUpController.crateInstanceOfPopUp(self.view, theViewController: self, sizeOfPopUpViewContainer: 200, needMoreGesture: false, backgroundColor: UIColor.redColor())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func openPopUpViewBtn(sender: AnyObject) {
        
        //Call and open PopUpView
        popUpController.openPopUpView()
        
    }

}

