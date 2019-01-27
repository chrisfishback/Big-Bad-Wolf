//
//  Player.swift
//  Big Bad Wolf
//
//  Created by Chris Fishback on 1/26/19.
//  Copyright © 2019 Chris Fishback. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let Player: UInt32 = 1
    static let Ground: UInt32 = 2
    static let Obstacle: UInt32 = 3
}

class Player: SKSpriteNode {
    
    func initialize() {
        
        var walk = [SKTexture]()
        
        for i in 1...10 {
            let name = "narc\(i).jpg"
            walk.append(SKTexture(imageNamed: name))
            
        }
        
        let walkAnimation = SKAction.animate(with: walk, timePerFrame: TimeInterval(0.10), resize: true, restore: true)
        
        self.name = "narc"
        self.zPosition = 2
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.setScale(0.5)
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.Ground | ColliderType.Obstacle
        self.physicsBody?.contactTestBitMask = ColliderType.Obstacle
        
        self.run(SKAction.repeatForever(walkAnimation))
    }
    
    func jump() {
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 2000))
    }
    
}
