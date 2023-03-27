//
//  LoginLandingViewController.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 02/01/23.
//

import UIKit

class LoginLandingViewController: UIViewController {
    @IBOutlet weak var loginButton: FDPrimaryButton!
    @IBOutlet weak var registerButton: FDSecondaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.primary.cgColor
        registerButton.layer.cornerRadius = 28
        
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        showLoginViewController()
    }
}

// MARK: - UIViewController
extension UIViewController {
    func showLoginLandingViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginLanding")
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as! UIWindowScene
        let window = windowScene.windows.first!
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        
        window.rootViewController = navigationController}
}
