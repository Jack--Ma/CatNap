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
    }
}