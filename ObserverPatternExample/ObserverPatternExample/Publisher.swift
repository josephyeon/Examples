//
//  Publisher.swift
//  ObserverPatternExample
//
//  Created by Hyeon on 2022/04/13.
//

import Foundation

protocol Publisher {
    var observers: [Observer] {get set}
    func subscribe(observer: Observer)
    func unSubscribe(observer: Observer)
    func notify(message: String)
}
