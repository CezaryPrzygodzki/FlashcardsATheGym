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
        title.text = "Podsumowanie treningu"
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
        startLabel.text = "Rozpoczęcie: \(getDate(date: training.start!))"
        endLabel.text = "Zakończenie: \(getDate(date: training.end!))"
        var time = secondsToHoursMinutesSeconds(seconds: Int(training.duration))
        durationLabel.text = "Czas trwania: \(makeTimeString(hours: time.0, minutes: time.1, seconds: time.2))"
        time = secondsToHoursMinutesSeconds(seconds: Int(training.learingDuration))
        learningDurationLabel.text = "Czas nauki: \(makeTimeString(hours: time.0, minutes: time.1, seconds: time.2))"
        time = secondsToHoursMinutesSeconds(seconds: Int(training.trainingDuration))
        trainingDurationLabel.text = "Czas ćwiczeń: \(makeTimeString(hours: time.0, minutes: time.1, seconds: time.2))"
        lessonNameLabel.text = "Lekcja: \(training.lessonName!)"
        finishedFlashcards.text = "Fiszki ukończone w: \(training.finishedFlashcards!)"
        
    }
    
    private func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd-MM-yyyy"
        
        return formatter.string(from: date)
    }
    
    
    private func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int){
        return ((seconds/3600),((seconds % 3600) / 60 ),((seconds % 3600) % 60 ))
    }
    private func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        if ( minutes == 0 && hours == 0){
            timeString += String(format: "%02d", seconds)
            timeString += " s"
        } else if ( minutes > 0 && minutes < 10 && hours == 0 ) {
            timeString += String(format: "%01d", minutes)
            timeString += " min "
            timeString += String(format: "%02d", seconds)
            timeString += " s"
        } else if ( minutes < 60 && hours == 0 ){
            timeString += String(format: "%02d", minutes)
            timeString += " min"
        } else {
            timeString += String(format: "%01d", hours)
            timeString += " h "
            timeString += String(format: "%02d", minutes)
            timeString += " min"
        }
        return timeString
    }
}
