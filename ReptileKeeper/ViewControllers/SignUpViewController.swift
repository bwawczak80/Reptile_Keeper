//
//  SignUpViewController.swift
//  ReptileKeeper
//
//  Created by Brian Wawczak on 10/29/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        setUpElements()
    }
    //MARK: - Set Up Elements
    
    
    func setUpElements() {
        
        
        
        errorLabel.alpha = 0
        
        
        
        
        Utilities.styleViewControllerView(self.view)
        Utilities.styleBackButtons(backBtn)
        Utilities.styleTextField(firstNameText, string: "First Name")
        Utilities.styleTextField(lastNameText, string: "Last Name")
        Utilities.styleTextField(emailText, string: "Email")
        Utilities.styleTextField(passwordText, string: "Password")
        Utilities.styleFilledButton(signUpBtn)
        
        
    }
    
    func validateFields() -> String? {
        if firstNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        // check that password is valid
        let cleanedPassword = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters and includes a special character and number"
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        passwordText.resignFirstResponder()
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            //Create cleaned versions of the data
            let firstName = firstNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //Check for errors
                if err != nil {
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created succesfully, now store the first name and last neme.
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstName":firstName, "lastName":lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            // show error message
                            self.showError("User data couldn't be saved")
                        }
                    }
                }
            }
            
            //Transition to the home screen
            self.transitionToHome()
        }
    }
    // make label visible and display error
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let homeviewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeviewController
        view.window?.makeKeyAndVisible()
    }
}
