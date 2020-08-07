//
//  GameViewController.swift
//  SnakeFinish
//
//  Created by Leonid Nifantyev on 07.08.2020.
//  Copyright © 2020 Leonid Nifantyev. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let skView = view as? SKView else {
            assertionFailure("skView is not created!!!"); return
        }
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        let scene = GameScene.init(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }

    
}
