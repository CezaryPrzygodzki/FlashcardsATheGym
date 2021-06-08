//
//  SettingsViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 19/01/2021.
//

import UIKit

class SettingsViewController: UIViewController {

    let logOutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logOutButton)
        createLogOutButton()
        
    }
    
    func createLogOutButton() {

        logOutButton.backgroundColor = Colors.FATGpink
        logOutButton.layer.cornerRadius = 10
        logOutButton.setTitle("Log out", for: UIControl.State.normal)
        logOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        logOutButton.setTitleColor(Colors.FATGtext, for: .normal)
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        logOutButton.widthAnchor.constraint(equalToConstant: 180).isActive = true

        
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    
    @objc func logOut(){
        
        
        AppManager.shared.logout()
    }

}
