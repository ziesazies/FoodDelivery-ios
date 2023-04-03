//
//  LoginViewController.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 09/01/23.
//

import UIKit
import FDUI

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: FDTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
//        loginTextField. 
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
