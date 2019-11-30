//
//  Utilities.swift
//  ReptileKeeper
//
//  Created by Brian Wawczak on 10/29/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    
    
    
    static func styleViewControllerView(_ view:UIView) {
        
        view.backgroundColor = UIColor.init(red: 47/255, green: 51/255, blue: 4/255, alpha: 1)
    }
    
    static func styleTextField(_ textfield:UITextField, string:String) {
        let underline = CALayer()
        underline.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        underline.backgroundColor = UIColor.init(red: 173/255, green: 248/255, blue: 78/255, alpha: 1).cgColor
        textfield.tintColor = UIColor.init(red: 173/255, green: 248/255, blue: 78/255, alpha: 1)
        textfield.borderStyle = .none
        
        textfield.textColor = UIColor.white
        // Add the line to the text field
        textfield.layer.addSublayer(underline)
        textfield.attributedPlaceholder = NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    
    static func styleFilledButton(_ button:UIButton) {
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 149/255, green: 217/255, blue: 4/255, alpha: 1)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 5.0
        button.tintColor = UIColor.white
    }
    

    static func styleBackButtons(_ button:UIButton){
        button.setTitleColor(UIColor.init(red: 149/255, green: 217/255, blue: 4/255, alpha: 1), for: .normal)
    }
    
    
    static func styleTableView(_ tableView:UITableView){
        tableView.backgroundColor = UIColor.clear
    }
    
    

    
    static func isPasswordValid(_ password : String) -> Bool {
        // creates password requirement of 8 characters, with at least 1 number and 1 symbol
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func styleLabel(_ label:UILabel){
        label.textColor = UIColor.white
    }
    
    
}

