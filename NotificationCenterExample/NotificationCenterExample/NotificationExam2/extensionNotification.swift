//
//  extensionNotification.swift
//  NotificationCenterExample
//
//  Created by Hyeon on 2022/04/12.
//

import Foundation
import UIKit

// Notification 이름 정하기
extension Notification.Name {
    static let rotateBack = Notification.Name("rotateBack")
}

/* 또는 아래와 같이 설정 가능함
 
 //ViewController 1 또는 2의 ViewDidLoad 코드 블럭에 아래처럼 post 메서드 작성시 한번에 작성 가능함
 Notification.default.post(name: Notification.Name(rawValue: "rotateBack"), object: nil, userInfo: nil)
 
 */



