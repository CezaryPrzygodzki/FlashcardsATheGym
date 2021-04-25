//
//  TreningViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 17/01/2021.
//

import UIKit

class TreningViewController: UIViewController{

    private var topLabelStartTrening : UIView!
    private var previousTreningsLabel: UILabel!
    private var previousTreningsTableView: UITableView!
    let previousTreningsTableViewCellIdentifier = "previousTreningsTableViewCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationAndTabBarControllers()
        
        topLabelStartTrening = configureTopLabelStartTrening()
        view.addSubview(topLabelStartTrening)
        
        previousTreningsLabel = configurePreviousTreningsLabel()
        view.addSubview(previousTreningsLabel)
        
        configurePreviousTreningsTableView()
        view.addSubview(previousTreningsTableView)
        previousTreningsTableView.topAnchor.constraint(equalTo: previousTreningsLabel.bottomAnchor , constant: 25).isActive = true
        previousTreningsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        previousTreningsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        previousTreningsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        previousTreningsTableView.frame = CGRect(x: 25,
//                                                 y: previousTreningsLabel.bounds.maxY ,
//                                                 width: UIScreen.main.bounds.size.width - 50 ,
//                                                 height: 400)
//
    }
    

    private func configureNavigationAndTabBarControllers(){

        self.tabBarController?.tabBar.tintColor = Colors.FATGpurple!
        title = "Trening"
        self.view.backgroundColor = Colors.FATGbackground
        navigationController?.setStatusBar(backgroundColor: Colors.FATGbackground!)
        navigationController?.navigationBar.backgroundColor = Colors.FATGbackground //large nav bar
        navigationController?.navigationBar.barTintColor = Colors.FATGbackground //small nav bar
        navigationController?.navigationBar.isTranslucent = false
        tabBarController?.tabBar.barTintColor = Colors.FATGBarTint
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.FATGtext!]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: Colors.FATGtext!]
    }

    private func configureTopLabelStartTrening() -> UIView{
        
        let topView = UIView()
        
        topView.backgroundColor = Colors.FATGpurple
        topView.frame.size.width = UIScreen.main.bounds.size.width - 50
        topView.frame.size.height = 250
        topView.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - topView.frame.size.width / 2,
                               y: UIScreen.main.bounds.size.width / 2 - topView.frame.size.width / 2,
                               width: topView.frame.size.width,
                               height: topView.frame.size.height)
        
        topView.layer.cornerRadius = 15
        
        let text = UILabel()
        text.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eu quam quis eros ornare ornare. Pellentesque ut velit a neque ultricies egestas. "
        text.textColor = .white
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 13, weight: .light)
        text.numberOfLines = 3
        
        text.frame.size.width = topView.frame.size.width - 30
        text.frame.size.height = 70
        text.frame = CGRect(x: topView.frame.size.width / 2 - text.frame.size.width / 2,
                            y: topView.frame.size.width / 2 - text.frame.size.width / 2,
                            width: text.frame.size.width,
                            height: text.frame.size.height)
        topView.addSubview(text)
        
        let image = UIImage(named: "trening")
        let imageView = UIImageView(image: image)
        let size :CGFloat = 260
        imageView.frame.size.width = size
        imageView.frame.size.height = size
        imageView.frame = CGRect(x: -45,
                                 y: text.bounds.maxY - 10 ,
                                 width: imageView.frame.size.width,
                                 height: imageView.frame.size.height)

        topView.addSubview(imageView)
        
        let button = UIButton()
        button.setTitle("Rozpocznij", for: .normal)
        button.setTitleColor(Colors.FATGpurple, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(start), for: .touchUpInside)
        
        button.frame.size.width = 100
        button.frame.size.height = 40
        button.frame = CGRect(x: topView.bounds.maxX - button.frame.size.width - 10,
                              y: topView.bounds.maxY - button.frame.size.height - 10,
                              width: button.frame.size.width,
                              height: button.frame.size.height)
        topView.addSubview(button)
        
        return topView
    }
    
    @objc private func start(){
        let sessionVC = TreningSessionViewController()
        sessionVC.modalPresentationStyle = .fullScreen
        navigationController?.showDetailViewController(sessionVC, sender: true)
    }
    
    private func configurePreviousTreningsLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "Poprzednie treningi"
        label.textColor = Colors.FATGtext
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        
        label.frame = CGRect(x: 25, y: topLabelStartTrening.bounds.maxY + 70, width: UIScreen.main.bounds.size.width - 50, height: 50)
        return label
    }
    
    private func configurePreviousTreningsTableView() {
        previousTreningsTableView = UITableView()
        //set row height
        previousTreningsTableView.rowHeight = 130
        //register cells
        previousTreningsTableView.register(PreviousTreningsTableViewCell.self, forCellReuseIdentifier: previousTreningsTableViewCellIdentifier)
        //set contraits
        previousTreningsTableView.translatesAutoresizingMaskIntoConstraints = false
        //set delegates
        setPreviousTreningsTableView()
        
        previousTreningsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        previousTreningsTableView.showsVerticalScrollIndicator = false
                
        previousTreningsTableView.backgroundColor = .clear
        
    }
}



extension TreningViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: previousTreningsTableViewCellIdentifier, for: indexPath) as? PreviousTreningsTableViewCell else {
            fatalError("Bad Instance")
        }
    
        return cell
    }
    
    
    private func  setPreviousTreningsTableView() {
        previousTreningsTableView.delegate = self
        previousTreningsTableView.dataSource = self
        
    }
    
}

