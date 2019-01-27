//
//  GameplayScene.swift
//  Big Bad Wolf
//
//  Created by Chris Fishback on 1/25/19.
//  Copyright © 2019 Chris Fishback. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var narc = Player()
    
    var obstacles = [SKSpriteNode]()
    var doors = [SKSpriteNode]()
    
    var canJump = false
    
    override func didMove(to view: SKView) {
        print("suck my ass")
        initialize()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackground()
    }
    
    //jumping STUFFFFFFFFFFFFFF
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canJump {
            canJump = false
            narc.jump()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "narc" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "narc" && secondBody.node?.name == "ground" {
            canJump = true
        }
        if firstBody.node?.name == "narc" && secondBody.node?.name == "Obstacle" {
            canJump = true
        }
        
    }
    
    func initialize() {
        
        physicsWorld.contactDelegate = self
        
        createPlayer()
        createBG()
        createGround()
        createDoors()
        createObstacles()
        
        Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(self.spawnObstacles), userInfo: nil, repeats: true)
    }
    
    func createPlayer() {
        
        narc = Player(imageNamed: "narc1.jpg")
        narc.initialize()
        narc.position = CGPoint(x: -250, y: 20)
        self.addChild(narc)
        
    }
    
    func createBG() {
        for i in 0...2 {
            let bg = SKSpriteNode(imageNamed: "background")
            bg.name = "background"
            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            bg.size.width = 1340
            bg.size.height = 770
            bg.position = CGPoint(x: CGFloat(i) * bg.size.width, y: 0)
            bg.zPosition = 0
            self.addChild(bg)
        }
    }
    
    //-(self.frame.size.height / 2)
    func createGround() {
        for i in 0...2 {
            let ground = SKSpriteNode(imageNamed: "floor")
            ground.name = "ground"
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: -(self.frame.size.height / 3))
            ground.zPosition = 3
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.affectedByGravity = false
            ground.physicsBody?.isDynamic = false
            ground.physicsBody?.categoryBitMask = ColliderType.Ground
            self.addChild(ground)
        }
    }
    
    func moveBackground() {
        enumerateChildNodes(withName: "background", using: ({
            (node, error) in
            
            let bgNode = node as! SKSpriteNode
            
            //code will be ligma
            bgNode.position.x -= 3
            
            if bgNode.position.x < -(self.frame.width) {
                bgNode.position.x += bgNode.size.width * 3
            }
        }))
    }
    
    func createObstacles() {
        let obstacle = SKSpriteNode(imageNamed: "fire")
        
        obstacle.name = "Obstacle"
        obstacle.setScale(0.5)
        
        obstacle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        obstacle.zPosition = 1
        
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.allowsRotation = false
        obstacle.physicsBody?.categoryBitMask = ColliderType.Obstacle
        
        obstacles.append(obstacle)
    }
    
    func createDoors() {
        
        let door = SKSpriteNode(imageNamed: "door")
        
        door.name = "Door"
        door.setScale(0.5)
        
        door.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        door.zPosition = 1
        
        door.physicsBody = SKPhysicsBody(rectangleOf: door.size)
        door.physicsBody?.allowsRotation = false
        door.physicsBody?.categoryBitMask = ColliderType.Obstacle
        
        doors.append(door)
    }
    
    @objc func spawnObstacles() {
        
        let index = Int(arc4random_uniform(UInt32(obstacles.count)))
        
        let obstacle = obstacles[index].copy() as! SKSpriteNode
        
        obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: 50)
        
        let move = SKAction.moveTo(x: -self.frame.size.width * 2, duration: TimeInterval(15))
        let remove = SKAction.removeFromParent()

        let sequence = SKAction.sequence([move, remove])
        
        obstacle.run(sequence)
        
        self.addChild(obstacle)
    }
    
    @objc func spawnDoors() {
        
    }
    
}

