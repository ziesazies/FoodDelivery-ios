//
//  MainViewController.swift
//  FoodDelivery
//
//  Created by PT Phincon on 26/05/23.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
