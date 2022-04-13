//
//  Observer.swift
//  ObserverPatternExample
//
//  Created by Hyeon on 2022/04/13.
//

import Foundation

protocol Observer {
    var id: String { get }
    func update(message: String)
}
