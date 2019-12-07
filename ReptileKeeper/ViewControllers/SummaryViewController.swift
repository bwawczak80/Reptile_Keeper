//
//  SummaryViewController.swift
//  ReptileKeeper
//
//  Created by Brian Wawczak on 11/19/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SummaryViewController: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var reptileNameText: UILabel!
    @IBOutlet weak var speciesText: UILabel!
    @IBOutlet weak var morphText: UILabel!
    @IBOutlet weak var hatchDateText: UILabel!
    @IBOutlet weak var sexText: UILabel!
    @IBOutlet weak var logBtn: UIButton!
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var summaryHeader: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var speciesLbl: UILabel!
    @IBOutlet weak var morphLbl: UILabel!
    @IBOutlet weak var sexLbl: UILabel!
    @IBOutlet weak var hatchLbl: UILabel!
    
    
    var reptiles = [Reptile]()
    var nameVar = String()
    // get a reference to the database
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        getReptileRecords()
    }
    
    
    func setUpElements(){
        Utilities.styleViewControllerView(self.view)
        Utilities.styleLabel(reptileNameText)
        Utilities.styleLabel(speciesText)
        Utilities.styleLabel(morphText)
        Utilities.styleLabel(summaryHeader)
        Utilities.styleLabel(hatchDateText)
        Utilities.styleLabel(sexText)
        Utilities.styleLabel(nameLbl)
        Utilities.styleLabel(speciesLbl)
        Utilities.styleLabel(morphLbl)
        Utilities.styleLabel(hatchLbl)
        Utilities.styleLabel(sexLbl)
        Utilities.styleBackButtons(backBtn)
        Utilities.styleButton(logBtn)
        Utilities.styleButton(historyBtn)
    }
    
    
    func getReptileRecords(){
        // get document
        if let userId = Auth.auth().currentUser?.uid { db.collection("users").document(userId).collection("reptiles").document(nameVar).getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    let documentData = document!.data()
                    do {
                        let data = try JSONSerialization.data(withJSONObject: documentData as Any, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        let reptile = try decoder.decode(Reptile.self, from: data)
                        
                        self.reptiles.append(reptile)
                        self.reptileNameText.text = reptile.name
                        self.speciesText.text = reptile.species
                        self.morphText.text = reptile.morph
                        self.hatchDateText.text = reptile.hatchDate
                        self.sexText.text = reptile.sex
                        
                    } catch let err {
                        print("Error:", err)
                    }
                }
            }
            }
        }
    }
    
    
    @IBAction func addLog(_ sender: Any) {
        performSegue(withIdentifier: "segOne", sender: nil)
    }
    
    
    @IBAction func historyBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "historySeg", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segOne"){
            let nameToSend = nameVar
            let destinationVC = segue.destination as! ReptileLogViewController
            destinationVC.nameVar = nameToSend
        }
        else if (segue.identifier == "historySeg"){
            let nameToSend = nameVar
            let destinationVC = segue.destination as! HistoryViewController
            destinationVC.nameVar = nameToSend
        }
    }
}
