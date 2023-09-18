//
//  LoginViewController.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 09/01/23.
//

import UIKit
import FDUI
import AuthenticationServices
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: FDTextField!
    @IBOutlet weak var passwordTextField: FDTextField!
    @IBOutlet weak var loginButton: FDPrimaryButton!
    @IBOutlet weak var loginFacebookButton: FDPrimaryButton!
    @IBOutlet weak var loginGoogleButton: FDPrimaryButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginStackView: UIStackView!
    
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
        
        if #available(iOS 13.0, *) {
            let appleButton = ASAuthorizationAppleIDButton(type: .default, style: .black)
            loginStackView.insertArrangedSubview(appleButton, at: 0)
            appleButton.translatesAutoresizingMaskIntoConstraints = false
            appleButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
            appleButton.cornerRadius = 28
            appleButton.addTarget(self, action: #selector(self.appleButtonTapped(_:)), for: .touchUpInside)
        }
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
                self.showMainViewController()
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
    
    func login() {
//        viewModel.login()
        viewModel.loginWithEmail()
    }
    
    func loginWithFb() {
        
    }
    
    func loginWithGoogle() {
        
    }
    
    func loginWithAppleId() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = viewModel.nonce
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
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
    
    @IBAction func appleButtonTapped(_ sender: Any) {
        loginWithAppleId()
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

//MARK: - ASAuthorizationControllerDelegate
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            viewModel.loginWithCredential(appleIDCredential)
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            // Handle error.
            print("Sign in with Apple errored: \(error)")
        }
    }
    
}

//MARK: - ASAuthorizationControllerPresentationContextProviding
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
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

