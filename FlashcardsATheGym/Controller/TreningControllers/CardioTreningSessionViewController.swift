//
//  CardioTreningSessionViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 08/05/2021.
//

import UIKit

class CardioTreningSessionViewController: TreningSessionViewController {

//    var cardioDuration: Double!
//    private let timeLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureClockView(typeOfTrening: .cardio)
//        view.addSubview(clockView)
//
//        view.addSubview(timeLabel)
//        configureTimeLabel()
//
//        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timer), userInfo: nil, repeats: true)
//        clockView.anim(duration: cardioDuration) {
//
//            print("koniec cardio")
//        }
//
//
//    }
//
//    @objc private func timer(){
//        cardioDuration -= 1
//        let time = secondsToHoursMinutesSeconds(seconds: Int(cardioDuration))
//        timeLabel.text = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
//    }
//
//    private func configureTimeLabel(){
//
//        timeLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
//        timeLabel.textColor = Colors.FATGtext
//
//        timeLabel.frame = CGRect(x: clockView.frame.maxX + 50,
//                                 y: clockView.frame.origin.y + clockView.frame.size.height / 2 -  25,
//                                 width: 180,
//                                 height: 50)
//    }
//
//
//    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int){
//        return ((seconds/3600),((seconds % 3600) / 60 ),((seconds % 3600) % 60 ))
//    }
//    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
//        var timeString = ""
//        timeString += String(format: "%02d", hours)
//        timeString += " : "
//        timeString += String(format: "%02d", minutes)
//        timeString += " : "
//        timeString += String(format: "%02d", seconds)
//        return timeString
//    }
}
