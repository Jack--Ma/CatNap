//
//  GameScene.swift
//  CatNap
//
//  Created by JackMa on 16/7/13.
//  Copyright (c) 2016年 JackMa. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None:  UInt32 = 0b000
    static let Cat:   UInt32 = 0b001
    static let Block: UInt32 = 0b010
    static let Bed:   UInt32 = 0b100
}

protocol CustomNodeEvents {
    func didMoveToScene()
}

protocol InteractiveNode {
    func interact()
}

class GameScene: SKScene {
    var bedNode: BedNode!
    var catNode: CatNode!
    
    override func didMoveToView(view: SKView) {
        SKTAudio.sharedInstance().playBackgroundMusic("backgroundMusic.mp3")
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let maxAspectRatioHeight: CGFloat = size.width / maxAspectRatio
        let playableMargin: CGFloat = (size.height - maxAspectRatioHeight) / 2.0
        
        let playableRect = CGRect(x: 0.0, y: playableMargin, width: size.width, height: size.height - playableMargin*2)
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: playableRect)
        
        //找到所有结点
        enumerateChildNodesWithName("//*") { (node, _) in
            if let customNode = node as? CustomNodeEvents {
                customNode.didMoveToScene()
            }
        }
        
        bedNode = childNodeWithName("bed") as! BedNode
        catNode = childNodeWithName("//cat_body") as! CatNode
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
