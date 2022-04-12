//
//  ViewController2.swift
//  NotificationCenterExample
//
//  Created by Hyeon on 2022/04/12.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    
    // ViewController2가 실행되자마자 ViewController에서 post 처리한 notification을 받도록 구현
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(rotate), name: .rotateBack, object: nil)
    }
    
    @objc func rotate() {
        self.closeBtn.transform = self.closeBtn.transform.rotated(by: CGFloat(Double.pi * 3 ))
        print("rotate success! ")
    }

}
