//
//  BedNode.swift
//  CatNap
//
//  Created by JackMa on 16/7/18.
//  Copyright © 2016年 JackMa. All rights reserved.
//

import SpriteKit

class BedNode: SKSpriteNode {
    
}

extension BedNode: CustomNodeEvents {
    func didMoveToScene() {
        print("bed added to scene")
        
        let bedBodySize = CGSize(width: 40.0, height: 30.0)
        physicsBody = SKPhysicsBody(rectangleOfSize: bedBodySize)
        physicsBody!.dynamic = false
        physicsBody!.categoryBitMask = PhysicsCategory.Bed
        physicsBody!.collisionBitMask = PhysicsCategory.None
    }
}