//
//  LessonFlashcardsViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 09/04/2021.
//

import UIKit

class LessonFlashcardsViewController: AllFlashcardsViewController {

    var flashcardsViewController: FlashcardsViewController?
    var lesson: Lesson!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = lesson?.name
        flashcards = DataHelper.shareInstance.loadFlashcards(lesson: lesson)
        flashcardsTableView.reloadData()

        

        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Anuluj", style: .plain, target: self, action: #selector(anuluj))
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         if #available(iOS 13.0, *) {
              navigationController?.navigationBar.setNeedsLayout()
         }
    }
    
    @objc
    func anuluj() {
        dismiss(animated: true, completion: nil)
    }
    
    override func addButtonAction() {
        
        let addVC = UIStoryboard(name: "Main",
                                 bundle: nil)
            .instantiateViewController(identifier: "addFlashcard") as! AddFlashcardsViewController
    
        addVC.allFlashcardsViewController = self
        addVC.saveThisFlashcardInLessons.append(lesson)
      
        self.navigationController?.showDetailViewController(addVC, sender: true)

    }
}


