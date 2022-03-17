//
//  PublishRelay.swift
//  SubjectsExample
//
//  Created by Hyeon on 2022/03/16.
//

import UIKit
import RxSwift
import RxCocoa // RxCocoa 필요하다.

extension ViewController {
    func publishRelay() {
        example(of: "PublishRelay") {
            let relay = PublishRelay<String>()
            let disposeBag = DisposeBag()
            relay.accept("똑, 똑, 똑 아무도 없나요?")
            
            relay
                .subscribe {
                    print($0)
                }
                .disposed(by: disposeBag)
            
            relay.accept("1")
//            relay.accept(MyError.anError)
//            relay.onCompleted()
        }
    }
}

