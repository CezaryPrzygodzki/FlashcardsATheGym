//
//  LoginViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 19/01/2021.
//

import UIKit
import FirebaseAuth
import Firebase
import FRHyperLabel
import KeychainSwift
import JGProgressHUD

class LoginViewController: UIViewController {

    private let keychain = KeychainSwift()
    private let welcomeImage = UIImageView()
    private let loginToSignUpQuestion = FRHyperLabel()
    
    private let textFieldMail = UITextField()
    private let textFieldPassword = UITextField()
    private let eyeButton = UIButton(type: .custom)
    private let loginButton = UIButton()
    private let labelError = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //left swipe to back gesture
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        configureWelcomeImage()
        view.addSubview(welcomeImage)
        view.backgroundColor = Colors.FATGbackground
        
        createLoginToSignUpQuestion()
        view.addSubview(loginToSignUpQuestion)

        configuretextFieldMail()
        view.addSubview(textFieldMail)
        configuretextFieldPassword()
        view.addSubview(textFieldPassword)
        
        configureLoginButton()
        view.addSubview(loginButton)
        
        configureLabelError()
        labelError.alpha = 0
        view.addSubview(labelError)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        tap.delegate = self
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    // MARK: Validation
    @objc private func loginTapped(){
        let progressHUD = JGProgressHUD(style: .dark)
        progressHUD.show(in: view)
        
        let email = textFieldMail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = textFieldPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Validate Text Fields
        let error = validateFields(email: email, password: password)
        
        if error != nil {
            //There's something wrong with fileds, show error message
            showError(error!)
        }else {
            //Singing in the user
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    //Couldn't sign it

                    progressHUD.dismiss()
                    self.showError("Popraw login lub hasło")
                }else{
                    var name = ""
                    let db = Firestore.firestore()
                    db.collection("Users").whereField("UID", isEqualTo:(result?.user.uid)!).getDocuments { (snapshot, err) in
                        if let error = err {
                            print("Error geting nick: \(error)")
                        } else {
                            for document in snapshot!.documents {
                               
                                name = (document.get("Nick")! as! String)
                                print(name)
                                self.keychain.set(name, forKey: Keys.nick, withAccess: KeychainSwiftAccessOptions.accessibleWhenUnlockedThisDeviceOnly)
                            }
                        }
                    }
                    //Setting UserID as UID in Keychain
                    self.keychain.set((result?.user.uid)!, forKey: Keys.uid, withAccess: KeychainSwiftAccessOptions.accessibleWhenUnlockedThisDeviceOnly)
                    print("UID dla tej sesji to: \(self.keychain.get(Keys.uid))")
                    print("Nick dla tej sesji to: \(self.keychain.get(Keys.nick))")

                    progressHUD.dismiss()
                    self.performSegue(withIdentifier: "logged", sender: self)
                }
            }
        }
    }
    
    private func validateFields(email: String, password: String) ->String?{
        
        //Check that all fields are filled in
        if email == "" || password == "" {
            return "Uzupełnij wszystkie pola."
            //return "Please fill in all fields"
        }
        return nil
    }
    
    private func showError(_ message:String){
        
        labelError.text = message
        labelError.alpha = 1
        configureLabelError()
    }
    
    // MARK: Configuring UITextFields
    private func configureWelcomeImage() {
        let image = UIImage(named: "welcome2")
        welcomeImage.image = image
        
        let size :CGFloat = self.view.frame.size.width
        welcomeImage.frame.size.width = size
        welcomeImage.frame.size.height = size / 1.5
        welcomeImage.frame = CGRect(x: size / 2 - welcomeImage.frame.size.width / 2,
                                    y: 100,
                                    width: welcomeImage.frame.size.width,
                                    height: welcomeImage.frame.size.height)
        
        
    }
    
    private func createLoginToSignUpQuestion(){
        loginToSignUpQuestion.frame.size.width = 348
        loginToSignUpQuestion.frame.size.height = 41
        loginToSignUpQuestion.textAlignment = .center
        loginToSignUpQuestion.numberOfLines = 0
        
        loginToSignUpQuestion.frame = CGRect(x: self.view.frame.size.width/2 - loginToSignUpQuestion.frame.size.width/2,
                                             y: welcomeImage.frame.origin.y + welcomeImage.frame.size.height,
                                             width: loginToSignUpQuestion.frame.size.width,
                                             height: loginToSignUpQuestion.frame.size.height)
        
        //Define a normal attributed string for non-link texts
        let text = "Jesteś po raz pierwszy? Zarejestruj się"
        let attributes = [ NSAttributedString.Key.foregroundColor: Colors.FATGtext,
                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)
        ]
        loginToSignUpQuestion.attributedText = NSAttributedString(string: text, attributes: attributes)
        
        //Define a selection handler block
        let handler = {
            (hyperLabel: FRHyperLabel!, substring: String!) -> Void in
            self.performSegue(withIdentifier: "toSignUp", sender: self)
            
        }
        //Add link substrings
        loginToSignUpQuestion.setLinksForSubstrings(["Zarejestruj się"], withLinkHandler: handler)
        
    }

    
    private func configuretextFieldMail() {
        textFieldMail.textField(placeholder: "E-mail")
        
        textFieldMail.frame = CGRect(x: self.view.frame.size.width / 2 - textFieldMail.frame.size.width / 2,
                                     y: loginToSignUpQuestion.frame.origin.y + loginToSignUpQuestion.frame.size.height,
                                     width: textFieldMail.frame.size.width,
                                     height: textFieldMail.frame.size.height)
        
    }

    private func configuretextFieldPassword() {
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
    
    @objc private func showPassword(_ sender: Any){
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected{
            self.textFieldPassword.isSecureTextEntry = false
            self.eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            self.textFieldPassword.isSecureTextEntry = true
            self.eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    private func configureLoginButton(){
        loginButton.setTitle("Zaloguj się", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight:.medium)
        loginButton.backgroundColor = Colors.FATGpurple
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        loginButton.frame.size.width = 250
        loginButton.frame.size.height = 41
        loginButton.frame = CGRect(x: self.view.frame.size.width / 2 - loginButton.frame.size.width / 2,
                                        y: textFieldPassword.frame.origin.y + textFieldPassword.frame.size.height + 25,
                                        width: loginButton.frame.size.width,
                                        height: loginButton.frame.size.height)
        
        
        
    }
    
    
    private func configureLabelError() {
        labelError.error()
        labelError.frame = CGRect(x: self.view.frame.size.width/2 - labelError.frame.size.width/2,
                                  y: loginButton.frame.origin.y + loginButton.frame.size.height + 20,
                                  width: labelError.frame.size.width,
                                  height: labelError.frame.size.height)
        labelError.sizeToFit()
        labelError.frame.size.width = self.view.frame.size.width - 50
        //I set the maximum dimensions first, then call sizeToFit() to reduce my height, and finally I set the width again.
        
    }
    

        
    
}

extension LoginViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {

  // Get the location in CGPoint
      let location = touch.location(in: nil)

  // Check if location is inside the Zarejestruj sie
      if loginToSignUpQuestion.frame.contains(location) {
          return false
      }

      return true
    }
  }
