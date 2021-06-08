//
//  AppManager.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 19/01/2021.
//

import UIKit
import Firebase
import KeychainSwift

class AppManager {
    
    private let keychain = KeychainSwift()
    //making singleton
    static let shared = AppManager()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var appContainer: AppContainerViewController!
    private init(){}
    
    func showApp(){
        
        var viewController: UIViewController
        
        if Auth.auth().currentUser == nil{
            
            viewController = storyboard.instantiateViewController(withIdentifier: "SignUpLoginSkipController")
        } else {
          
            viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        }
        
        appContainer.present(viewController, animated: true, completion: nil)
        
    }

    func logout() {
        keychain.delete(Keys.uid)
      try! Auth.auth().signOut()
      appContainer.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}

