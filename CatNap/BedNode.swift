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
    }
}