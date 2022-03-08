//
//  ViewController.swift
//  RxCocoaBasic
//
//  Created by Hyeon on 2022/03/08.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var disposeBag = DisposeBag()
    let items = ["1", "2", "3", "4", "5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateItems()
    }
    private func updateItems() {
        let items = Observable.just((1...5).map { "\($0)" })
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = "\(element)"
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe { item in
                print("\(item)")
            }
            .disposed(by: disposeBag)
    }

}



