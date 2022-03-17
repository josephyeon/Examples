//
//  SubjectChallenges.swift
//  SubjectsExample
//
//  Created by Hyeon on 2022/03/16.
//

import UIKit
import RxSwift
import RxCocoa

extension ViewController{
    
    func dealer() {
        example(of: "PublishSubject") {
            let dealtHand = PublishSubject<[(String, Int)]>()
            let disposeBag = DisposeBag()
            
        }
    }
    
    func point(for hand: [(String, Int)]) {
        
    }
    
    
}
