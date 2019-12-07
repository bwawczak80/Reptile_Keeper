//
//  HomeViewController.swift
//  ReptileKeeper
//
//  Created by Brian Wawczak on 10/29/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let db = Firestore.firestore()
    var reptiles = [Reptile]()
    let cellColor = UIColor.init(red: 64/255, green: 65/255, blue: 7/255, alpha: 0.9)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        registerTableView()
        setUpElements()
        getReptileRecords()
    }
    
    
    func setUpElements(){
        Utilities.styleViewControllerView(self.view)
        Utilities.styleButton(addBtn)
        Utilities.styleTableView(tableView)
        Utilities.styleBackButtons(backBtn)
    }
    
    
    func getReptileRecords(){
        // get documents for the currently logged in user
        if let userId = Auth.auth().currentUser?.uid { db.collection("users").document(userId).collection("reptiles").getDocuments { (document, error) in
            if let documents = document?.documents
                , documents.count > 0 {
                for document in documents {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: document.data() as Any, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        let reptile = try decoder.decode(Reptile.self, from: data)
                        self.reptiles.append(reptile)
                    } catch let err {
                        print("Error:", err)
                    }
                }
                self.tableView.reloadData()
            }
            }
        }
    }
    
    func registerTableView() {
        // get the xib file and register it to the ViewController
        let nib = UINib(nibName: "ReptileListCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ReptileListCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - TableView Dataview and Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return reptiles.count
    }
    
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReptileListCell", for: indexPath) as! ReptileListCellTableViewCell
        let reptile =  reptiles[indexPath.section]
        cell.labelOne.text = reptile.name
        cell.labelTwo.text = reptile.species
        cell.labelNameTag.backgroundColor = UIColor.clear
        cell.labelSpeciesTag.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = cellColor
        cell.labelOne.backgroundColor = UIColor.clear
        cell.labelTwo.backgroundColor = UIColor.clear
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "seg", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let userId = Auth.auth().currentUser?.uid {
                let repIndex = indexPath.section
                let reptile = reptiles[repIndex]
                let repName = reptile.name!
                db.collection("users").document(userId).collection("reptiles").document(repName).delete()
                reptiles.remove(at: repIndex)
                tableView.reloadData()
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "seg"){
            if let indexPath = tableView.indexPathForSelectedRow{
                let repIndex = indexPath.section
                let reptile = reptiles[repIndex]
                let repName = reptile.name
                let nameToSend = repName
                let destinationVC = segue.destination as! SummaryViewController
                destinationVC.nameVar = nameToSend!
            }
        }
    }
}
