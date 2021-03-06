//
//  UIKitExtensions.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 17/01/2021.
//

import UIKit

extension UIView {
    
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints                               = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive             = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive     = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive   = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive       = true
        
    }

}

extension UIButton{
    
    func makeRounded(diameter: CGFloat) {

        self.frame.size.width = diameter
        self.frame.size.height = diameter
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
    func breakTimeButton(seconds: Int) {
        self.layer.cornerRadius = 20
        self.backgroundColor = Colors.FATGpurple
        self.setTitle("\(seconds)s", for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    }
}
extension UINavigationController {

    
    
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }

}


extension NSMutableAttributedString {

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)

        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)

    }

}


//validation
let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

let passwordRegx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)

extension String {
    func isEmail() -> Bool {
        return emailPredicate.evaluate(with: self)
    }
    
    func isPassword() -> Bool {
        return passwordCheck.evaluate(with: self)
    }
}


extension UITextField{
    
    func isEmail() -> Bool {
        return self.text!.isEmail()
    }
    func isPassword() ->Bool {
        return self.text!.isPassword()
    }
    
    func textField(placeholder: String){
        self.frame.size.width = UIScreen.main.bounds.size.width - 50
        self.frame.size.height = 50
        self.layer.cornerRadius = 10
        self.backgroundColor = Colors.FATGWhiteBlack
        self.placeholder = placeholder
        self.addPadding(.both(15))
        self.textColor = Colors.FATGtext
    }
    
    
    enum PaddingSide {
           case left(CGFloat)
           case right(CGFloat)
           case both(CGFloat)
       }
    
    func addPadding(_ padding: PaddingSide) {

        self.leftViewMode = .always
        self.layer.masksToBounds = true


        switch padding {

            case .left(let spacing):
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                self.leftView = paddingView
                self.rightViewMode = .always

            case .right(let spacing):
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                self.rightView = paddingView
                self.rightViewMode = .always

            case .both(let spacing):
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                // left
                self.leftView = paddingView
                self.leftViewMode = .always
                // right
                self.rightView = paddingView
                self.rightViewMode = .always
        }
    }
}

extension UILabel {
    func error(){
        self.frame.size.width = UIScreen.main.bounds.size.width - 50
        self.frame.size.height = 150
        self.text = "Error"
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.textColor = Colors.FATGpink
        self.numberOfLines = 0
    }
    
    func newFlashcardLabel(text: String){
        self.text = text
        self.textColor = Colors.FATGtext
        self.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    func trainingSummaryLabel(text: String){
        
        self.textAlignment = .left
        self.textColor = Colors.FATGtext
        self.font = UIFont.systemFont(ofSize: 16)
        self.text = text
    }
}


