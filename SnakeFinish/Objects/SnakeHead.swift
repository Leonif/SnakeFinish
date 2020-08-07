//
//  SnakeHead.swift
//  SnakeFinish
//
//  Created by Leonid Nifantyev on 07.08.2020.
//  Copyright © 2020 Leonid Nifantyev. All rights reserved.
//

import SpriteKit

class SnakeHead: SnakeBodyPart {
    
    override init(position: CGPoint) {
        super.init(position: position)
        
        physicsBody?.categoryBitMask = CategoryBitMasks.snakeHead.rawValue
        
        physicsBody?.contactTestBitMask = CategoryBitMasks.snakeBodyPart.rawValue | CategoryBitMasks.apple.rawValue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // test
}
