//
//  LoginViewController.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 09/01/23.
//

import UIKit
import FDUI

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: FDTextField!
    @IBOutlet weak var passwordTextField: FDTextField!
    @IBOutlet weak var loginButton: FDPrimaryButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginFacebookButton: FDPrimaryButton!
    @IBOutlet weak var loginGoogleButton: FDPrimaryButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
    }
    
    deinit {
        print("loginViewController deinit called")
    }
    
    func setup() {
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
    }
    
    @IBAction func loginFacebookButtonTapped(_ sender: Any) {
    }
    
    @IBAction func loginGoogleButtonTapped(_ sender: Any) {
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        showSignUpViewController()
        removeFromParent()
    }
}

// MARK: - UIViewController
extension UIViewController {
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
