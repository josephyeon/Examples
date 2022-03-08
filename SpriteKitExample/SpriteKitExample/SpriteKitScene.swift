//
//  SpriteKitScene.swift
//  SpriteKitExample
//
//  Created by Hyeon on 2022/03/04.
//

import Foundation
import SpriteKit

class SpriteKitScene: SKScene, SKPhysicsContactDelegate {
    private var index: Int = 0
    
    private var node: SKShapeNode!
    private var touchPoint: CGPoint = CGPoint()
    private var touching: Bool = false
    private var xDif = CGFloat()
    private var yDif = CGFloat()
    
    override func sceneDidLoad() {
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody.init(edgeLoopFrom: frame)
        
        let color = SKColor.magenta
        for _ in 1...arc4random_uniform(UInt32(10)) {
            let location = CGPoint(
                x: CGFloat(arc4random_uniform(UInt32(frame.width))),
                y: frame.height - CGFloat(arc4random_uniform(UInt32(frame.height)))
            )
            
            addChild( createBox(location: location, color: color))

        }
    }
    
    // 터치하기 시작하고 나서 변화사항 ... 좌표 및 변화 거리 기록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let loc = touch.location(in: self)
            let node: SKNode = self.atPoint(loc)
            
            if node.name == nil {return}
            
            if (node.name?.contains("figure"))! {
                self.node = (node as! SKShapeNode)
                xDif = node.position.x - loc.x
                yDif = node.position.y - loc.y
                
                if node.frame.contains(loc) {
                    touchPoint = loc
                    touching = true
                }
            }
        }
    }
    
    // 터치 이동하고서 변화사항 ... location 변화 기록
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let loc = touch.location(in: self)
            touchPoint = loc
        }
    }
    
    // 터치 끝나고 나서 변화사항 ... touching 부분만 false로 설정
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touching = false
    }
    
    // 시간 바탕으로 업데이트 함수 (조건: touching = true)
    override func update(_ currentTime: TimeInterval) {
        if touching {
            let dt: CGFloat = 1.0 / 30.0
            let distance = CGVector(
                dx: touchPoint.x - node.position.x + xDif,
                dy: touchPoint.y - node.position.y + yDif
            )
            
            let velocity = CGVector(
                dx: distance.dx / dt,
                dy: distance.dy / dt
            )
            
            node.physicsBody?.velocity = velocity
        }
    }
    
    private func createBox(location: CGPoint, color:SKColor ) -> SKShapeNode {
        
        let figure = SKShapeNode(circleOfRadius: 40)
        figure.position = location
        figure.fillColor = color
        figure.name = "figure_\(index)"
        
        figure.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        figure.physicsBody?.isResting = false
        figure.physicsBody?.isDynamic = true
        figure.physicsBody?.restitution = 0.5
        figure.physicsBody?.friction = 0.5
        
        index += 1
        return figure
    }
}
