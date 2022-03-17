//
//  ViewController.swift
//  Combinestagram
//
//  Created by Hyeon on 2022/03/16.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var itemAdd: UIBarButtonItem!

    private let bad = DisposeBag()
    private let images = Variable<[UIImage]>([])

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

