//
//  Alert.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 20/01/2021.
//

import UIKit


struct Alert {
    
    static func wrongData(on vc: UIViewController, message: String){
        
        let alert = UIAlertController(title: "Fiszkomaniaku!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        vc.present(alert, animated: true)
    }
}
