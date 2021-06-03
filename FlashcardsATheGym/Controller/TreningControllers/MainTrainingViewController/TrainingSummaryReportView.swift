//
//  TrainingSummaryReportView.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 03/06/2021.
//

import UIKit

class TrainingSummaryReportView: UIView {

    private let title = UILabel()
    
    private let startLabel = UILabel()
    private let endLabel = UILabel()
    private let durationLabel = UILabel()
    
    private let learningDurationLabel = UILabel()
    private let trainingDurationLabel = UILabel()
    
    private let lessonNameLabel = UILabel()
    private let finishedFlashcards = UILabel()
    
    private let verticalStack = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        backgroundColor = Colors.FATGWhiteBlack
        
        configureTitile()
        configureLabels()
        configureHStack()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTitile() {
        title.text = "Podsumowanie trenignu"
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
    
    
    private func configureLabels() {
        startLabel.trainingSummaryLabel(text: "Rozpoczęcie:")
        endLabel.trainingSummaryLabel(text: "Zakończenie: ")
        durationLabel.trainingSummaryLabel(text: "Czas trwania: ")
        learningDurationLabel.trainingSummaryLabel(text: "Czas nauki: ")
        trainingDurationLabel.trainingSummaryLabel(text: "Czas ćwiczeń: ")
        lessonNameLabel.trainingSummaryLabel(text: "Lekcja: ")
        finishedFlashcards.trainingSummaryLabel(text: "Fiszki ukończone w: ")
    }
    
    private func configureHStack() {
        verticalStack.addArrangedSubview(startLabel)
        verticalStack.addArrangedSubview(endLabel)
        verticalStack.addArrangedSubview(durationLabel)
        verticalStack.addArrangedSubview(learningDurationLabel)
        verticalStack.addArrangedSubview(trainingDurationLabel)
        verticalStack.addArrangedSubview(lessonNameLabel)
        verticalStack.addArrangedSubview(finishedFlashcards)
        
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        
        addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        verticalStack.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
    
    func configureLabelsText(training: Training){
        startLabel.text = "Rozpoczęcie: \(training.start!)"
        endLabel.text = "Zakończenie: \(training.end!)"
        durationLabel.text = "Czas trwania: \(training.duration)"
        learningDurationLabel.text = "Czas nauki: \(training.learingDuration)"
        trainingDurationLabel.text = "Czas ćwiczeń: \(training.trainingDuration)"
        lessonNameLabel.text = "Lekcja: \(training.lessonName!)"
        finishedFlashcards.text = "Fiszki ukończone w: \(training.finishedFlashcards!)%"
        
    }
}
