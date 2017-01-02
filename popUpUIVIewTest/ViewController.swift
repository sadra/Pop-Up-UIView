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
        // Do any additional setup after loading the view, typically from a nib.
        
        popUpController.crateInstanceOfPopUp(self.view, theViewController: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openPopUpViewBtn(sender: AnyObject) {
        
        popUpController.addPopOverView()
        
    }

}

