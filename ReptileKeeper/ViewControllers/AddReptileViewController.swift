//
//  AddReptileViewController.swift
//  ReptileKeeper
//
//  Created by Brian Wawczak on 11/5/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import UIKit
import Firebase


class AddReptileViewController: UIViewController {

    @IBOutlet weak var reptileNameText: UITextField!
    @IBOutlet weak var speciesText: UITextField!
    @IBOutlet weak var morphText: UITextField!
    @IBOutlet weak var hatchDateText: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var sexText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    // get a reference to the database
    let db = Firestore.firestore()
    
    // get the current logged in user
    let user = Auth.auth().currentUser?.uid
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        
    }
  
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    // validate that user entry fields are not blank
    func validateFields() -> String? {
        if reptileNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || speciesText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || morphText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || hatchDateText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || sexText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
                      return "Please fill in all fields."
                  }
           return nil
       }
    
    
    @IBAction func addTapped(_ sender: Any) {
        
        let error = validateFields()
        if error != nil {
            showError(error!)
        }
        else {
            //clean the data and add to dictionary
            let reptileName = reptileNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let species = speciesText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let morph = morphText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let hatchDate = hatchDateText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let gender = sexText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let repdict = ["name":reptileName, "species":species, "morph":morph, "hatchDate":hatchDate, "sex":gender ]
            
            // write data to Firestore
            if let userId = user {    db.collection("users").document(userId).collection("reptiles").document(reptileName).setData(repdict)
                showToast(message: "Reptile Added")
                clearTextFields()
                sexText.resignFirstResponder()
                reptileNameText.becomeFirstResponder()
            }
        }
    }
    
    
    func setUpElements(){
        errorLabel.alpha = 0
        Utilities.styleViewControllerView(self.view)
        Utilities.styleTextField(reptileNameText, string: "Reptile Name")
        Utilities.styleTextField(speciesText, string: "Species")
        Utilities.styleTextField(morphText, string: "Morph")
        Utilities.styleTextField(hatchDateText, string: "Hatch Date")
        Utilities.styleTextField(sexText, string: "Sex")
        Utilities.styleButton(addBtn)
        Utilities.styleBackButtons(backBtn)
    }
    
    
    func clearTextFields(){
        reptileNameText.text = ""
        speciesText.text = ""
        morphText.text = ""
        hatchDateText.text = ""
        sexText.text = ""
    }
}

