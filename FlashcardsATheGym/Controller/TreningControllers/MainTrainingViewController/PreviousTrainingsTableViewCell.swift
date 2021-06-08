//
//  PreviousTrainingsTableViewCell.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 17/01/2021.
//


import UIKit

class PreviousTrainingsTableViewCell: UITableViewCell {
    
    private let cellWidth = UIScreen.main.bounds.size.width - 50
    private let cellHeight : CGFloat = 130
    private let padding: CGFloat = 15
    
    private let background = UIView()
    
    private let dayLabelView = UIView()
    private let monthDateLabel = UILabel()
    private let dayDateLabel = UILabel()
    
    private let timeLabel = UILabel()
    private let listLabel = UILabel()
    private let flashcardsDoneLabel = UILabel()
    private var stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        addSubview(background)
        configureBackground()
        
        background.addSubview(dayLabelView)
        configureDayLabelView()
        
        dayLabelView.addSubview(monthDateLabel)
        configureMonthDateLabel()
        
        dayLabelView.addSubview(dayDateLabel)
        configureDayDateLabel()
        
        configureTimeListFlashcardsDoneLabels()
        stackView = configureStackView()
        background.addSubview(stackView)
     }
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    
    func configureRow(training: Training){
        let time = secondsToHoursMinutesSeconds(seconds: Int(training.duration))
        timeLabel.text = "Czas: \(makeTimeString(hours: time.0, minutes: time.1, seconds: time.2))"
        listLabel.text = "Lista: \(training.lessonName!)"
        flashcardsDoneLabel.text = "Fiszki ukończone w: \(training.finishedFlashcards!)"
        monthDateLabel.text = getMonth(date: training.end!).uppercased()
        dayDateLabel.text = getDay(date: training.end!)
    }
    
    private func getMonth(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        formatter.locale = Locale(identifier: "pl_PL")
        return formatter.string(from: date)
    }
    private func getDay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
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
    private func configureBackground() {
        background.backgroundColor = Colors.FATGWhiteBlack
        background.layer.cornerRadius = 10
        background.frame.size.height = cellHeight - 20
        background.frame.size.width = cellWidth
    }
    
    private func configureDayLabelView() {
        dayLabelView.backgroundColor = Colors.FATGpink
        dayLabelView.layer.cornerRadius = 7
        
        dayLabelView.frame.size.height = background.frame.size.height - padding - padding
        dayLabelView.frame.size.width = dayLabelView.frame.size.height
        
        dayLabelView.frame = CGRect(x: padding,
                                    y: padding,
                                    width: dayLabelView.frame.size.width,
                                    height: dayLabelView.frame.size.height)
    }
    
    private func configureMonthDateLabel(){
        monthDateLabel.text = "STY"
        monthDateLabel.textColor = .white
        monthDateLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        monthDateLabel.textAlignment = .center
        
        monthDateLabel.frame.size.width = dayLabelView.frame.size.width
        monthDateLabel.frame.size.height =  dayLabelView.frame.size.height / 2
        
        monthDateLabel.frame = CGRect(x: 0,
                                      y: 5,// ustawiłem 5, żeby miesiąć i dzień były bliżej siebie - bliżej środka
                                      width: monthDateLabel.frame.size.width ,
                                      height:  monthDateLabel.frame.size.height)
        
    }
    
    private func configureDayDateLabel() {
        dayDateLabel.text = "27"
        dayDateLabel.textColor = .white
        dayDateLabel.font = UIFont.systemFont(ofSize: 30, weight: .black)
        dayDateLabel.textAlignment = .center
        
        dayDateLabel.frame.size.width = dayLabelView.frame.size.width
        dayDateLabel.frame.size.height =  dayLabelView.frame.size.height / 2
        
        dayDateLabel.frame = CGRect(x: 0,
                                    y: monthDateLabel.frame.size.height - 5 , // ustawiłem 5, żeby miesiąć i dzień były bliżej siebie - bliżej środka
                                    width: dayDateLabel.frame.size.width,
                                    height: dayDateLabel.frame.size.height)
        
    }
    
    private func configureTimeListFlashcardsDoneLabels(){
        
        timeLabel.textColor = Colors.FATGtext
        listLabel.textColor = Colors.FATGtext
        flashcardsDoneLabel.textColor = Colors.FATGtext
        
        timeLabel.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        listLabel.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        flashcardsDoneLabel.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        
        timeLabel.text = "Czas: 40 min"
        listLabel.text = "Lista: Idiomy hiszpańskie"
        flashcardsDoneLabel.text = "Fiszki ukończone: 70%"
        
    }
    
    private func configureStackView() -> UIStackView {
        let sv = UIStackView(arrangedSubviews: [
            timeLabel,
            listLabel,
            flashcardsDoneLabel
        ])
        
        sv.axis = .vertical
        sv.distribution = .fillEqually
        
        sv.frame.size.width = background.frame.size.width - dayLabelView.frame.size.width - padding - padding
        sv.frame = CGRect(x: dayLabelView.frame.size.width + padding + padding, y: padding, width: sv.frame.size.width, height: background.frame.size.height - padding - padding)
        
        //sv.spacing = 10
        
        return sv
    }
}
