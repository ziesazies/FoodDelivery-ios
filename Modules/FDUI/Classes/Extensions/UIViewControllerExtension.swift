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
