//
//  BehaviorSubject.swift
//  SubjectsExample
//
//  Created by Hyeon on 2022/03/08.
//

import UIKit
import RxSwift

extension ViewController {
    enum MyError: Error{
        case anError
    }
    
    func behaviorSubject() {
        example(of: "BehaviorSubject") {
            
            // BehaviorSubject는 초기값을 필수로 선언해야 한다.
            let subject = BehaviorSubject(value: "Initial Value")
            let disposeBag = DisposeBag()
            
            subject.onNext("X")
            
            // 첫번째 구독자의 구독 요청
            subject
                .subscribe {
                    // 첫번째 구독자는 가장 최근에 발생한 이벤트인 "X" 받음
                    print("1)", $0)
                }
                .disposed(by: disposeBag)
            
            // 첫번째 구독자는 anError 이벤트를 새로 받게 됨
            subject.onError(MyError.anError)
            
            // 두번째 구독자의 구독 요청
            subject
                .subscribe {
                    // 두번째 구독자는 가장 마지막으로 발생한 이벤트인 anError를 받음
                    print("2)", $0)
                }
                .disposed(by: disposeBag)
        }
    }
}
