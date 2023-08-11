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
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        searchBar.backgroundImage = UIImage()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Actions
    @objc func restaurantsButtonTapped(_ sender: Any) {
        print("View all restaurants")
        
    }
    
    @objc func popularRestaurantsButtonTapped(_ sender: Any) {
        print("View all most popular restaurants")
        
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Categories", for: indexPath) as? CategoriesTableViewCell else {
                return UITableViewCell()
            }
            
            cell.collectionView.tag = indexPath.section
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.reloadData()
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Restaurant", for: indexPath) as? RestaurantViewCell else {
                return UITableViewCell()
            }
            
            cell.restaurantImageView.image = UIImage(named: "img_pizza")
            cell.nameLabel.text = "Minute by tuk tuk"
            
            let ratingsAttText: NSMutableAttributedString = NSMutableAttributedString(
                string: "4.5",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                    .foregroundColor: UIColor.primary
                ]
            )
            ratingsAttText.append(NSAttributedString(
                string: " (124 ratings)",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                    .foregroundColor: UIColor.placeholder
                ]
            ))
            
            cell.ratingsLabel.attributedText = ratingsAttText
           
            let categories: [String] = ["Café", "Western Food"]
            let categoriesAttText: NSMutableAttributedString = NSMutableAttributedString()
            
            for i in 0..<categories.count {
                categoriesAttText.append(NSAttributedString(
                    string: categories[i],
                    attributes: [
                        .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                        .foregroundColor: UIColor.placeholder
                    ]
                ))
                
                /// checking if index is not last item in a list
                if i != categories.count - 1 {
                    categoriesAttText.append(NSAttributedString(
                        string: " • ",
                        attributes: [
                            .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                            .foregroundColor: UIColor.placeholder
                        ]
                    ))
                }
            }
            
            cell.categoriesLabel.attributedText = categoriesAttText
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularRestaurants") as? PopularRestaurantsViewCell else { return UITableViewCell() }
            
            cell.collectionView.tag = indexPath.section
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.reloadData()
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return 10
        case 2:
            return 5
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category", for: indexPath) as? CategoryViewCell else {
                return UICollectionViewCell()
            }
            
            cell.imageView.image = UIImage(named: "img_dummy_category")
            cell.titleLabel.text = "Cat.\(indexPath.item + 1)"
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularRestaurant", for: indexPath) as? PopularRestaurantViewCell else { return UICollectionViewCell() }
            
            cell.imageView.image = UIImage(named: "img_pizza")
            cell.nameLabel.text = "Minute by tuk tuk"
            
            let ratingsAttText: NSMutableAttributedString = NSMutableAttributedString(
                string: "4.5",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                    .foregroundColor: UIColor.primary
                ]
            )
            ratingsAttText.append(NSAttributedString(
                string: " (124 ratings)",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                    .foregroundColor: UIColor.placeholder
                ]
            ))
            
            cell.ratingsLabel.attributedText = ratingsAttText
           
            let categories: [String] = ["Café", "Western Food"]
            let categoriesAttText: NSMutableAttributedString = NSMutableAttributedString()
            
            for i in 0..<categories.count {
                categoriesAttText.append(NSAttributedString(
                    string: categories[i],
                    attributes: [
                        .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                        .foregroundColor: UIColor.placeholder
                    ]
                ))
                
                /// checking if index is not last item in a list
                if i != categories.count - 1 {
                    categoriesAttText.append(NSAttributedString(
                        string: " • ",
                        attributes: [
                            .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                            .foregroundColor: UIColor.placeholder
                        ]
                    ))
                }
            }
            
            cell.categoriesLabel.attributedText = categoriesAttText
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            presentAlert(title: "OK!", message: "Tapped at \(indexPath.item + 1)")
        default:
            break
        }
    }
}

//MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        case 1, 2:
            let view = UIView(frame: .zero)
            view.backgroundColor = .white
            let label = UILabel(frame: .zero)
            view.addSubview(label)
            label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            label.textColor = UIColor.primaryText
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
            ])
            
            let button = UIButton(type: UIButton.ButtonType.system)
            view.addSubview(button)
            button.setTitleColor(UIColor.primary, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            button.setTitle("View All", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                button.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0)
            ])
            switch section {
            case 1:
                label.text = "Popular Restaurents"
                button.addTarget(self, action: #selector(restaurantsButtonTapped(_:)) , for: .touchUpInside)
            case 2:
                label.text = "Most Popular"
                button.addTarget(self, action: #selector(popularRestaurantsButtonTapped(_:)) , for: .touchUpInside)
            default:
                break
            }
            
            return view
            
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
            
        case 0:
            return 0
        case 1, 2:
            return 72
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 0
    }
}

//MARK: - UIViewController
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
