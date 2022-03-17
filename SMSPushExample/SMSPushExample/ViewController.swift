//
//  ViewController.swift
//  SMSPushExample
//
//  Created by Hyeon on 2022/03/16.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "sms://01012345678"

        if let openApp = URL(_url: String), UIApplication.shared.canOpenURL(openApp) {
            // 버전별 처리
            if #available(iOS 10.0, *) {
                    UIApplication.shared.open(openApp, options: [:], completionHandler: nil)
                }
                else {
                    UIApplication.shared.openURL(openApp)
                    }
                }
              
                //스키마명을 사용해 외부앱 실행이 불가능한 경우
                else {
                    print("[goDeviceApp : 디바이스 외부 앱 열기 실패]")
                    print("링크 주소 : \(_url)")
                }
        }

    }


}

