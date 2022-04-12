//
//  SwitchViewController.swift
//  UserDefaultsExample
//
//  Created by Hyeon on 2022/03/21.
//

import UIKit

class SwitchViewController: UIViewController {

    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var testSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        testSwitch.isOn = userDefaults.bool(forKey: "SwitchState")
        print(testSwitch.isOn)
    }
    
    @IBAction func tapSwitch(_ sender: Any) {
        userDefaults.set(testSwitch.isOn, forKey: "SwitchState")
    }
}

