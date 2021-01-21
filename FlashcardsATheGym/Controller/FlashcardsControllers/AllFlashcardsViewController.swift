//
//  AllFlashcardsViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 20/01/2021.
//

import UIKit

class AllFlashcardsViewController: UIViewController {

    var flashcardsTableView: UITableView!
    let flashcardsTableViewCellIdentifier = "flashcardsTableViewCellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Wszystkie fiszki"
        view.backgroundColor = Colors.FATGbackground
        navigationController?.navigationBar.tintColor = Colors.FATGpurple
        
        configureFlashcardsTableView()
        view.addSubview(flashcardsTableView)
        flashcardsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25 ).isActive = true
        flashcardsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        flashcardsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        flashcardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive       = true
    }
    

    func configureFlashcardsTableView(){
        
        flashcardsTableView = UITableView()
        //set row height
        flashcardsTableView.rowHeight = 100
        //register cells
        flashcardsTableView.register(FlashcardsTableViewCell.self, forCellReuseIdentifier: flashcardsTableViewCellIdentifier)
        //set contraits
        flashcardsTableView.translatesAutoresizingMaskIntoConstraints = false
        //set delegates
        setFlashcardsTableViewDelegates()
        
        flashcardsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        flashcardsTableView.showsVerticalScrollIndicator = false
        
    
        flashcardsTableView.backgroundColor = .clear

    }

}


extension AllFlashcardsViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: flashcardsTableViewCellIdentifier, for: indexPath) as? FlashcardsTableViewCell else {
            fatalError("Bad Instance")
        }
        
        return cell
    }
    
    func setFlashcardsTableViewDelegates(){
        flashcardsTableView.delegate = self
        flashcardsTableView.dataSource = self
    }
}
