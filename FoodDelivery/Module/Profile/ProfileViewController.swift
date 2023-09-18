//
//  ProfileViewController.swift
//  FoodDelivery
//
//  Created by PT Phincon on 26/05/23.
//

import UIKit
import FDUI
import Kingfisher

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
    
    var user: User?
    
    var newProfileImage: UIImage? = nil {
        didSet {
            self.profileImageView.image = newProfileImage
        }
    }
    
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
        observeUser()
        if user == nil {
            loadUserData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadUserData() {
        presentLoadingView()
        userProvider.loadMe { [weak self] (result) in
            self?.dismissLoadingView()
            self?.setUserData()
        }
    }
    
    func observeUser() {
        userProvider.user.bind { user in
            self.user = user
            self.setUserData()
        }
    }
    
    func setUserData() {
        greetingLabel.text = "Hi, \(user?.name ?? "")"
        nameTextField.textField.text = user?.name ?? ""
        emailTextField.textField.text = user?.email ?? ""
        phoneTextField.textField.text = user?.phone ?? ""
        addressTextField.textField.text = user?.address ?? ""
        let lat = String(format: "%.6f", user?.location?.data.latitude ?? 0)
        let lon = String(format: "%.6f", user?.location?.data.longitude ?? 0)
        locationButton.setTitle("\(lat), \(lon)", for: .normal)
        passwordTextField.textField.text = "***********"
        
        profileImageView.kf.setImage(with: URL(string: user?.profileImage?.url ?? ""))
    }
    
    func takePicture() {
        let alert = UIAlertController(title: "Profile Picture", message: "Select picture source", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Library", style: .default, handler: { _ in
            self.takePictureFromLibrary()
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.takePictureFromCamera()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func takePictureFromCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) else { return }
        
        let viewController = UIImagePickerController()
        viewController.delegate = self
        viewController.sourceType = .camera
        viewController.allowsEditing = true
        
        present(viewController, animated: true)
    }
    
    func takePictureFromLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        
        let viewController = UIImagePickerController()
        viewController.delegate = self
        viewController.sourceType = .photoLibrary
        viewController.allowsEditing = true
        
        present(viewController, animated: true)
    }
    
    func uploadProfileImage() {
        if let image = newProfileImage {
            presentLoadingView()
            userProvider.uploadProfileImage(image) { [weak self] (result) in
                self?.dismissLoadingView()
            }
        }
    }
    
    @IBAction func locationButtonTapped(_ sender: Any) {
        presentLocationPickerViewController { (location, address) in
            self.addressTextField.textField.text = address ?? ""
            let lat = String(format: "%.6f", location.latitude)
            let lon = String(format: "%.6f", location.longitude)
            self.locationButton.setTitle("\(lat) / \(lon)", for: .normal)
        }
        
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        takePicture()
    }
    
    
}

//MARK: UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            newProfileImage = image
        }
        
        dismiss(animated: true) {
            self.uploadProfileImage()
        }
    }
}

extension ProfileViewController: UserProviderProtocol { }
