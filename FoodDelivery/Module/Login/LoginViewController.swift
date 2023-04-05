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
    @IBOutlet weak var loginFacebookButton: FDPrimaryButton!
    @IBOutlet weak var loginGoogleButton: FDPrimaryButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        bindIsLoading()
        bindIsLoginSuccess()
        bindError()
    }
    
    deinit {
        
    }
    
    //MARK: - Helpers
    
    func setup() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func bindIsLoading() {
        viewModel.isLoading.bind { [weak self] (value) in
            guard let `self` = self else { return }
            if value {
                self.presentLoadingView(message: self.viewModel.loadingMessage)
            }
            else {
                self.dismissLoadingView()
            }
        }
    }
    
    func bindIsLoginSuccess() {
        viewModel.isLoginSuccess.bind { [weak self] (value) in
            guard let `self` = self else { return }
            if value {
                //FIXME: - Go To Home Page
            }
        }
    }
    
    func bindError() {
        viewModel.error.bind { [weak self] (value) in
            guard let `self` = self else { return }
            if let error = value {
                self.presentAlert(title: "Oops!", message: error.localizedDescription)
            }
        }
    }
    
    func login() {
        viewModel.login()
    }
    
    func loginWithFb() {
        
    }
    
    func loginWithGoogle() {
        
    }
    
    //MARK: - Actions
    @IBAction func loginButtonTapped(_ sender: Any) {
        view.endEditing(true)
        login()
    }
    
    @IBAction func loginFacebookButtonTapped(_ sender: Any) {
        loginWithFb()
    }
    
    @IBAction func loginGoogleButtonTapped(_ sender: Any) {
        loginWithGoogle()
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        showSignUpViewController()
        removeFromParent()
    }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        
        switch textField {
        case emailTextField:
            viewModel.email.value = text
        case passwordTextField:
            viewModel.password.value = text
        default:
            break
        }
        
        return true
    }
}

// MARK: - UIViewController
extension UIViewController {
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        viewController.viewModel = LoginViewModel()
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
