//
//  UIViewControllerExtension.swift
//  FDUI
//
//  Created by Alief Ahmad Azies on 29/03/23.
//

import UIKit

extension UIViewController {
    @IBAction public func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction public func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
//MARK: - Alert
extension UIViewController {
    public func presentAlert(title: String?, message: String?, actionTitle: String? = nil, handler: (() -> Void)? = nil ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle ?? "OK", style: .cancel, handler: { _ in
            handler?()
        }))
        present(alert, animated: true, completion: nil)
    }
}
