//
//  ProfileViewController.swift
//  FoodDelivery
//
//  Created by PT Phincon on 26/05/23.
//

import UIKit
import FDUI

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var nameTextField: FDCustomTextField!
    @IBOutlet weak var emailTextField: FDCustomTextField!
    @IBOutlet weak var phoneTextField: FDCustomTextField!
    @IBOutlet weak var addressTextField: FDCustomTextField!
    @IBOutlet weak var passwordTextField: FDCustomTextField!
    @IBOutlet weak var saveButton: FDPrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        passwordTextField.textField.isUserInteractionEnabled = false
        phoneTextField.text = "0812112149141"
        
        let socialTextField = FDCustomTextField(frame: .zero)
        socialTextField.title = "Social Media"
        socialTextField.text = "@aliefazies"
        socialTextField.contentType = .default
        stackView.insertArrangedSubview(socialTextField, at: 4)
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
