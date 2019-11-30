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
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableViewData = []
        
        setUpElements()
        getReptileRecords()
        
        
        let logNib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        tableView.register(logNib, forCellReuseIdentifier: "HistoryTableViewCell")
        
        let dateNib = UINib(nibName: "TimestampTableViewCell", bundle: nil)
        tableView.register(dateNib, forCellReuseIdentifier: "TimestampTableViewCell")
        
        
        tableView.dataSource = self
        tableView.delegate = self
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
        print("Number of sections\(logs.count)")
        return logs.count
        
    }
    

    // Set the spacing between sections
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 12
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true{
            //return logs.count
            
            return 2
        }else{
            return 1
        }
            
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimestampTableViewCell", for: indexPath) as! TimestampTableViewCell
            let log = logs[indexPath.row]
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
            
            let log = logs[indexPath.row - 1]
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var height:CGFloat = CGFloat()
//        if indexPath.row == 1 {
//            height = 250
//        }
//        else {
//            height = 50
//        }
//
//        return height
//        //return CGFloat(indexPath.row * 20)
//    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
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
