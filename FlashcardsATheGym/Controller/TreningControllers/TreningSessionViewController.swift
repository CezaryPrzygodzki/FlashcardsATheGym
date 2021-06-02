//
//  TreningSessionViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 20/04/2021.
//

import UIKit

class TreningSessionViewController: UIViewController {

    private var flashcardQuestion: FlashcardQuestion!
    private var flashcardAnswer: FlashcardAnswer!
    
    private let closeButton = UIButton()
    
    private let checkoutButton = UIButton()
    
    private let correctAnswerButton = correctWrongButton(type: .correct, frame: .zero)
    private let wrongAnswerButton = correctWrongButton(type: .wrong, frame: .zero)
    
    var typeOfTrening: SelectTrainigModeViewController.TypeOfTrening!
    var clockView : ClockView!
   
    
    private var currentFlashcard : Flashcard!
    
    var teacher : Teacher!
    
    var timer : Timer?
    var timeDuration: Double = 0
    
    var totalTimeTimer : Timer?
    var totalTime: Int = 0
    
    var breakTimeView : BreakTimeView!
    let blurView = UIView()
    
    private let timeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let currF = teacher.listOfFlashcards.first {
            currentFlashcard = currF
            teacher.listOfFlashcards.removeFirst()
        }
        
        view.backgroundColor = Colors.FATGpurple
        configureTopBar()
        
        flashcardQuestion = configureFlashcardQuestion()
        view.addSubview(flashcardQuestion)
        
        view.addSubview(closeButton)
        configureCloseButton()
        
        view.addSubview(checkoutButton)
        configureCheckoutButton()
        
        flashcardAnswer = configureFlashcardAnswer()
        view.addSubview(flashcardAnswer)
        
        view.addSubview(correctAnswerButton)
        view.addSubview(wrongAnswerButton)
        configureCorrectWrongAnswerButtons()
        
        configureClockView(typeOfTrening: .cardio)
        view.addSubview(clockView)
        
        view.addSubview(timeLabel)
        configureTimeLabel()
        
        if typeOfTrening == .cardio {
            totalTime = Int(timeDuration)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerDuration), userInfo: nil, repeats: true)
            clockView.anim(duration: timeDuration) {
                self.dismiss(animated: true) {
                    print("koniec cardio")
                }
            }
        }
        
 
        if typeOfTrening == .strength {
            configureBlurView()
            breakTimeView = BreakTimeView(frame: CGRect(x: 0,
                                                        y: view.frame.maxY - view.frame.size.width,
                                                              width: view.frame.size.width,
                                                              height: view.frame.size.width))
            view.addSubview(breakTimeView)
            
            breakTimeView.checkButtonPressed = { (numberOfSeconds) in
                self.hideBlur()
                self.hideBreakTimeView()
                self.timeDuration = Double(numberOfSeconds)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerDuration), userInfo: nil, repeats: true)
                self.clockView.anim(duration: Double(numberOfSeconds)) {
                    self.timer?.invalidate()
                    self.showBlur()
                    self.showBreakTimeView()
                }
                print(numberOfSeconds)
            }
        }
        
        
    }
    

    private func configureTopBar(){
        let topBar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300))
        topBar.backgroundColor = Colors.FATGbackground
        
        let mask = CAShapeLayer()
        mask.frame = topBar.bounds
        
        let path = UIBezierPath(rect: topBar.bounds)
        
        let amplitude: CGFloat = 0.1
        let width = topBar.frame.width
        let height = topBar.frame.height
        let origin = CGPoint(x: 0, y: height / 2)
        path.move(to: origin)
        
        for angle in stride(from: 0, through: 360.0, by: 5.0) {
            let x = origin.x + CGFloat(angle/360.0) * width
            let y = origin.y - CGFloat(sin(angle/360 * Double.pi)) * height * amplitude

            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: topBar.frame.width, y: 0))
        path.addLine(to: CGPoint.zero)
        path.close()
        
        mask.path = path.cgPath
        
        topBar.layer.mask = mask
        view.addSubview(topBar)
        
        let bottomBar = UIView(frame: CGRect(x: 0, y: 300, width: self.view.frame.size.width, height: self.view.frame.size.height - 300))
        bottomBar.backgroundColor = Colors.FATGbackground
        
        view.addSubview(bottomBar)
        
    }

    private func configureFlashcardQuestion() -> FlashcardQuestion {
        let width = self.view.frame.size.width - 70
        let fr = CGRect(x: self.view.frame.size.width / 2 - width / 2,
                        y: 75,
                        width: width,
                        height: 150)
        

        let fq = FlashcardQuestion(flashcard: currentFlashcard, frame: fr)
        
        return fq
    }

    private func configureFlashcardAnswer() -> FlashcardAnswer {
        let width = self.view.frame.size.width - 70
        var height : CGFloat = 136.66 // 4 x padding, translation and meaning have base 19.33 height, and example has 18 height
        height = (currentFlashcard.translation == "") ? (height - 39.33) : ( height + CGFloat(( 19 * ( currentFlashcard.translation!.count / 35 ) )))
        height = (currentFlashcard.meaning == "") ? (height - 39.33) : ( height + CGFloat(( 19 * ( currentFlashcard.meaning!.count / 35 ) )))
        height = (currentFlashcard.example == "") ? (height - 38) : ( height + CGFloat(( 18 * ( currentFlashcard.example!.count / 40 ) )))
        
        let fr = CGRect(x: self.view.frame.size.width / 2 - width / 2,
                        y: checkoutButton.frame.origin.y,
                        width: width,
                        height: height)
        

        print(height)
        let fa = FlashcardAnswer(flashcard: currentFlashcard, frame: fr)
        fa.isHidden = true
        
        return fa
    }
    
    private func configureCloseButton() {
        closeButton.setTitle("Zamknij", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        closeButton.backgroundColor = .clear
        
        closeButton.frame.size.height = 20
        closeButton.frame = CGRect(x: flashcardQuestion.frame.origin.x,
                                   y: flashcardQuestion.frame.origin.y - 15 - closeButton.frame.size.height,
                                   width: 100,
                                   height: closeButton.frame.size.height)
        closeButton.sizeToFit()
        closeButton.addTarget(self, action: #selector(endTreningSession), for: .touchUpInside)
    }
    
    @objc func endTreningSession() {
        dismiss(animated: true) {
            print("total trening time \(self.totalTime)")
            return
        }
    }
    
    private func configureCheckoutButton(){
        checkoutButton.setTitle("ODPOWIEDŹ", for: .normal)
        checkoutButton.setTitleColor(Colors.FATGtext, for: .normal)
        checkoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        checkoutButton.backgroundColor = Colors.FATGWhiteBlack
        checkoutButton.layer.cornerRadius = 10
        
        checkoutButton.frame.size.width = self.view.frame.size.width - 70
        checkoutButton.frame = CGRect(x: self.view.frame.size.width / 2 - checkoutButton.frame.size.width / 2,
                                      y: flashcardQuestion.frame.maxY + 35,
                                   width: checkoutButton.frame.size.width,
                                   height: 70)
        
        checkoutButton.addTarget(self, action: #selector(showAnswer), for: .touchUpInside)
    }
    
    @objc func showAnswer(_ sender: UIButton!) {
        
        UIView.animate(withDuration: 0.2) {
            self.checkoutButton.alpha = 0
        } completion: { [weak self] completed in
           // self?.checkoutButton.isHidden = true
            self?.flashcardAnswer.isHidden = false
            self?.correctAnswerButton.isHidden = false
            self?.wrongAnswerButton.isHidden = false
            UIView.animate(withDuration: 0.2) {
                self!.correctAnswerButton.alpha = 1
                self!.wrongAnswerButton.alpha = 1
            }
        }

    }
    func hideAnswer(complition: ((Bool) -> (Void))? = nil) {
        UIView.animate(withDuration: 0.2) {
            self.flashcardAnswer.alpha = 0
            self.correctAnswerButton.alpha = 0
            self.wrongAnswerButton.alpha = 0
        } completion: { [weak self] completed in
            self?.checkoutButton.isHidden = false
            self?.checkoutButton.alpha = 1
            self?.flashcardAnswer.isHidden = true
            self?.correctAnswerButton.isHidden = true
            self?.wrongAnswerButton.isHidden = true
            complition?(true)
        }
    }
    private func configureCorrectWrongAnswerButtons(){
        correctAnswerButton.addTarget(self, action: #selector(answer), for: .touchUpInside)
        wrongAnswerButton.addTarget(self, action: #selector(answer), for: .touchUpInside)

        setXYpositionsOfCorrectWrongButtons()
        correctAnswerButton.isHidden = true
        wrongAnswerButton.isHidden = true
    }
    
    private func setXYpositionsOfCorrectWrongButtons(){
        let size : CGFloat = 70
        
        correctAnswerButton.frame = CGRect(x: ( self.view.frame.size.width / 2 ) - ( size / 2 ) - 50,
                                           y: flashcardAnswer.frame.maxY + 20,
                                           width: size,
                                           height: size)
        wrongAnswerButton.frame = CGRect(x: ( self.view.frame.size.width / 2 ) - ( size / 2 ) + 50,
                                           y: flashcardAnswer.frame.maxY + 20,
                                           width: size,
                                           height: size)
    }


    @objc func answer(_ sender: correctWrongButton!){
        var currFlash: Flashcard?
        
        switch sender.type {
        case .correct:
            currFlash = teacher.correctAnswer()
        case .wrong:
            currFlash = teacher.wrongAnswer()
        }
        hideAnswer { completed in
            if currFlash != nil {
                self.currentFlashcard = currFlash!
                self.configureNewFlashcard()
            } else {
                self.endTreningSession()
            }
        }
    }
    
    private func configureNewFlashcard(){
        flashcardAnswer.removeFromSuperview()
        flashcardQuestion.removeFromSuperview()
        flashcardAnswer = configureFlashcardAnswer()
        self.view.addSubview(flashcardAnswer)
        flashcardQuestion = configureFlashcardQuestion()
        self.view.addSubview(flashcardQuestion)
        setXYpositionsOfCorrectWrongButtons()
    }
    
    private func configureClockView(typeOfTrening: SelectTrainigModeViewController.TypeOfTrening) {
        let sizeOfCV: CGFloat = 120
        clockView = ClockView(frame: CGRect(x: checkoutButton.frame.origin.x,
                                         y: UIScreen.main.bounds.size.height - sizeOfCV - checkoutButton.frame.origin.x,
                                         width: sizeOfCV,
                                         height: sizeOfCV),
                           type: typeOfTrening)
        
    }
    
    @objc private func timerDuration(){
        totalTime += 1
        timeDuration -= 1
        let time = secondsToHoursMinutesSeconds(seconds: Int(timeDuration))
        timeLabel.text = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
    }

    private func configureTimeLabel(){

        timeLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        timeLabel.textColor = Colors.FATGtext
        
        timeLabel.frame = CGRect(x: clockView.frame.maxX + 50,
                                 y: clockView.frame.origin.y + clockView.frame.size.height / 2 -  25,
                                 width: 180,
                                 height: 50)
    }

    
    private func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int){
        return ((seconds/3600),((seconds % 3600) / 60 ),((seconds % 3600) % 60 ))
    }
    private func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    
    private func configureBlurView() {
        blurView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        blurView.backgroundColor = .gray
        blurView.alpha = 0.4
        view.addSubview(blurView)
    }
    
    
    private func hideBlur(){
        UIView.animate(withDuration: 1) {
            self.blurView.alpha = 0
        }
    }
    private func showBlur(){
        UIView.animate(withDuration: 1) {
            self.blurView.alpha = 0.4
        }
    }
    
    private func hideBreakTimeView(){
        UIView.animate(withDuration: 1) {
            self.breakTimeView.transform = CGAffineTransform(translationX: 0, y: self.breakTimeView.frame.size.height + 50)
        }
    }
    
    private func showBreakTimeView(){
        UIView.animate(withDuration: 1) {
            self.breakTimeView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
}



