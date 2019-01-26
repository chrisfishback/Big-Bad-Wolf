//
//  Player.swift
//  Big Bad Wolf
//
//  Created by Chris Fishback on 1/26/19.
//  Copyright © 2019 Chris Fishback. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    func initialize() {
        
        self.name = "narc"
        self.zPosition = 2
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.setScale(0.5)
        
    }
    
}
