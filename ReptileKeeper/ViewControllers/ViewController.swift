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
        
    
    //MARK: - Set Up Elements
    
        func setUpElements(){
            
            Utilities.styleViewControllerView(self.view)
            Utilities.styleFilledButton(signUpBtn)
            Utilities.styleFilledButton(loginBtn)
            
        }
    
    
  
}
