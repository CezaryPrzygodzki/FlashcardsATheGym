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

        createLogOutButton()
        view.addSubview(logOutButton)
    }
    
    func createLogOutButton() {
    logOutButton.frame.size.width = self.view.frame.width
    logOutButton.frame.size.height = 44
    
    logOutButton.setTitle("Log out", for: UIControl.State.normal)
    logOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    logOutButton.setTitleColor(.black, for: .normal)
    
    logOutButton.frame = CGRect(x: 0,
                                y: 345,
                                width: logOutButton.frame.size.width,
                                height: logOutButton.frame.size.height)
    
    logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    
    @objc func logOut(){
        
        
        AppManager.shared.logout()
    }

}
