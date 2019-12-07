//
//  ViewController.swift
//  ReptileKeeper
//
//  Created by Brian Wawczak on 10/28/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController {

    
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        }
        
    
        func setUpElements(){
            
            Utilities.styleViewControllerView(self.view)
            Utilities.styleButton(signUpBtn)
            Utilities.styleButton(loginBtn)
            
        }
}
