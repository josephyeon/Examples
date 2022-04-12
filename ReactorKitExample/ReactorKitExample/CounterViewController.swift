//
//  UserViewController.swift
//  ReactorKitExample
//
//  Created by Hyeon on 2022/03/18.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

class CounterViewController: UIViewController, StoryboardView {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var countLabel!: UILabel!
    @IBOutlet weak var increaseButton: UIButton!
    
    func bind(reactor: CounterViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: CounterViewReactor) {
        increaseButton.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor)
            .disposed(by: disposeBag)
    }
}
