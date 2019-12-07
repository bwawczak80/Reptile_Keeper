//
//  Constants.swift
//  ReptileKeeper
//
//  Created by Brian Wawczak on 10/29/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Storyboard {
        static let homeViewController = "HomeVC"
    }
}


struct CellData {
    
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}


struct Reptile: Codable {
    var name: String?
    var sex: String?
    var morph: String?
    var species: String?
    var hatchDate: String?
}


struct Log: Codable {
    var temp: String?
    var humidity: String?
    var feeding: String?
    var weight: String?
    var time: String?
}


extension UIViewController {

func showToast(message : String) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-200, width: 250, height: 50))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds = true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
