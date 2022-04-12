//
//  ViewController.swift
//  SwiftyJSONExample
//
//  Created by Hyeon on 2022/03/21.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.parseJSON()
    }
    
    var responseValue: [[String: Any]] = [ ["name" : "red2", "id" : 1, "color" : "FF0000"] ,  ["name" : "green", "id" : 2, "color" : "00FF00"], ["name" : "blue", "id" : 3, "color" : "0000FF"], ["name" : "It's #000000", "id" : 4, "color" : "000000"] ]
    
    func parseJSON() {
        let responseJSON = JSON(responseValue)
        print("responseJSON: \(responseJSON.count)")
        
        for (index, subJSON): (String, JSON) in responseJSON {
            guard let name = subJSON["name"].string,
                  let id = subJSON["id"].int,
                  let code = subJSON["color"].string else { continue }
            
            print("[\(index)] - code: \(code) / id: \(id) / name: \(name)")
        }
    }
}

