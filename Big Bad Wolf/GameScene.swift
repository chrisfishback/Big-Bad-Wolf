//
//  GameplayScene.swift
//  Big Bad Wolf
//
//  Created by Chris Fishback on 1/25/19.
//  Copyright © 2019 Chris Fishback. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    
    override func didMove(to view: SKView) {
        print("suck my ass")
        initialize()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackground()
        print("moved")
    }
    
    func initialize() {
        createBG()
    }
    
    func createBG() {
        for i in 0...2 {
            let bg = SKSpriteNode(imageNamed: "background")
            bg.name = "background"
            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            bg.position = CGPoint(x: CGFloat(i) * bg.size.width, y: 0)
            bg.zPosition = 0
            bg.size.width = 1340
            bg.size.height = 770
            self.addChild(bg)
        }
    }
    
    //    func createGrounds() {
    //        for i in 0...2 {
    //            let bg = SKSpriteNode(imageNamed: "ground")
    //            bg.name = ground"
    //            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    //            bg.position = CGPoint(x: CGFloat(i) * bg.size.width, y: -(self.frame.size.height / 2))
    //            bg.zPosition = 3
    //            self.addChild(bg)
    //        }
    //    }
    
    func moveBackground() {
        enumerateChildNodes(withName: "background", using: ({
            (node, error) in
            
            //code will be ligma
            node.position.x -= 4
            
        }))
    }
    
}

