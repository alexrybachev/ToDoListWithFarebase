//
//  LoginViewController.swift
//  ToDoListWithFarebase
//
//  Created by Aleksandr Rybachev on 03.06.2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let segueID = "tasksSegue"

    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        warningLabel.alpha = 0
        
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueID)!, sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarningLabel(with: "Info is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if error != nil {
                self?.displayWarningLabel(with: "Error occured")
                return
            }
            
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueID)!, sender: nil)
                return
            }
            
            self?.displayWarningLabel(with: "No such user")
        }
        
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarningLabel(with: "Info is incorrect")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in // [weak self]
            if error == nil {
                if user != nil {
//                    self?.performSegue(withIdentifier: (self?.segueID)!, sender: nil)
                } else {
                    print("User is not created")
                }
            } else {
                print(error?.localizedDescription ?? "No error description")
            }
        }
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height + keyboardFrameSize.height)
        
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrameSize.height, right: 0)
    }
    
    @objc func keyboardDidHide() {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    func displayWarningLabel(with text: String) {
        warningLabel.text = text
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: [.curveEaseInOut],
                       animations: { [weak self] in
            self?.warningLabel.alpha = 1
            
        }) { [weak self] complete in
            self?.warningLabel.alpha = 0
        }
    }
    
}

