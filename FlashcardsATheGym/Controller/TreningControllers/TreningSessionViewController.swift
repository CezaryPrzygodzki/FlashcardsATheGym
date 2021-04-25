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
    private let flashcards: [Flashcard] = {
        return DataHelper.shareInstance.loadData()
    }()
    
    private let closeButton = UIButton()
    
    private let checkoutButton = UIButton()
    
    private let correctAnswerButton = UIButton()
    private let wrongAnswerButton = UIButton()
    
    private var currentFlashcard : Flashcard!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentFlashcard = flashcards[1]
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
        height = (currentFlashcard.translation == "") ? (height - 19.33) : ( height + CGFloat(( 19 * ( currentFlashcard.translation!.count / 35 ) )))
        height = (currentFlashcard.meaning == "") ? (height - 19.33) : ( height + CGFloat(( 19 * ( currentFlashcard.meaning!.count / 35 ) )))
        height = (currentFlashcard.example == "") ? (height - 18) : ( height + CGFloat(( 18 * ( currentFlashcard.example!.count / 40 ) )))
        
        let fr = CGRect(x: self.view.frame.size.width / 2 - width / 2,
                        y: checkoutButton.frame.origin.y,
                        width: width,
                        height: height)
        

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
        closeButton.addTarget(self, action: #selector(closeTreningViewController), for: .touchUpInside)
    }
    
    @objc private func closeTreningViewController(_ sender: UIButton!) {
        dismiss(animated: true) {
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
    
    @objc private func showAnswer(_ sender: UIButton!) {
        
        UIView.animate(withDuration: 0.2) {
            self.checkoutButton.alpha = 0
        } completion: { [weak self] completed in
           // self?.checkoutButton.isHidden = true
            self?.flashcardAnswer.isHidden = false
            self?.correctAnswerButton.isHidden = false
            self?.wrongAnswerButton.isHidden = false
        }

    }
    
    private func configureCorrectWrongAnswerButtons(){
        let size : CGFloat = 70
        
        correctAnswerButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        correctAnswerButton.tintColor = Colors.FATGpurple
        correctAnswerButton.contentHorizontalAlignment = .fill
        correctAnswerButton.contentVerticalAlignment = .fill
        correctAnswerButton.imageView?.contentMode = .scaleAspectFit
        correctAnswerButton.addTarget(self, action: #selector(correctAnswer), for: .touchUpInside)
        correctAnswerButton.frame = CGRect(x: ( self.view.frame.size.width / 2 ) - ( size / 2 ) - 50,
                                           y: flashcardAnswer.frame.maxY + 20,
                                           width: size,
                                           height: size)
        
        wrongAnswerButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        wrongAnswerButton.tintColor = Colors.FATGpink
        wrongAnswerButton.addTarget(self, action: #selector(wrongAnswer), for: .touchUpInside)
        wrongAnswerButton.frame = CGRect(x: ( self.view.frame.size.width / 2 ) - ( size / 2 ) + 50,
                                           y: flashcardAnswer.frame.maxY + 20,
                                           width: size,
                                           height: size)
        wrongAnswerButton.contentHorizontalAlignment = .fill
        wrongAnswerButton.contentVerticalAlignment = .fill
        wrongAnswerButton.imageView?.contentMode = .scaleAspectFit
        
        correctAnswerButton.isHidden = true
        wrongAnswerButton.isHidden = true
    }
    
    @objc private func correctAnswer(_ sender: UIButton!){
        print("Correct answer")
    }
    
    @objc private func wrongAnswer(_ sender: UIButton!){
        print("Wrong answer")
    }
}
