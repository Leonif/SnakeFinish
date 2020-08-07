//
//  CircleButton.swift
//  SnakeFinish
//
//  Created by Leonid Nifantyev on 07.08.2020.
//  Copyright © 2020 Leonid Nifantyev. All rights reserved.
//

import SpriteKit

class CircleButton: SKShapeNode {
    
    convenience init(position: CGPoint, name: String) {
        self.init()
        
        let rect = CGRect(x: 0, y: 0, width: 45, height: 45)
        path = UIBezierPath(ovalIn: rect).cgPath
        
        self.position = position
        
        fillColor = UIColor.gray
        strokeColor = UIColor.gray
        lineWidth = 10
        self.name = name
    }
    
}
