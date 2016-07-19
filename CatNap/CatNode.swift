//
//  CatNode.swift
//  CatNap
//
//  Created by JackMa on 16/7/18.
//  Copyright © 2016年 JackMa. All rights reserved.
//

import SpriteKit

class CatNode: SKSpriteNode {
    
}

extension CatNode: CustomNodeEvents {
    func didMoveToScene() {
        print("cat added to scene")
        
        let catBodyTexture = SKTexture(imageNamed: "cat_body_outline")
        parent!.physicsBody = SKPhysicsBody(texture: catBodyTexture, size: catBodyTexture.size())
        parent!.physicsBody!.categoryBitMask = PhysicsCategory.Cat
        parent!.physicsBody!.collisionBitMask = PhysicsCategory.Block
    }
}