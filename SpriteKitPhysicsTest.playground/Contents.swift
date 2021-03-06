//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import XCPlayground

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 480, height: 320))
let scene = SKScene(size: CGSize(width: 480, height: 320))
scene.physicsBody = SKPhysicsBody(edgeLoopFromRect: scene.frame)
sceneView.showsPhysics = true
sceneView.showsFPS = true
sceneView.presentScene(scene)

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
XCPlaygroundPage.currentPage.liveView = sceneView

let square = SKSpriteNode(imageNamed: "square")
square.name = "shape"
square.position = CGPoint(x: scene.size.width*0.25, y: scene.size.height*0.50)
square.physicsBody = SKPhysicsBody(rectangleOfSize: square.frame.size)
scene.addChild(square)

let circle = SKSpriteNode(imageNamed: "circle")
circle.name = "shape"
circle.position = CGPoint(x: scene.size.width*0.5, y: scene.size.height*0.5)
circle.physicsBody = SKPhysicsBody(circleOfRadius: circle.size.width/2)
circle.physicsBody!.dynamic = false//false表示不收任何力的影响
scene.addChild(circle)
let circleMove = SKAction.repeatActionForever(SKAction.sequence([
    SKAction.moveToX(0.0, duration: 1.0),
    SKAction.moveToX(scene.size.width, duration: 1.0)
    ]))
circle.runAction(circleMove)

let triangle = SKSpriteNode(imageNamed: "triangle")
triangle.name = "shape"
triangle.position = CGPoint(x: scene.size.width*0.75, y: scene.size.height*0.50)
//绘制三角形
var trianglePath = CGPathCreateMutable()
CGPathMoveToPoint(trianglePath, nil, -triangle.size.width/2, -triangle.size.height/2)
CGPathAddLineToPoint(trianglePath, nil, triangle.size.width/2, -triangle.size.height/2)
CGPathAddLineToPoint(trianglePath, nil, 0, triangle.size.height/2)
CGPathAddLineToPoint(trianglePath, nil, -triangle.size.width/2, -triangle.size.height/2)
triangle.physicsBody = SKPhysicsBody(polygonFromPath: trianglePath)
scene.addChild(triangle)

let l = SKSpriteNode(imageNamed: "L")
l.name = "shape"
l.position = CGPoint(x: scene.size.width * 0.5, y: scene.size.height * 0.75)
l.physicsBody = SKPhysicsBody(texture: l.texture!, size: l.size)
scene.addChild(l)

func spawnSand() {
    let sand = SKSpriteNode(imageNamed: "sand")
    
    sand.position = CGPoint(x: random(min: 0.0, max: scene.size.width),
                            y: scene.size.height - sand.size.height)
    sand.physicsBody = SKPhysicsBody(circleOfRadius: sand.size.width/2)
    sand.name = "sand"
    sand.physicsBody!.restitution = 1
    sand.physicsBody!.density = 20.0
    scene.addChild(sand)
}

func shake() {
    //applyImpulse强行改变node的速度
    scene.enumerateChildNodesWithName("sand") { (node, _) in
        node.physicsBody!.applyImpulse(CGVector(dx: 0, dy: random(min: 20, max: 40)))
    }
    scene.enumerateChildNodesWithName("shape") { (node, _) in
        node.physicsBody!.applyImpulse(CGVector(dx: random(min: 20, max: 60), dy: random(min: 20, max: 60)))
    }
    
    delay(seconds: 3, completion: shake)
}

scene.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
delay(seconds: 2.0) { 
    scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
    scene.runAction(
        SKAction.repeatAction(
            SKAction.sequence([
                SKAction.runBlock(spawnSand),
                SKAction.waitForDuration(0.1)]
            ), count: 100
        )
    )
    delay(seconds: 12, completion: shake)
}

var blowingRight = true
var windForce = CGVector(dx: 50, dy: 0)
extension SKScene {
    func windWithTimer(timer: NSTimer) {
        //applyForce为node加上一定的力
        self.enumerateChildNodesWithName("sand") { (node, _) in
            node.physicsBody!.applyForce(windForce)
        }
        self.enumerateChildNodesWithName("shape") { (node, _) in
            node.physicsBody!.applyForce(windForce)
        }
    }
    
    func switchWindDiction(timer: NSTimer) {
        blowingRight = !blowingRight
        windForce = CGVector(dx: blowingRight ? 50 : -50, dy: 0)
    }
}

NSTimer.scheduledTimerWithTimeInterval(0.05, target: scene, selector: #selector(SKScene.windWithTimer), userInfo: nil, repeats: true)
NSTimer.scheduledTimerWithTimeInterval(3.0, target: scene, selector: #selector(SKScene.switchWindDiction), userInfo: nil, repeats: true)


