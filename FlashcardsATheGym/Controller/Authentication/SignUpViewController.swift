//
//  SignUpViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 19/01/2021.
//

import UIKit
import FirebaseAuth
import Firebase
import FRHyperLabel
import KeychainSwift

class SignUpViewController: UIViewController {

    let keychain = KeychainSwift()
    
    let welcomeImage = UIImageView()
    let signUpToLoginQuestion = FRHyperLabel()
    
    let textFieldNick = UITextField()
    let textFieldMail = UITextField()
    let textFieldPassword = UITextField()
    let eyeButton = UIButton(type: .custom)
    let signUpButton = UIButton()
    var labelError = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //left swipe to back gesture
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        configureWelcomeImage()
        view.addSubview(welcomeImage)
        
        view.backgroundColor = Colors.FATGbackground
        createSignUpToLoginQuestion()
        view.addSubview(signUpToLoginQuestion)
        
        configureTextFieldNick()
        view.addSubview(textFieldNick)
        configuretextFieldMail()
        view.addSubview(textFieldMail)
        configuretextFieldPassword()
        view.addSubview(textFieldPassword)
        
        configureSignUpButton()
        view.addSubview(signUpButton)
        
        configureLabelError()
        labelError.alpha = 0
        view.addSubview(labelError)
        
    }
    func configureWelcomeImage() {
        let image = UIImage(named: "welcome")
        welcomeImage.image = image
        
        let size :CGFloat = self.view.frame.size.width
        welcomeImage.frame.size.width = size
        welcomeImage.frame.size.height = size / 1.5
        welcomeImage.frame = CGRect(x: size / 2 - welcomeImage.frame.size.width / 2,
                                    y: 100,
                                    width: welcomeImage.frame.size.width,
                                    height: welcomeImage.frame.size.height)
        
        
    }
    
    func createSignUpToLoginQuestion(){
        signUpToLoginQuestion.frame.size.width = 348
        signUpToLoginQuestion.frame.size.height = 41
        signUpToLoginQuestion.textAlignment = .center
        signUpToLoginQuestion.numberOfLines = 0
        
        signUpToLoginQuestion.frame = CGRect(x: self.view.frame.size.width/2 - signUpToLoginQuestion.frame.size.width/2,
                                             y: welcomeImage.frame.origin.y + welcomeImage.frame.size.height,
                                             width: signUpToLoginQuestion.frame.size.width,
                                             height: signUpToLoginQuestion.frame.size.height)
        
        //Define a normal attributed string for non-link texts
        let text = "Masz już konto? Zaloguj się"
        let attributes = [ NSAttributedString.Key.foregroundColor: Colors.FATGtext,
                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)
        ]
        signUpToLoginQuestion.attributedText = NSAttributedString(string: text, attributes: attributes)
        
        //Define a selection handler block
        let handler = {
            (hyperLabel: FRHyperLabel!, substring: String!) -> Void in
            self.performSegue(withIdentifier: "toLogin", sender: self)
            
        }
        //Add link substrings
        signUpToLoginQuestion.setLinksForSubstrings(["Zaloguj się"], withLinkHandler: handler)
        
    }

    func configureTextFieldNick() {
        textFieldNick.textField(placeholder: "Nazwa użytkownika")
        textFieldNick.frame = CGRect(x: self.view.frame.size.width / 2 - textFieldNick.frame.size.width / 2,
                                     y: signUpToLoginQuestion.frame.origin.y + signUpToLoginQuestion.frame.size.height,
                                     width: textFieldNick.frame.size.width,
                                     height: textFieldNick.frame.size.height)
        
    }

    func configuretextFieldMail() {
        textFieldMail.textField(placeholder: "E-mail")
        textFieldMail.frame = CGRect(x: self.view.frame.size.width / 2 - textFieldMail.frame.size.width / 2,
                                     y: textFieldNick.frame.origin.y + textFieldNick.frame.size.height + 10,
                                     width: textFieldMail.frame.size.width,
                                     height: textFieldMail.frame.size.height)
        
    }

    func configuretextFieldPassword() {
        textFieldPassword.textField(placeholder: "Hasło")
        textFieldPassword.frame = CGRect(x: self.view.frame.size.width / 2 - textFieldPassword.frame.size.width / 2,
                                     y: textFieldMail.frame.origin.y + textFieldMail.frame.size.height + 10,
                                     width: textFieldPassword.frame.size.width,
                                     height: textFieldPassword.frame.size.height)
        //eye icon showing hidden password
        
        eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        eyeButton.tintColor = Colors.FATGtext
        eyeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        textFieldPassword.rightView = eyeButton
        textFieldPassword.rightViewMode = .always
        eyeButton.addTarget(self, action: #selector(self.showPassword), for: .touchUpInside)
        textFieldPassword.isSecureTextEntry.toggle()
    }
    
    @objc func showPassword(_ sender: Any){
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected{
            self.textFieldPassword.isSecureTextEntry = false
            self.eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            self.textFieldPassword.isSecureTextEntry = true
            self.eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    func configureSignUpButton(){
        signUpButton.setTitle("Utwórz konto", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight:.medium)
        signUpButton.backgroundColor = Colors.FATGpurple
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        signUpButton.frame.size.width = 250
        signUpButton.frame.size.height = 41
        signUpButton.frame = CGRect(x: self.view.frame.size.width / 2 - signUpButton.frame.size.width / 2,
                                        y: textFieldPassword.frame.origin.y + textFieldPassword.frame.size.height + 25,
                                        width: signUpButton.frame.size.width,
                                        height: signUpButton.frame.size.height)
        
        
        
    }
    
    @objc func signUpTapped(){
        
        //Validate the fields
        let error = validateFields()
        
        if error != nil {
            //There's something wrong with fileds, show error message
            showError(error!)
        }else{
            let nick = textFieldNick.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = textFieldMail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = textFieldPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // Check for errors
                if err != nil{
                    //There was an error creating the user
                    self.showError(err.debugDescription.description)
                    print("ERROR ERROR ERROR")
                    print(err.debugDescription)
                }else{
                    // User was created successfully, be happy :)
                    let db = Firestore.firestore()
                    let user: [String: Any] = [
                        "UID":result!.user.uid,
                        "Nick":nick
                    ]
                    self.keychain.set((result?.user.uid)!, forKey: Keys.uid, withAccess: KeychainSwiftAccessOptions.accessibleWhenUnlockedThisDeviceOnly)
                    self.keychain.set(nick, forKey: Keys.nick, withAccess: KeychainSwiftAccessOptions.accessibleWhenUnlockedThisDeviceOnly)
                    db.collection("Users").addDocument(data: user) { (error) in
                        if error != nil{
                            //Show error message
                            self.showError(error!.localizedDescription)
                            print(error!.localizedDescription)
                        }
                    }
                    //Go to featuredViewController
                    print("ID użytkownika to:\(self.keychain.get(Keys.uid)!)")
                    self.performSegue(withIdentifier: "signedUp", sender: self)
                    
                }
            }
            
        }
    }

    func showError(_ message:String){
        
        labelError.text = message
        labelError.alpha = 1
        labelError.frame = CGRect(x: self.view.frame.size.width/2 - labelError.frame.size.width/2,
                                  y: signUpButton.frame.origin.y + signUpButton.frame.size.height + 20,
                                  width: labelError.frame.size.width,
                                  height: labelError.frame.size.height)
        labelError.sizeToFit()
        labelError.frame.size.width = self.view.frame.size.width - 50
    }
    
    //Check the fields and validate that the data is correct. If everything is correct, this method return nil. Otherwise, it returns the error message that it's going to be shown in errorLabel
    func validateFields() ->String?{
        
        //Check that all fields are filled in
        if textFieldNick.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            textFieldMail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            textFieldPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        //Check if the password is secured
        if textFieldMail.isEmail() == false {
            return "Incorect email"
        }
        
        if textFieldPassword.isPassword() == false {
            return "Make your passoword stronger. Due to our security policy we require each password to be at least 8 characters long and must contain at least one digit and uppercase."
        }
        
        
        return nil
    }
    
    func configureLabelError() {
        labelError.error()
        labelError.frame = CGRect(x: self.view.frame.size.width/2 - labelError.frame.size.width/2,
                                  y: signUpButton.frame.origin.y + signUpButton.frame.size.height + 20,
                                  width: labelError.frame.size.width,
                                  height: labelError.frame.size.height)
        labelError.sizeToFit()
        labelError.frame.size.width = self.view.frame.size.width - 50
        //I set the maximum dimensions first, then call sizeToFit() to reduce my height, and finally I set the width again.
        
    }
}
