//
//  ClockView.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 31/05/2021.
//

import Foundation
import UIKit

class ClockView: UIView {
    private let shapeLayer = CAShapeLayer()
    private let type : SelectTrainigModeViewController.TypeOfTraining

    init(frame: CGRect, type: SelectTrainigModeViewController.TypeOfTraining) {
        
        self.type = type
        super.init(frame: frame)
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        backgroundView.backgroundColor = .clear
        backgroundView.layer.cornerRadius = frame.size.width / 2
        self.addSubview(backgroundView)
        
        let radius : CGFloat = frame.size.width / 2 - frame.size.width / 14
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .init(x: frame.size.width / 2, y: frame.size.width / 2),
                                         radius: radius,
                                         startAngle: -CGFloat.pi / 2,
                                         endAngle: 1.5 * CGFloat.pi ,
                                         clockwise: true)
        trackLayer.path = circularPath.cgPath
         
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = radius / 5
         
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round //rounded corners of the circle
        backgroundView.layer.addSublayer(trackLayer)
        

        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = Colors.FATGpink?.cgColor
        shapeLayer.lineWidth = radius / 5
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round //rounded corners of the circle
        
        
        shapeLayer.strokeEnd = type == .cardio ? 1 : 0 //the animation will be displayed from full to empty if it is cardio, and from empty to full if it is strength
        backgroundView.layer.addSublayer(shapeLayer)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func anim(duration: Double, completion: @escaping () -> Void){
        //set keyValue - the parameter that will be inserted into the animation
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = self.type == .cardio ? 0 : 1 //the animation will be displayed from full to empty if it is cardio, and from empty to full if it is strength
        basicAnimation.duration = duration
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        
        shapeLayer.add(basicAnimation, forKey: "basic")

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion()
            }
    }
}
