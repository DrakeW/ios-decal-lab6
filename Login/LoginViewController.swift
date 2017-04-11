//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    let label = UILabel()
    let loginFieldVeiw = UIView()
    let accountTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        
        label.text = "Login View Controller"
        label.font = UIFont(name: "Avenir", size: 40)
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        
        
        loginFieldVeiw.backgroundColor = UIColor.white
        loginFieldVeiw.layer.cornerRadius = 10
        self.view.addSubview(loginFieldVeiw)
        
        
        accountTextField.placeholder = "berkeley.edu account"
        loginFieldVeiw.addSubview(accountTextField)
        passwordTextField.placeholder = "Password"
        loginFieldVeiw.addSubview(passwordTextField)
        
        loginButton.backgroundColor = Constants.backgroundColor
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.textColor = UIColor.white
        loginButton.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        loginButton.layer.cornerRadius = 10
        loginFieldVeiw.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(login(sender:)), for: .touchDown)
        
        // TODO: layout your views using frames or AutoLayout
        label.frame = CGRect(x: 0.1 * self.view.frame.width,
                             y: 0.1 * self.view.frame.width,
                             width: 0.8 * self.view.frame.width,
                             height: 300)
        
        loginFieldVeiw.frame = CGRect(x: 0, y: 0, width: 0.9 * self.view.frame.width, height: 200)
        loginFieldVeiw.center = self.view.center
        
        let textFieldLeftRightPadding = CGFloat(10)
        accountTextField.frame = CGRect(x: textFieldLeftRightPadding, y: 0,
                                        width: loginFieldVeiw.frame.width - textFieldLeftRightPadding,
                                        height: loginFieldVeiw.frame.height / 3)
        passwordTextField.frame = CGRect(x: textFieldLeftRightPadding, y: accountTextField.frame.height,
                                         width: loginFieldVeiw.frame.width - textFieldLeftRightPadding,
                                         height: loginFieldVeiw.frame.height / 3)
        
        let topBottomPadding = CGFloat(10)
        let btnWidth = 0.4 * loginFieldVeiw.frame.width
        let btnHeight = CGFloat(40)
        loginButton.frame = CGRect(x: loginFieldVeiw.frame.width / 2 - btnWidth / 2,
                                   y: accountTextField.frame.height + passwordTextField.frame.height + topBottomPadding,
                                   width: btnWidth,
                                   height: btnHeight)


        
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func login(sender: UIButton) {
        let username = accountTextField.text
        let password = passwordTextField.text
        authenticateUser(username: username, password: password)
    }
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
