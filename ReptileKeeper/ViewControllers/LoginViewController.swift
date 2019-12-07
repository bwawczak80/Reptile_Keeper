//
//  LoginViewController.swift
//  ReptileKeeper
//
//  Created by Brian Wawczak on 10/29/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var passBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    
    func setUpElements(){
        errorLabel.alpha = 0
        Utilities.styleViewControllerView(self.view)
        Utilities.styleTextField(emailText, string: "Email")
        Utilities.styleTextField(passwordText, string: "Password")
        Utilities.styleButton(loginBtn)
        Utilities.styleBackButtons(backBtn)
        Utilities.styleBackButtons(passBtn)
    }
    
     @IBAction func onForgotPassBtnClick(_ sender: Any) {
        
        let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
        
        showToast(message: "Check Email for reset link")
        }
    
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        // create cleaned Versions of data
        let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines  )
        
        // Verify user and get Auth token
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
                //if user Auth, open homeViewController
            else {
                let homeviewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeviewController
                self.view.window?.makeKeyAndVisible()
            }
        }
        
    }
}


