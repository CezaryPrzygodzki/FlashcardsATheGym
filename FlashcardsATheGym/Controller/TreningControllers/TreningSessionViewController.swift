//
//  TreningSessionViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 20/04/2021.
//

import UIKit

class TreningSessionViewController: UIViewController {

    var flashcardQuestion: FlascardQuestion!
    let flashcards: [Flashcard] = {
        return DataHelper.shareInstance.loadData()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.FATGpurple
        configureTopBar()
        
        flashcardQuestion = configureFlashcardQuestion()
        view.addSubview(flashcardQuestion)
    }
    

    func configureTopBar(){
        let topBar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300))
        topBar.backgroundColor = Colors.FATGbackground
        
        let mask = CAShapeLayer()
        mask.frame = topBar.bounds
        
        let path = UIBezierPath(rect: topBar.bounds)
        
        let amplitude: CGFloat = 0.1
        let width = topBar.frame.width
        let height = topBar.frame.height
        let origin = CGPoint(x: 0, y: height * 3 / 4)
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

    func configureFlashcardQuestion() -> FlascardQuestion {
        let width = self.view.frame.size.width - 100
        let fr = CGRect(x: self.view.frame.size.width / 2 - width / 2,
                        y: 125,
                        width: width,
                        height: 200)
        

        let fq = FlascardQuestion(flashcard: flashcards[1], frame: fr)
        

        
        return fq
    }

}
