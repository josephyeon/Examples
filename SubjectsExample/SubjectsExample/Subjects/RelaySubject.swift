//
//  RelaySubject.swift
//  SubjectsExample
//
//  Created by Hyeon on 2022/03/08.
//

import UIKit
import RxSwift

extension ViewController {
    func relaySubject() {
        // ReplaySubject의 버퍼사이즈 지정
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        let disposeBag = DisposeBag()
        
        // 이벤트 발생
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        
        // 첫번째 구독자 구독
        // 버퍼사이즈만큼 이벤트 1과 2만 받음
        subject
            .subscribe {
                print("1)", $0)
            }
            .disposed(by: disposeBag)
        
        // 두번째 구독자 구독
        // 여기서도 버퍼사이즈 만큼 이벤트 2, 3만 받음
        subject
            .subscribe {
                print("2)", $0)
            }
            .disposed(by: disposeBag)
        
        // 새로운 이벤트 4 발생 -> 1개만 발생했으니 모두 받음
        subject.onNext("4")
        
        // 에러 1개 발생 -> 구독자 모두 전달 받음
        subject.onError(MyError.anError)
        subject.dispose() // 꼭 dispose 처리해줘야 에러문만 전달 받을 수 있음!

        /*
         
        // dispose() 처리 안하는 경우
        // 현 상황에서 구독자 3이 구독을 요청한다 가정
        // 에러 발생시에도 이벤트와 함께 받게 됨
        subject.subscribe {
            print("3)", $0)
        }
        .disposed(by: disposeBag)
         
         */
        
    }
}
