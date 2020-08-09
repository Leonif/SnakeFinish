//
//  GameScene.swift
//  SnakeFinish
//
//  Created by Leonid Nifantyev on 07.08.2020.
//  Copyright © 2020 Leonid Nifantyev. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var snake: Snake?
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.allowsRotation = false
        
        view.showsPhysics = true
        
        let leftButtonPoint = CGPoint(x: frame.minX + 30, y: frame.minY + 30)
        let leftButton = CircleButton(position: leftButtonPoint, name: "leftButton")
        addChild(leftButton)
        
        
        let rightButtonPoint = CGPoint(x: frame.maxX - (45 + 30), y: frame.minY + 30)
        let righButton = CircleButton(position: rightButtonPoint, name: "rightButton")
        addChild(righButton)
        
        
        let apple = makeApple()
        addChild(apple)
        
        let snakePoint = CGPoint(x: frame.midX + 50, y: frame.midY)
        snake = Snake(position: snakePoint)
        addChild(snake!)
    }
    
    
    private func makeApple() -> Apple {
        let applePoint = CGPoint(x: CGFloat.random(in: 0...frame.maxX), y: CGFloat.random(in: 45...frame.maxY))
        return Apple(position: applePoint)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let touchLocation: CGPoint = touch.location(in: self)
            
            guard let touchedNode = atPoint(touchLocation) as? SKShapeNode else { return }
                
            switch touchedNode.name {
            case "leftButton":
                touchedNode.fillColor = .green
                snake?.moveLeft()
            case "rightButton":
                touchedNode.fillColor = .red
                snake?.moveRight()
            default:
                return
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation: CGPoint = touch.location(in: self)
            
            guard let touchedNode = atPoint(touchLocation) as? SKShapeNode else { return }
                
            switch touchedNode.name {
            case "leftButton":
                touchedNode.fillColor = .gray
            case "rightButton":
                touchedNode.fillColor = .gray
            default:
                return
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        snake?.move()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let aMask = contact.bodyA.categoryBitMask
        let bMask = contact.bodyB.categoryBitMask
        
        switch (aMask, bMask) {
        case (CategoryBitMasks.apple.rawValue, CategoryBitMasks.snakeHead.rawValue):
            snake?.addBodyPart()
            let apple = contact.bodyA.node
            apple?.removeFromParent()
            
            let newApple = makeApple()
            addChild(newApple)
        default:
            break
        }
        
        
        
        
    }
}
