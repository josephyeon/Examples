//
//  ViewController1.swift
//  NotificationCenterExample
//
//  Created by Hyeon on 2022/04/12.
//

import UIKit

// ViewController1이 화면에서 사라지고, ViewController2의 버튼을 회전시켜보기

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // ViewController1이 사라질 때, ViewController2의 버튼 회전에 대해 전달시켜줘야 함 => viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: .rotateBack, object: nil)
        print("post success!")
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let vc2 = storyboard?.instantiateViewController(withIdentifier: "vc2") as? ViewController2 else { return }
        vc2.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(vc2, animated: true)
    }
}
