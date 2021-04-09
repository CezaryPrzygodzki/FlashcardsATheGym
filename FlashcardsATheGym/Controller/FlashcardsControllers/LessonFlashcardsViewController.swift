//
//  LessonFlashcardsViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 09/04/2021.
//

import UIKit

class LessonFlashcardsViewController: AllFlashcardsViewController {

    var flashcardsViewController: FlashcardsViewController?
    var lesson: Lesson?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = lesson?.name
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
}
