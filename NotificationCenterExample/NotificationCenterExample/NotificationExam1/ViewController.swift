//
//  ViewController.swift
//  NotificationCenterExample
//
//  Created by Hyeon on 2022/04/12.
//

import UIKit

class ViewController: UIViewController {
    
    let userInfo: [AnyHashable: Any] = ["phoneNo":"010-1234-5678"]

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(unhideLabel), name: NSNotification.Name.init(rawValue: "unhide"), object: nil)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"phoneNumber"), object: nil, queue: nil) { notification in
            let phoneNumber = notification.userInfo?["phoneNo"] as? String
            self.label.text = phoneNumber
        }
    }

    @IBAction func unhide(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("unhide"), object: nil, userInfo: nil)
    }
    
    @IBAction func showPhoneNo(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "phoneNumber"), object: nil, userInfo: userInfo)
        self.label.isHidden = false
    }
    
    @objc func unhideLabel() {
        self.label.isHidden = false
    }
    
}

