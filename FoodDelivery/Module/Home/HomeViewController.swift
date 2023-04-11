//
//  HomeViewController.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 09/04/23.
//

import UIKit
import FirebaseAuth
import FDUI

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        try! Auth.auth().signOut()
        self.showLoginLandingViewController()
    }
}

extension UIViewController {
    func showHomeViewController() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Home")
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as! UIWindowScene
        let window = windowScene.windows.first!
        
        let navigationController = FDNavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        
        window.rootViewController = navigationController
    }
}
