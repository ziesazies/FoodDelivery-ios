//
//  MainViewController.swift
//  FoodDelivery
//
//  Created by PT Phincon on 26/05/23.
//

import UIKit
import FDUI

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        _ = appDelegate.viewContext
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(paths[0])
    }
    
    func setup() {
        tabBar.tintColor = UIColor(rgb: 0xFC6011)
        tabBar.unselectedItemTintColor = UIColor(rgb: 0xB6B7B7)
        
        delegate = self
        
        selectedIndex = 2
    }
}

extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }
}

extension UIViewController {
    func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Main")
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as! UIWindowScene
        let window = windowScene.windows.first!
        
        window.rootViewController = viewController
    }
}
