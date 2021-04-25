//
//  FlashcardsViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 17/01/2021.
//

import UIKit

class FlashcardsViewController: UIViewController {

    private var lessons: [Lesson] = []//List of loaded flashcards
    
    private var lessonTableView: UITableView!
    private let flashcardsTableViewCellIdentifier = "letflashcardsTableViewCellIdentifier"
    
    private let allFlashcardsButton = UIButton()
    private let imageViewAddbutton = UIImageView()
    
    private let buttonsView = UIView()
    private let addFlashcardButton = UIButton()
    private let addListButton = UIButton()
    
    private let blurView = UIButton()
    private var addListView: AddListView?
    
    private var thereIsCellTapped = false
    private var selectedRowIndex = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        configureNavigationAndTabBarControllers()
        
        createAddButton()
        
        configureAllFlashcardsButton()
        view.addSubview(allFlashcardsButton)
        
        configureLessonTableView()
        view.addSubview(lessonTableView)
        lessonTableView.topAnchor.constraint(equalTo: allFlashcardsButton.bottomAnchor , constant: 25).isActive = true
        lessonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        lessonTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        lessonTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive       = true
        
        configureAddFlashcardsButton()
        view.addSubview(buttonsView)
        
 //       configureBlurView()
        
//        addListView = AddListView()
//        addListView.frame = CGRect(x: self.view.frame.size.width / 2 - addListView.frame.size.width / 2,
//                               y: self.view.frame.size.height / 2 - addListView.frame.size.height / 2,
//                               width: addListView.frame.size.width,
//                               height: addListView.frame.size.height)
//
//
//        UIApplication.shared.keyWindow!.addSubview(addListView)
   //     addListView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideBlur), name: Notification.Name("hideBlur"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cancel), name: Notification.Name("cancel"), object: nil)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        imageViewAddbutton.isHidden = false
    }
    

    @objc private func loadData(){
        
        //lessons = DataHelper.shareInstance.loadData()
        
        lessons = DataHelper.shareInstance.loadData()
        DispatchQueue.main.async {
            self.lessonTableView.reloadData()
        }
        
    }
    @objc private func cancel(){
        
        thereIsCellTapped = false
        selectedRowIndex = -1
        lessonTableView.beginUpdates()
        lessonTableView.reloadData()
        lessonTableView.endUpdates()

        
    }
    
    private func configureNavigationAndTabBarControllers(){

        self.tabBarController?.tabBar.tintColor = Colors.FATGpurple!
        title = "Fiszki"
        self.view.backgroundColor = Colors.FATGbackground
        navigationController?.setStatusBar(backgroundColor: Colors.FATGbackground!)
        navigationController?.navigationBar.backgroundColor = Colors.FATGbackground //large nav bar
        navigationController?.navigationBar.barTintColor = Colors.FATGbackground //small nav bar
        navigationController?.navigationBar.isTranslucent = false
        tabBarController?.tabBar.barTintColor = Colors.FATGBarTint
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.FATGtext!]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: Colors.FATGtext!]
    }

    
    private func createAddButton(){
        imageViewAddbutton.image = UIImage(systemName: "plus.circle.fill")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addButtonAction))
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.addSubview(imageViewAddbutton)
        imageViewAddbutton.clipsToBounds = true
        imageViewAddbutton.translatesAutoresizingMaskIntoConstraints = false
        imageViewAddbutton.isUserInteractionEnabled = true
        imageViewAddbutton.addGestureRecognizer(tapGestureRecognizer)

        imageViewAddbutton.tintColor = Colors.FATGpink
        NSLayoutConstraint.activate([
            imageViewAddbutton.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -16),
            imageViewAddbutton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -12),
            imageViewAddbutton.heightAnchor.constraint(equalToConstant: 45),
            imageViewAddbutton.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        
    }
    @objc private func addButtonAction() {
        if ( self.navigationController!.navigationBar.layer.zPosition == 0 ) {
            self.navigationController!.navigationBar.layer.zPosition = -1
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut,animations: {

                let degrees : Double = 45
                self.imageViewAddbutton.transform = CGAffineTransform(rotationAngle: CGFloat(degrees * .pi/180))
                self.buttonsView.transform = CGAffineTransform(translationX: -300, y: 0)
                
            }) { (finished) in
                //self.buttonLabel.isHidden = finished
            }
        } else if ( self.navigationController!.navigationBar.layer.zPosition == -1 ){
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut,animations: {

                let degrees : Double = 0
                self.imageViewAddbutton.transform = CGAffineTransform(rotationAngle: CGFloat(degrees * .pi/180))
                self.buttonsView.transform = CGAffineTransform(translationX: 300, y: 0)
                
            }) { (finished) in
                self.navigationController!.navigationBar.layer.zPosition = 0
            }
        }
    }
    private func configureLessonTableView(){
        
        lessonTableView = UITableView()
        //register cells
        lessonTableView.register(ListsTableViewCell.self, forCellReuseIdentifier: flashcardsTableViewCellIdentifier)
        //set contraits
        lessonTableView.translatesAutoresizingMaskIntoConstraints = false
        //set delegates
        setFlashcardsTableViewDelegates()
        
        lessonTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        lessonTableView.showsVerticalScrollIndicator = false
        
        lessonTableView.backgroundColor = .clear

    }
    
    private func configureAllFlashcardsButton() {
        allFlashcardsButton.backgroundColor = Colors.FATGpurple
        allFlashcardsButton.setTitle("WSZYSTKIE FISZKI", for: .normal)
        allFlashcardsButton.setTitleColor(.white, for: .normal)
        allFlashcardsButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        allFlashcardsButton.layer.cornerRadius = 10
        
        allFlashcardsButton.addTarget(self, action: #selector(allFlashcards), for: .touchUpInside)
        allFlashcardsButton.frame.size.width = UIScreen.main.bounds.size.width - 50
        allFlashcardsButton.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - allFlashcardsButton.frame.size.width / 2 ,
                                           y: 25,
                                           width: allFlashcardsButton.frame.size.width,
                                           height: 80)
        
    }
    
    @objc private func allFlashcards (){
        print("allFlashcards")
        self.imageViewAddbutton.isHidden = true
        self.performSegue(withIdentifier: "showAllFlashcards", sender: self)
    }
    
    private func configureAddFlashcardsButton() {
        buttonsView.backgroundColor = Colors.FATGWhiteBlack
        buttonsView.layer.cornerRadius = 15
        buttonsView.layer.shadowRadius = 10
        buttonsView.layer.shadowColor = CGColor(red: 0.215, green: 0.247, blue: 0.344, alpha: 1)
        buttonsView.layer.shadowOpacity = 1
        buttonsView.layer.shadowOffset = .zero
        buttonsView.layer.zPosition = 10

        
        buttonsView.frame.size.width = 240
        buttonsView.frame.size.height = 150
        
        buttonsView.frame = CGRect(x: self.view.frame.size.width - buttonsView.frame.size.width - 10 + 300,
                                   y: 15,
                                   width: buttonsView.frame.size.width,
                                   height: buttonsView.frame.size.height)
        
        buttonsView.addSubview(addFlashcardButton)
        addFlashcardButton.frame = CGRect(x: 10,
                                          y: 10,
                                 width: buttonsView.frame.size.width - 20,
                                 height: ( buttonsView.frame.size.height - 10 ) / 2 - 10)
        addFlashcardButton.backgroundColor = Colors.FATGpink
        addFlashcardButton.layer.cornerRadius = 10
        addFlashcardButton.addTarget(self, action: #selector(addFlashcard), for: .touchUpInside)
        addFlashcardButton.setTitle("Nowa fiszka", for: .normal)
        addFlashcardButton.setTitleColor(Colors.FATGtext, for: .normal)
        addFlashcardButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        

        buttonsView.addSubview(addListButton)
        addListButton.frame = CGRect(x: 10,
                                     y: addFlashcardButton.frame.origin.y + addFlashcardButton.frame.size.height + 10,
                                     width: buttonsView.frame.size.width - 20,
                                     height: ( buttonsView.frame.size.height - 10 ) / 2 - 10)
        addListButton.backgroundColor = Colors.FATGpink
        addListButton.layer.cornerRadius = 10
        addListButton.addTarget(self, action: #selector(addList), for: .touchUpInside)
        addListButton.setTitle("Nowa lista", for: .normal)
        addListButton.setTitleColor(Colors.FATGtext, for: .normal)
        addListButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        
    }
    
    @objc private func addFlashcard (){
        print("addFlashcard")
        addButtonAction()
        let addVC = UIStoryboard(name: "Main",
                                 bundle: nil)
            .instantiateViewController(identifier: "addFlashcard") as! AddFlashcardsViewController
        

        addVC.flashcardsViewController = self
        
        navigationController?.showDetailViewController(addVC, sender: true)


        
    }
    
    @objc private func addList (){
        print("addList")
        addButtonAction()
        configureBlurView()
        addListView = AddListView()
        addListView!.frame = CGRect(x: self.view.frame.size.width / 2 - addListView!.frame.size.width / 2,
                                    y: self.view.frame.size.height / 2 - addListView!.frame.size.height / 2,
                                    width: addListView!.frame.size.width,
                                    height: addListView!.frame.size.height)
        

        UIApplication.shared.keyWindow!.addSubview(addListView!)
        
        blurView.isHidden = false
        
    }
    
    private func configureBlurView() {
        blurView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        blurView.addTarget(self, action: #selector(hideBlur), for: .touchUpInside)
        blurView.isHidden = true
        
        //https://stackoverflow.com/questions/21850436/add-a-uiview-above-all-even-the-navigation-bar
        blurView.frame = UIApplication.shared.keyWindow!.frame
        UIApplication.shared.keyWindow!.addSubview(blurView)
    }
    @objc private func hideBlur(){
        blurView.removeFromSuperview()
        addListView?.removeFromSuperview()
    }
}


extension FlashcardsViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: flashcardsTableViewCellIdentifier, for: indexPath) as? ListsTableViewCell else {
            fatalError("Bad Instance")
        }
    
        let lesson = lessons[indexPath.row]
        cell.selectionStyle = .none
        cell.nameOfListOfFlashcardsLabel.text = lesson.name
        cell.lessonToEdit = lesson

        cell.animate()
        
        return cell
    }
    
    private func setFlashcardsTableViewDelegates(){
        lessonTableView.delegate = self
        lessonTableView.dataSource = self
    }
    
    
    // Set the spacing between sections
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 10
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Usuń") { [self] (action, view, completion) in
        

            let lesson = lessons[indexPath.row]
            DataHelper.shareInstance.deleteData(object: lesson)
        
            lessons.remove(at: indexPath.row)
            lessonTableView.deleteRows(at: [indexPath], with: .fade)
        
          completion(true)
      }

        let muteAction = UIContextualAction(style: .normal, title: "Edytuj") { [self] (action, view, completion) in

            self.selectedRowIndex = indexPath.row
            self.thereIsCellTapped = true
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .none)
            tableView.endUpdates()

        completion(true)
      }
        //muteAction.image = UIImage(systemName: "pencil")
        muteAction.backgroundColor = Colors.FATGpurple
        //deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = Colors.FATGpink
      return UISwipeActionsConfiguration(actions: [deleteAction, muteAction])
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == selectedRowIndex && thereIsCellTapped { return 200 }
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let lesson = lessons[indexPath.row]
        let lessonVC = LessonFlashcardsViewController()


        lessonVC.flashcardsViewController = self
        lessonVC.lesson = lesson
        imageViewAddbutton.isHidden = true

        self.navigationController?.pushViewController(lessonVC, animated: true)
        
    }
    
    
}
