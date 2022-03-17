//
//  BehaviorRelay.swift
//  SubjectsExample
//
//  Created by Hyeon on 2022/03/16.
//

import UIKit
import RxSwift
import RxCocoa

extension ViewController {
    func behaviorRelay() {
        example(of: "BehaviorRelay") {
            let relay = BehaviorRelay(value: "Initial Value")
            let disposeBag = DisposeBag()
            
            // 이벤트 발생
            relay.accept("New initial value")
            
            // 1번 구독 시작
            relay.subscribe {
                print("1)", $0)
            } // 1번 구독자에게 "New initial value" 방출
            .disposed(by: disposeBag)
            
            // 이벤트 발생 -> 현재 1번만 구독된 상황이기 때문에 1번에게 방출
            relay.accept("1")
            
            // 2번 구독 시작
            relay
                .subscribe {
                    print("2)", $0)
                } // 2번 구독자에게 1 방출
                .disposed(by: disposeBag)

            // 1, 2번 구독자 모두에게 2 방출
            relay.accept("2")
        }
    }
}
