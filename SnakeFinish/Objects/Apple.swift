//
//  Apple.swift
//  SnakeFinish
//
//  Created by Leonid Nifantyev on 07.08.2020.
//  Copyright © 2020 Leonid Nifantyev. All rights reserved.
//

import SpriteKit


class Apple: SKShapeNode {
    
    let diameter: CGFloat = 10
    
    convenience init(position: CGPoint) {
        self.init()
        
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        path = UIBezierPath(ovalIn: rect).cgPath
        fillColor = .red
        strokeColor = .red
        lineWidth = 5
        
        self.position = position
        
        name = "Apple"
        
        let physicsCenter = CGPoint(x: diameter / 2, y: diameter / 2)
        physicsBody = SKPhysicsBody(circleOfRadius: 10, center: physicsCenter)
        
    }
}
//trarar
