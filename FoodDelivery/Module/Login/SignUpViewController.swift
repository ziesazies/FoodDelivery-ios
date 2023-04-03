//
//  SignUpViewController.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 02/04/23.
//

import UIKit
import FDUI

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpButton: FDPrimaryButton!
    @IBOutlet weak var confirmPasswordTextField: FDTextField!
    @IBOutlet weak var passwordTextField: FDTextField!
    @IBOutlet weak var addressTextField: FDTextField!
    @IBOutlet weak var phoneTextField: FDTextField!
    @IBOutlet weak var emailTextField: FDTextField!
    @IBOutlet weak var nameTextField: FDTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        view.endEditing(true)
    }

    deinit {
        print("signUpViewController deinit called")
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
//        view.endEditing(true)
        
        nameTextField.resignFirstResponder()
    }
    

    @IBAction func loginButtonTapped(_ sender: Any) {
        showLoginViewController()
        removeFromParent()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    func showSignUpViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignUp") as! SignUpViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
