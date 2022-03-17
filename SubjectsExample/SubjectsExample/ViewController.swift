//
//  ViewController.swift
//  SubjectsExample
//
//  Created by Hyeon on 2022/03/08.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.publishSubject()
        self.behaviorSubject()
        self.relaySubject()
        self.publishRelay()
        self.behaviorRelay()
    }
    
    public func example(of description: String,
                            action: () -> Void) {
            print("\n--- Example of:", description, "---")
            action()
        }

}

