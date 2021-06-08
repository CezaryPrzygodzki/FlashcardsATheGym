//
//  BreakTimeView.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 02/06/2021.
//

import Foundation
import UIKit

class BreakTimeView: UIView{
    private let title = UILabel()
    
    private let button1 = UIButton()
    private let button2 = UIButton()
    private let button3 = UIButton()
    private let button4 = UIButton()

    private let horizonralStack1 = UIStackView()
    private let horizontalStack2 = UIStackView()
    
    private let verticalStack = UIStackView()
    
    var checkButtonPressed : ((_ numberOfSeconds: Int) -> Void) = {_ in} // here, I get information in the TrainingSessionViewController about the button press
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        backgroundColor = Colors.FATGWhiteBlack
        
        configureTitile()
        configureButtons()
        
        configureHS1()
        configureHS2()
        
        configureVerticalStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTitile() {
        title.text = "Wybierz czas przerwy"
        title.textColor = Colors.FATGtext
        title.font = UIFont.systemFont(ofSize: 25)
        title.textAlignment = .center
        title.layer.cornerRadius = 20
        title.layer.masksToBounds = true
        title.backgroundColor = Colors.FATGpink
        title.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(title)
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: -40).isActive = true
        title.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    private func configureButtons(){
        button1.breakTimeButton(seconds: 10)
        button1.addTarget(self, action: #selector(butt1), for: .touchUpInside)
        
        button2.breakTimeButton(seconds: 45)
        button2.addTarget(self, action: #selector(butt2), for: .touchUpInside)
        
        button3.breakTimeButton(seconds: 60)
        button3.addTarget(self, action: #selector(butt3), for: .touchUpInside)
        
        button4.breakTimeButton(seconds: 90)
        button4.addTarget(self, action: #selector(butt4), for: .touchUpInside)
    
    }
    
    @objc private func butt1(){
        checkButtonPressed(10)
    }
    @objc private func butt2(){
        checkButtonPressed(45)
    }
    @objc private func butt3(){
        checkButtonPressed(60)
    }
    @objc private func butt4(){
        checkButtonPressed(90)
    }
    
    private func configureHS1() {
        horizonralStack1.addArrangedSubview(button1)
        horizonralStack1.addArrangedSubview(button2)
        horizonralStack1.axis = .horizontal
        horizonralStack1.distribution = .fillEqually
        horizonralStack1.spacing = 20

    }
    private func configureHS2() {
        horizontalStack2.addArrangedSubview(button3)
        horizontalStack2.addArrangedSubview(button4)
        horizontalStack2.axis = .horizontal
        horizontalStack2.distribution = .fillEqually
        horizontalStack2.spacing = 20
    }
    private func configureVerticalStack() {
        addSubview(verticalStack)
        
        verticalStack.addArrangedSubview(horizonralStack1)
        verticalStack.addArrangedSubview(horizontalStack2)
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        verticalStack.spacing = 20
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        verticalStack.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
}

