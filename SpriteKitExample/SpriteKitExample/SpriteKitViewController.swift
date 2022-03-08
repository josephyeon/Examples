//
//  ViewController.swift
//  SpriteKitExample
//
//  Created by Hyeon on 2022/03/04.
//

import UIKit
import SpriteKit

class SpriteKitViewController: UIViewController {

    @IBOutlet weak var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene: SpriteKitScene = SpriteKitScene(size: skView.bounds.size)
        skView.presentScene(scene)
        skView.scene?.backgroundColor = SKColor.white
        skView.scene?.scaleMode = .fill

    }
}

