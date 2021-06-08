//
//  ViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 18/01/2021.
//

import UIKit
import FRHyperLabel


class SignUpLoginSkipController: UIViewController {

    let screenWidth = UIScreen.main.bounds.size.width
    
    let welcomeLabel = UILabel()
    let descriptionLabel = UILabel()
    let welcomeImage = UIImageView()
    
    let getStartedButton = UIButton()
    let alreadyHaveAccountLabel = FRHyperLabel()

    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWelcomeLabel()
        view.addSubview(welcomeLabel)
        configureDescriptionLabel()
        view.addSubview(descriptionLabel)
        
        configureWelcomeImage()
        view.addSubview(welcomeImage)

        configureGetStartedButton()
        view.addSubview(getStartedButton)

        configureAlreadyHaveAccountLabel()
        view.addSubview(alreadyHaveAccountLabel)
        
    }
    
    
    func configureWelcomeLabel() {
        welcomeLabel.text = "Witaj w FATG!"
        welcomeLabel.textColor = Colors.FATGtext
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        
        welcomeLabel.frame.size.width = screenWidth - 50
        welcomeLabel.frame.size.height = 50
        
        welcomeLabel.frame = CGRect(x: screenWidth / 2 - welcomeLabel.frame.size.width / 2,
                                    y: 150,
                                    width: welcomeLabel.frame.size.width,
                                    height: welcomeLabel.frame.size.height)
        
    }
    
    func configureDescriptionLabel(){
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        descriptionLabel.numberOfLines = 0

        
        descriptionLabel.frame.size.width = screenWidth - 50
        descriptionLabel.frame.size.height = 100
        
        descriptionLabel.frame = CGRect(x: screenWidth / 2 - descriptionLabel.frame.size.width / 2,
                                        y: welcomeLabel.frame.origin.y + welcomeLabel.frame.size.height ,
                                        width: descriptionLabel.frame.size.width,
                                        height:  descriptionLabel.frame.size.height)
    

        let text = "FlashcardsATheGym to aplikacja, która skutecznie pomoże Ci połączyć trening z nauką języków obcych."
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text )
        attributedText.setColorForText(textForAttribute: "FlashcardsATheGym", withColor: Colors.FATGpurple!)
        attributedText.setColorForText(textForAttribute: "to aplikacja, która skutecznie pomoże Ci połączyć trening z nauką języków obcych.", withColor: Colors.FATGtext!)
        descriptionLabel.attributedText = attributedText
    }
    
    func configureWelcomeImage() {
        let image = UIImage(named: "welcome2")
        welcomeImage.image = image
        
        let size :CGFloat = screenWidth
        welcomeImage.frame.size.width = size
        welcomeImage.frame.size.height = size / 1.5
        welcomeImage.frame = CGRect(x: screenWidth / 2 - welcomeImage.frame.size.width / 2,
                                    y: descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height,
                                    width: welcomeImage.frame.size.width,
                                    height: welcomeImage.frame.size.height)
        
        
    }

    func configureGetStartedButton(){
        getStartedButton.setTitle("Rozpocznij", for: .normal)
        getStartedButton.setTitleColor(.white, for: .normal)
        getStartedButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight:.medium)
        getStartedButton.backgroundColor = Colors.FATGpurple
        getStartedButton.layer.cornerRadius = 10
        getStartedButton.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
        
        getStartedButton.frame.size.width = 250
        getStartedButton.frame.size.height = 65
        getStartedButton.frame = CGRect(x: screenWidth / 2 - getStartedButton.frame.size.width / 2,
                                        y: welcomeImage.frame.origin.y + welcomeImage.frame.size.height,
                                        width: getStartedButton.frame.size.width,
                                        height: getStartedButton.frame.size.height)
        
        
    }
    
    @objc func getStarted(){
        self.performSegue(withIdentifier: "SignUp", sender: self)
    }
    
    func configureAlreadyHaveAccountLabel() {
        alreadyHaveAccountLabel.textAlignment = .center
        alreadyHaveAccountLabel.isUserInteractionEnabled = true
        
        alreadyHaveAccountLabel.frame.size.width = screenWidth - 50
        alreadyHaveAccountLabel.frame.size.height = 50
        
        alreadyHaveAccountLabel.frame = CGRect(x: screenWidth / 2 - alreadyHaveAccountLabel.frame.size.width / 2,
                                               y: getStartedButton.frame.origin.y + getStartedButton.frame.size.height,
                                               width: alreadyHaveAccountLabel.frame.size.width,
                                               height: alreadyHaveAccountLabel.frame.size.height)
        
        //Define a normal attributed string for non-link texts
        let text = "Masz już konto? Zaloguj się"
        let attributes = [ NSAttributedString.Key.foregroundColor: Colors.FATGtext,
                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)
        ]
        alreadyHaveAccountLabel.attributedText = NSAttributedString(string: text, attributes: attributes as [NSAttributedString.Key : Any])
        
        //Define a selection handler block
        let handler = {
            (hyperLabel: FRHyperLabel!, substring: String!) -> Void in
            print("self.performSegue(withIdentifier: Login, sender: self)")
            self.performSegue(withIdentifier: "Login", sender: self)
            
        }
        //Add link substrings
        alreadyHaveAccountLabel.setLinksForSubstrings(["Zaloguj się"], withLinkHandler: handler)
    }
}
