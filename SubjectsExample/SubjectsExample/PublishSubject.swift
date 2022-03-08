//
//  PublishSubject.swift
//  SubjectsExample
//
//  Created by Hyeon on 2022/03/08.
//

import UIKit
import RxSwift

extension ViewController {
    func publishSubject() {
        example(of: "PublishSubject") {
            let subject = PublishSubject<String>()
            subject.onNext("This is Publish Subject")
            
            // 첫번째 구독 요청
            let subscriptionFirst = subject
                .subscribe({ (string) in
                    print(string)
                })
            // 첫번째 구독자는 1, 2번 subject 알림을 받음
            subject.on(.next("1"))
            subject.onNext("2")
            
            // 두번째 구독 요청
            let subscriptionSecond = subject
                .subscribe({ (event) in
                    print("2)", event.element ?? event)
                })
            
            // 두번째 구독자는 그 다음번 subject인 3번 받음
            subject.onNext("3")
            
            subscriptionFirst.dispose() // 첫번째 구독자 이벤트 해지
            
            subject.onNext("4") // 두번째 구독자는 그대로 4번 subject 받음
            
            subject.onCompleted() // subject completed 처리 (구독 모두 종료)
            
            subject.onNext("5") // 구독 종료 상황이라 아무것도 출력X
            
            let disposeBag = DisposeBag()
            
            // 현재 subject 상태 출력: completed
            subject
                .subscribe {
                    print("3)", $0.element ?? $0)
                }
                .disposed(by: disposeBag) // 쓰레기 처리
        }
    }
}
