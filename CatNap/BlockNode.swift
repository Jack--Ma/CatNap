//
//  BlockNode.swift
//  CatNap
//
//  Created by JackMa on 16/7/19.
//  Copyright © 2016年 JackMa. All rights reserved.
//

import SpriteKit

class BlockNode: SKSpriteNode {
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        print("destory block")
        interact()
    }
}

extension BlockNode: CustomNodeEvents, InteractiveNode {
    func didMoveToScene() {
        userInteractionEnabled = true
    }
    
    func interact() {
        userInteractionEnabled = false
        runAction(SKAction.sequence([
            SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false),
            SKAction.scaleTo(0.8, duration: 0.1),
            SKAction.removeFromParent()
            ]))
    }
}