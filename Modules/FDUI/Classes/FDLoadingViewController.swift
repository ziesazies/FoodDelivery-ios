//
//  FDLoadingViewController.swift
//  FDUI
//
//  Created by Alief Ahmad Azies on 05/04/23.
//

import UIKit

class FDLoadingViewController: UIViewController {

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var message: String? {
        didSet {
            update()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        update()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingView.startAnimating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loadingView.stopAnimating()
    }
    
    func update() {
        if isViewLoaded {
            messageLabel.text = message
            view.setNeedsLayout()
        }
    }
}

extension UIViewController {
    public func presentLoadingView(message: String? = nil) {
        if let viewController = presentedViewController as? FDLoadingViewController {
            viewController.message = message
        }
        else {
            let bundle = Bundle(for: FDLoadingViewController.self)
            let viewController = FDLoadingViewController(nibName: "FDLoadingViewController", bundle: bundle)
            viewController.message = message
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.modalTransitionStyle = .crossDissolve
            present(viewController, animated: true, completion: nil)
        }
    }
    
    public func dismissLoadingView() {
        if let _ = presentedViewController as? FDLoadingViewController {
            dismiss(animated: true, completion: nil)
        }
    }
}
