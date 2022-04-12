//
//  CounterViewReactor.swift
//  ReactorKitExample
//
//  Created by Hyeon on 2022/03/18.
//

import Foundation
import RxSwift
import RxCocoa
import ReactorKit

class CounterViewReactor: Reactor {
    let initialState = State()
    
    enum Action { // View로부터 받을 Action을 enum으로 정의
        case increase
        case decrease
    }
    
    enum Mutation { // View로부터 Action을 받을 경우, 해야할 작업 단위들을 enum으로 정의
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    struct State { // 현재 상태를 기록하고 있으며, View에서 해당 정보를 사용해 UI 업데이트 및 Reactor에서 image를 얻을 때 page 정보들을 저장
        var value = 0
        var isLoading = false
    }
    
    // Action이 들어온 경우, 어떤 처리를 할 것인지 Mutation에서 정의한 작어 단위들을 사용해 Observable로 방출
    // concat 연산자를 이용해 비동기 처리가 유용해짐
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                Observable.just(.increaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(.setLoading(false))
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                Observable.just(.increaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(.setLoading(false))
            ])
        }
    }
    
    // 현재 상태와 작업 단위를 받아 최종 상태를 반환
    // mutation(action: ) 실행 후 바로 reduce 메서드 실행
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}
