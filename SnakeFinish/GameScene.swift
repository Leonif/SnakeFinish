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
    
    private func startGame() {
        let apple = makeApple()
        addChild(apple)
        
        let snakePoint = CGPoint(x: frame.midX + 50, y: frame.midY)
        snake = Snake(position: snakePoint)
        addChild(snake!)
    }
    
    private func restartGame() {
        if let snake = snake {
            snake.removeFromParent()
        }
        removeApple()
        
        startGame()
    }
    
    private func removeApple() {
        enumerateChildNodes(withName: "Apple") { (node, stop) in
            node.removeFromParent()
        }
    }

    private func buildControlls() {
        let leftButtonPoint = CGPoint(x: frame.minX + 30, y: frame.minY + 30)
        let leftButton = CircleButton(position: leftButtonPoint, name: "leftButton")
        addChild(leftButton)
        
        let rightButtonPoint = CGPoint(x: frame.maxX - (45 + 30), y: frame.minY + 30)
        let righButton = CircleButton(position: rightButtonPoint, name: "rightButton")
        addChild(righButton)
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.allowsRotation = false
        
        view.showsPhysics = true
        
        buildControlls()
        startGame()
    }
    
    
    private func makeApple() -> Apple {
        let applePoint = CGPoint(x: CGFloat.random(in: 0...frame.maxX), y: CGFloat.random(in: 45...frame.maxY))
        return Apple(position: applePoint)
    }
    
    private func isNodeOutOfBounds(node: SKNode) -> Bool {
        let bottomLeft = CGPoint(x: frame.minX, y: frame.minY)
        let topRight = CGPoint(x: frame.maxX, y: frame.maxY)
        
        let outOfBounds =  node.position.x < bottomLeft.x || node.position.x >= topRight.x || node.position.y < bottomLeft.y || node.position.y >= topRight.y
        
        return outOfBounds
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
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func update(_ currentTime: TimeInterval) {
        if let snake = snake, isNodeOutOfBounds(node: snake.getHead()) {
            restartGame()
            return
        }
        
        snake?.move()
    }
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard
            let apple = contact.bodyA.node as? Apple,
            let head = contact.bodyB.node as? SnakeHead else { return }
        
        snake?.addBodyPart()
        apple.removeFromParent()
        
        let newApple = makeApple()
        addChild(newApple)
    }
}
