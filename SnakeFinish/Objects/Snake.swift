//
//  Snake.swift
//  SnakeFinish
//
//  Created by Leonid Nifantyev on 07.08.2020.
//  Copyright © 2020 Leonid Nifantyev. All rights reserved.
//

import SpriteKit


class Snake: SKShapeNode {
    
    private var body: [SnakeBodyPart] = []
    private let moveSpeed: CGFloat = 50
    private var angle: CGFloat = 0.0
    
    convenience init(position: CGPoint) {
        self.init()
        
        let head = SnakeHead(position: position)
        body.append(head)
        addChild(head)
    }
    
    func move() {
        moveHead()
        moveRestPart()
    }
    
    private func moveHead() {
        let head = body.first!
        
        let dx = moveSpeed * sin(angle)
        let dy = moveSpeed * cos(angle)
        let nextPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        head.run(moveAction)
    }
    
    private func moveRestPart() {
        for index in body.indices where index > 0 {
            let previousBodyPart = body[index - 1]
            let currentBodyPart = body[index]
            moveBodyParts(previousBodyPart, currentBodyPart)
        }
    }
    
    private func moveBodyParts(_ p1: SnakeBodyPart, _ p2: SnakeBodyPart) {
        let moveAction = SKAction.move(to: CGPoint(x: p1.position.x, y: p1.position.y), duration: 1.0)
        
        p2.run(moveAction)
    }
    
    func moveRight() {
        angle += CGFloat.pi / 2
    }
    
    func moveLeft() {
        angle -= CGFloat.pi / 2
    }
    
    
    func addBodyPart() {
        let firstSegment = body.first!
        let point = CGPoint(x: firstSegment.position.x, y: firstSegment.position.y)
        let newBodyPart = SnakeBodyPart(position: point)
        
        body.append(newBodyPart)
        addChild(newBodyPart)
        
    }
}

