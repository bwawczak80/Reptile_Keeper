//
//  ReptileLogViewController.swift
//  ReptileKeeper
//
//  Created by Brian Wawczak on 11/16/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import UIKit
import Firebase


class ReptileLogViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var logBtn: UIButton!
    @IBOutlet weak var tempText: UITextField!
    @IBOutlet weak var humidityText: UITextField!
    @IBOutlet weak var feedingText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var logHeader: UILabel!
    
    // get a reference to the database
    let db = Firestore.firestore()
    
    // get the current logged in user
    let user = Auth.auth().currentUser?.uid
    var nameVar = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    
    @IBAction func logTapped(_ sender: Any) {
        let logTime = getTimeStamp()
        let error = validateFields()
        if error != nil {
            showError(error!)
        }
        else {
            //clean data and add to dictionary
            let temp = tempText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let humidity = humidityText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let feeding = feedingText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let weight = weightText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let logDict = ["temp":temp, "humidity":humidity, "feeding":feeding, "weight":weight, "time":logTime]
            
            if let userId = user {    db.collection("users").document(userId).collection("reptiles").document(nameVar).collection("logs").addDocument(data: logDict)
                showToast(message: "Log Added")
                clearTextFields()
                weightText.resignFirstResponder()
                tempText.becomeFirstResponder()
            }
        }
    }
    
    
    func setUpElements(){
        errorLabel.alpha = 0
        Utilities.styleViewControllerView(self.view)
        Utilities.styleTextField(tempText, string: "Temperature ℉/℃")
        Utilities.styleTextField(humidityText, string: "Humidity %")
        Utilities.styleTextField(feedingText, string: "Food item or none")
        Utilities.styleTextField(weightText, string: "Weight in grams")
        Utilities.styleButton(logBtn)
        Utilities.styleBackButtons(backBtn)
        Utilities.styleLabel(logHeader)
    }
    
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    

    // validate that user entry fields are not blank
    func validateFields() -> String? {
        if tempText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || humidityText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || feedingText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  weightText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields."
        }
        return nil
    }
    
    
    func clearTextFields(){
        tempText.text = ""
        humidityText.text = ""
        feedingText.text = ""
        weightText.text = ""
    }
    
    
    func getTimeStamp() -> String {
        let currentDate = Date()
        let currentCalendar = Calendar.current
        let currentDateDetails: DateComponents = currentCalendar.dateComponents(in: currentCalendar.timeZone, from: currentDate)
        let day = currentDateDetails.day
        let year = currentDateDetails.year
        let thisMonth = currentCalendar.component(.month, from: currentDate)
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm:ss a"
        let timeNow = formatter.string(from: currentDate)
        let dateTimeStamp = "\(thisMonth)/\(day ?? 0)/\(year ?? 0) \(timeNow)"
        return dateTimeStamp
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nameToSend = nameVar
        let destinationVC = segue.destination as! SummaryViewController
        destinationVC.nameVar = nameToSend
    }
}
