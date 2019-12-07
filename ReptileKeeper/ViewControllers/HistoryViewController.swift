//
//  HistoryViewController.swift
//  ReptileKeeper
//
//  Created by Brian Wawczak on 11/26/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    var tableViewData = [CellData]()
    var logs = [Log]()
    var nameVar = String()
    let cellColor = UIColor.init(red: 64/255, green: 65/255, blue: 7/255, alpha: 0.9)
    // get reference to database
    let db = Firestore.firestore()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        getReptileRecords()
        registerTableView()
    }
    
    
    func getReptileRecords(){
        // get document
        if let userId = Auth.auth().currentUser?.uid { db.collection("users").document(userId).collection("reptiles").document(nameVar).collection("logs").getDocuments { (document, error) in
            if let documents = document?.documents
                , documents.count > 0 {
                for document in documents {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: document.data() as Any, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        let log = try decoder.decode(Log.self, from: data)
                        self.logs.append(log)
                        self.tableViewData.append(CellData(opened: false))
                    } catch let err {
                        print("Error:", err)
                    }
                }
                self.tableView.reloadData()
            }
            }
        }
    }
    
    
    func setUpElements() {
        Utilities.styleTableView(tableView)
        Utilities.styleViewControllerView(self.view)
        Utilities.styleBackButtons(backBtn)
    
    }

        //MARK: - TableView Dataview and Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return logs.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true{
            return 2
        }else{
            return 1
        }
    }
    
    
    func registerTableView(){
        let logNib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        tableView.register(logNib, forCellReuseIdentifier: "HistoryTableViewCell")
        let dateNib = UINib(nibName: "TimestampTableViewCell", bundle: nil)
        tableView.register(dateNib, forCellReuseIdentifier: "TimestampTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        // assign TimestampTableViewCell xib to first row
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimestampTableViewCell", for: indexPath) as! TimestampTableViewCell
            let log = logs[indexPath.section]
            cell.timeTag.text = log.time
            cell.contentView.backgroundColor = cellColor
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
            let log = logs[indexPath.section]
            cell.contentView.backgroundColor = cellColor
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            cell.tempTag.text = log.temp
            cell.humidityTag.text = log.humidity
            cell.preyTag.text = log.feeding
            cell.weightTag.text = log.weight
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //opens and closes first row on row selection
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nameToSend = nameVar
        let destinationVC = segue.destination as! SummaryViewController
        destinationVC.nameVar = nameToSend
    }
}
