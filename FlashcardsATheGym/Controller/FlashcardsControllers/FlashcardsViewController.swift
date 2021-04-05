//
//  FlashcardsViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 17/01/2021.
//

import UIKit

class FlashcardsViewController: UIViewController {

    var flashcardsTableView: UITableView!
    var letflashcardsTableViewCellIdentifier = "letflashcardsTableViewCellIdentifier"
    
    let allFlashcardsButton = UIButton()
    let imageViewAddbutton = UIImageView()
    
    let buttonsView = UIView()
    let addFlashcardButton = UIButton()
    let addListButton = UIButton()
    
    let blurView = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureNavigationAndTabBarControllers()
        
        createAddButton()
        
        configureAllFlashcardsButton()
        view.addSubview(allFlashcardsButton)
        
        configureFlashcardsTableView()
        view.addSubview(flashcardsTableView)
        flashcardsTableView.topAnchor.constraint(equalTo: allFlashcardsButton.bottomAnchor , constant: 25).isActive = true
        flashcardsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        flashcardsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        flashcardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive       = true
        
        configureAddFlashcardsButton()
        view.addSubview(buttonsView)
        
        configureBlurView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        imageViewAddbutton.isHidden = false
    }
    

    func configureNavigationAndTabBarControllers(){

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

    
    func createAddButton(){
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
    @objc
    func addButtonAction() {
        

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
    func configureFlashcardsTableView(){
        
        flashcardsTableView = UITableView()
        //set row height
        flashcardsTableView.rowHeight = 80
        //register cells
        flashcardsTableView.register(ListsTableViewCell.self, forCellReuseIdentifier: letflashcardsTableViewCellIdentifier)
        //set contraits
        flashcardsTableView.translatesAutoresizingMaskIntoConstraints = false
        //set delegates
        setFlashcardsTableViewDelegates()
        
        flashcardsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        flashcardsTableView.showsVerticalScrollIndicator = false
        
    
        flashcardsTableView.backgroundColor = .clear

    }
    
    func configureAllFlashcardsButton() {
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
    
    @objc func allFlashcards (){
        print("allFlashcards")
        self.imageViewAddbutton.isHidden = true
        self.performSegue(withIdentifier: "showAllFlashcards", sender: self)

        
    }
    
    func configureAddFlashcardsButton() {
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
    
    @objc func addFlashcard (){
        print("addFlashcard")
        addButtonAction()
        let addVC = UIStoryboard(name: "Main",
                                 bundle: nil)
            .instantiateViewController(identifier: "addFlashcard") as! AddFlashcardsViewController
        

        addVC.flashcardsViewController = self
        
        navigationController?.showDetailViewController(addVC, sender: true)

        
    }
    
    @objc func addList (){
        print("addList")
        addButtonAction()
        
        let addList = AddListView()
        addList.frame = CGRect(x: self.view.frame.size.width / 2 - addList.frame.size.width / 2,
                               y: self.view.frame.size.height / 2 - addList.frame.size.height / 2,
                               width: addList.frame.size.width,
                               height: addList.frame.size.height)
        self.view.addSubview(addList)
        blurView.isHidden = false
        
    }
    
    
    func backFromAddFlashcardControllerToDetailsController(){
        
    }
    func backFromAddListControllerToDetailsController(){
        
    }
    
    func configureBlurView() {
        blurView.backgroundColor = Colors.FATGbackground!.withAlphaComponent(0.5)
        view.addSubview(blurView)
        blurView.pin(to: view)
        blurView.addTarget(self, action: #selector(hideBlur), for: .touchUpInside)
        blurView.isHidden = true
    }
    @objc func hideBlur(){
        blurView.isHidden = true
        
    }
}


extension FlashcardsViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: letflashcardsTableViewCellIdentifier, for: indexPath) as? ListsTableViewCell else {
            fatalError("Bad Instance")
        }
    
        cell.selectionStyle = .none
        

        
        return cell
    }
    
    func setFlashcardsTableViewDelegates(){
        flashcardsTableView.delegate = self
        flashcardsTableView.dataSource = self
    }
    
    
    // Set the spacing between sections
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 10
    }
    
    
    
}
