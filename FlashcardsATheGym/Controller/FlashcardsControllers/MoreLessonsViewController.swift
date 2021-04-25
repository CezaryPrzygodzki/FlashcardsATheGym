//
//  MoreLessonsViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 11/04/2021.
//

import UIKit

class MoreLessonsViewController: UIViewController {

    let addFlashcardsViewController: AddFlashcardsViewController
    var moreLessons: [Lesson]
    var pickedLessons: [Lesson] = []
    
    var moreLessonTableView: UITableView!
    let lessonTableViewCellIndentifier = "lessonTableViewCellIndentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()


        title = "Więcej lekcji"
        print(moreLessons)

        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = Colors.FATGbackground
        configureLessonTableView()
        view.addSubview(moreLessonTableView)
        moreLessonTableView.topAnchor.constraint(equalTo: view.topAnchor , constant: 0).isActive = true
        moreLessonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        moreLessonTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        moreLessonTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive       = true
        
        
    }
    
    init(addFlashcardsViewController: AddFlashcardsViewController,moreLessons: [Lesson]){
        self.addFlashcardsViewController = addFlashcardsViewController
        self.moreLessons = moreLessons
        
    
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    func configureLessonTableView(){
        
        moreLessonTableView = UITableView()
        //set row height
        //lessonTableView.rowHeight = 80
        //register cells
        moreLessonTableView.register(LessonsTableViewCell.self, forCellReuseIdentifier: lessonTableViewCellIndentifier)
        //set contraits
        moreLessonTableView.translatesAutoresizingMaskIntoConstraints = false
        //set delegates
        setFlashcardsTableViewDelegates()
        
        moreLessonTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        moreLessonTableView.showsVerticalScrollIndicator = false
        
    
        moreLessonTableView.backgroundColor = .clear

    }
    

}

extension MoreLessonsViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: lessonTableViewCellIndentifier, for: indexPath) as? LessonsTableViewCell else {
            fatalError("Bad Instance")
        }
    
//        let lesson = lessons[indexPath.row]
//        cell.selectionStyle = .none
//        cell.nameOfListOfFlashcardsLabel.text = lesson.name
//        cell.lessonToEdit = lesson
//
//        cell.animate()
        
        return cell
    }
    
    
    func setFlashcardsTableViewDelegates(){
        moreLessonTableView.delegate = self
        moreLessonTableView.dataSource = self
    }
    
}
