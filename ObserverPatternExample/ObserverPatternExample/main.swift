//
//  main.swift
//  ObserverPatternExample
//
//  Created by Hyeon on 2022/04/13.
//


/**
# 옵저버 패턴
 *  행동 패턴 중 하나
 * 관찰 중인 객체에서 발생하는 이벤트를 여러 다른 객체에 알리는 메커니즘을 정의할 수 있는 디자인 패턴
 * Combine 프레임워크나 NotificationCenter의 기반
 
# 옵저버 패턴 구조
    ## Publisher
     ### Subject
         - Observer들을 가지고 있으며, 개수에는 제한이 없다.
    - Observer 추가, 제거
 
  ### Concrete Subject
         - Concrete Observer 객체의 상태를 저장
    - 상태가 변경되면, Observer (Subscriber)에게 알림
    
 ## Subscriber
    ### Observer
         - 객체의 변경 사항을 알리기 위한 Update 인터페이스 제공
  ### Concrete Observer
         - Concrete Subject (Publisher) 객체에 대한 참조를 유지
    - Subject (Publisher)의 상태와 일관성 유지
    - 객체 상태와 일관성을 유지하기 위해 update 인터페이스 구현
 */

/**
 # Observer 패턴을 활용한 예시
        * 아이폰이 매진된 애플 스토어에서 새 아이폰이 입고될 때 DB의 모든 고객에게 알림을 전송할 예정
    * 하지만, 알림을 받고 싶은 고객에 한해서만 알림을 전송하도록 설정
 ## 역할 분배
        * Publisher: 애플 스토어
    * Observer: 고객들
 */

import Foundation

// 별도로 작성한 Publisher, Observer 프로토콜을 바탕으로 애플 스토어 및 고객 class 작성
class AppleStore: Publisher { // 애플 스토어 (Publisher)
    var observers: [Observer]
    
    init(observers: [Observer]) {
        self.observers = observers
    }
    
    func subscribe(observer: Observer) {
        self.observers.append(observer)
    }
    
    func unSubscribe(observer: Observer) {
        let name = observer.id
        if let index = self.observers.firstIndex(where: { $0.id == observer.id }) {
            self.observers.remove(at: index)
            print("\(name) 알림 해제됨\n")
        }
    }
    
    func notify(message: String) {
        for observer in observers {
            observer.update(message: message)
        }
    }
}


class Customer: Observer { // 고객 (Subscriber)
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func update(message: String) {
        print("\(id)님에게 \(message)가 수신되었습니다.\n")
    }
}

// 선언한 class를 바탕으로 애플스토어 및 고객 인스턴스 생성
let appleStore: AppleStore = .init(observers: [])

let pingu: Customer = .init(id: "Pingu")
let pinga: Customer = .init(id: "Pinga")
let roby: Customer = .init(id: "Roby")
let ick: Customer = .init(id: "Ick")

// 고객 Pingu 및 Roby가 알림을 받도록 설정
appleStore.subscribe(observer: pingu)
appleStore.subscribe(observer: roby)

// 알림을 받기로한 고객들에게 메시지 전송
appleStore.notify(message: "iPhone이 추가 입고 되었습니다!")

// 알림 해지한 고객 발생
appleStore.unSubscribe(observer: roby)

// 나머지 고객들에게 메시지 전송
appleStore.notify(message: "오래 기다리셨습니다! Mac Studio 주문이 지금부터 가능합니다!")
