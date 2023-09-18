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
    @IBOutlet weak var locationButton: FDSecondaryButton!
    @IBOutlet weak var saveButton: FDPrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        passwordTextField.textField.isUserInteractionEnabled = false
//        phoneTextField.text = "0812112149141"
//
//        let socialTextField = FDCustomTextField(frame: .zero)
//        socialTextField.title = "Social Media"
//        socialTextField.text = "@aliefazies"
//        socialTextField.contentType = .default
//        stackView.insertArrangedSubview(socialTextField, at: 4)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserData()
    }
    
    func loadUserData() {
        presentLoadingView()
        userProvider.loadMe { [weak self] (result) in
            self?.dismissLoadingView()
            self?.setUserData()
        }
    }
    
    func setUserData() {
        let user = userProvider.user.value
        greetingLabel.text = "Hi, \(user?.name ?? "")"
        nameTextField.textField.text = user?.name ?? ""
        emailTextField.textField.text = user?.email ?? ""
        phoneTextField.textField.text = user?.phone ?? ""
        addressTextField.textField.text = user?.address ?? ""
        let lat = String(format: "%.6f", user?.location?.data.latitude ?? 0)
        let lon = String(format: "%.6f", user?.location?.data.longitude ?? 0)
        locationButton.setTitle("\(lat), \(lon)", for: .normal)
        passwordTextField.textField.text = "***********"
    }
    
    @IBAction func locationButtonTapped(_ sender: Any) {
        presentLocationPickerViewController { (location, address) in
            self.addressTextField.textField.text = address ?? ""
            let lat = String(format: "%.6f", location.latitude)
            let lon = String(format: "%.6f", location.longitude)
            self.locationButton.setTitle("\(lat) / \(lon)", for: .normal)
        }
        
    }
}

extension ProfileViewController: UserProviderProtocol { }
