//
//  SnakeBodyPart.swift
//  SnakeFinish
//
//  Created by Leonid Nifantyev on 07.08.2020.
//  Copyright © 2020 Leonid Nifantyev. All rights reserved.
//

import SpriteKit



class SnakeBodyPart: SKShapeNode {
    
    let diameter: CGFloat = 10
    
    init(position: CGPoint) {
        super.init()
        
        
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        path = UIBezierPath(ovalIn: rect).cgPath
        
        fillColor = .green
        strokeColor = .green
        lineWidth = 5
        self.position = position
        name = "snakeBodyPart"
        
        let physicsCenter = CGPoint(x: diameter / 2, y: diameter / 2)
        physicsBody = SKPhysicsBody(circleOfRadius: diameter, center: physicsCenter)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = CategoryBitMasks.snakeBodyPart.rawValue
        physicsBody?.contactTestBitMask = CategoryBitMasks.apple.rawValue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayAsHead() {
        fillColor = .yellow
        strokeColor = .yellow
    }
}
