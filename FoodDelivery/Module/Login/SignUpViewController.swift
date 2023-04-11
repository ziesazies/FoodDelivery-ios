//
//  SignUpViewController.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 02/04/23.
//

import UIKit
import FDUI

class SignUpViewController: UIViewController {
    @IBOutlet weak var nameTextField: FDTextField!
    @IBOutlet weak var emailTextField: FDTextField!
    @IBOutlet weak var phoneTextField: FDTextField!
    @IBOutlet weak var addressTextField: FDTextField!
    @IBOutlet weak var passwordTextField: FDTextField!
    @IBOutlet weak var confirmPasswordTextField: FDTextField!
    @IBOutlet weak var signUpButton: FDPrimaryButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        bindIsLoading()
        bindIsSignUpSuccess()
        bindError()
    }
    
    deinit {
        
    }
    
    //MARK: - Helpers
    func setup() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        phoneTextField.delegate = self
        addressTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
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
    
    func bindIsSignUpSuccess() {
        viewModel.isSignUpSuccess.bind { [weak self] (value) in
            guard let `self` = self else { return }
            if value {
                self.presentAlert(title: "Yay!", message: "Sign up success! Please login now") {
                    self.loginButtonTapped(self)
                }
            }
        }
    }
    
    func bindError() {
        viewModel.error.bind { [weak self] (value) in
            guard let `self` = self else { return }
            if let error = value {
                let handler: () -> Void = {
                        self.presentAlert(title: "Oops!", message: error.localizedDescription)
                }
                
                if self.presentedViewController != nil {
                    self.dismiss(animated: true) {
                        handler()
                    }
                }
                else {
                    handler()
                }
            }
        }
    }
    
    func signUp() {
        viewModel.signUp()
    }
    
    //MARK: - Actions
    
    @IBAction func viewTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        view.endEditing(true)
        signUp()
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        showLoginViewController()
        removeFromParent()
    }
}

//MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        
        switch textField {
        case nameTextField:
            viewModel.name.value = text
        case emailTextField:
            viewModel.email.value = text
        case phoneTextField:
            viewModel.phone.value = text
        case addressTextField:
            viewModel.address.value = text
        case passwordTextField:
            viewModel.password.value = text
        case confirmPasswordTextField:
            viewModel.confirmPassword.value = text
        default:
            break
        }
        
        return true
    }
}

//MARK: - UIViewController
extension UIViewController {
    func showSignUpViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignUp") as! SignUpViewController
        viewController.viewModel = SignUpViewModel()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
