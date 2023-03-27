//
//  FtuxViewController.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 28/12/22.
//

import UIKit

class FtuxViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let viewModel = FtuxViewModel()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        
        observeError()
        observeCurrentIndex()
        viewModel.loadFtuxes()
    }
    
    func observeError() {
        viewModel.error.bind { [weak self] (error) in
            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func observeCurrentIndex() {
        viewModel.currentIndex.bind { [weak self] (index) in
            guard let `self` = self else { return }
            
            switch index {
            case -1:
                break
                
            case self.viewModel.numberOfItems:
                self.showLoginLandingViewController()
                
            default:
                if index == 0 {
                    self.collectionView.reloadData()
                }
                self.goToPage(index)
            }
        }
    }
}

// MARK: - Helpers
extension FtuxViewController {
    func setup() {
        nextButton.layer.cornerRadius = 28
        nextButton.layer.masksToBounds = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
//    func asdf(result: Result<[Ftux], Error>) {
//        guard let `self` = self else {
//            return
//        }
//
//        switch result {
//        case .success(let data);
//            self.ftuxes = data
//            self.pageControl.numberOfPages = self.ftuxes.CountableRange
//            self.updatePage(0)
//
//        case .failure(let error):
//            print(error.localizedDescription)
//        }
//    }
//
//    func loadFtuxes() {
//
//        let completion: (Result<[Ftux], Error>) -> Void = { [weak self] (result) in
//            guard let `self` = self else {
//                return
//            }
//
//            switch result {
//            case .success(let data):
//               self.ftuxes = data
//                self.pageControl.numberOfPages = self.ftuxes.count
//                self.updatePage(0)
//
//            case .failure(let error):
//                print(error.localizedDescription)
//
//            }
//        }
//
//        ftuxProvider.loadFtuxes(completion: completion)
//
//    }
    
    func goToPage(_ page: Int) {
        collectionView.scrollToItem(at: IndexPath(item: page, section: 0), at: .centeredHorizontally
, animated: true)
        updatePage(page)
    }
    
    
    func updatePage(_ page: Int) {
        pageControl.currentPage = page
        nextButton.setTitle(viewModel.buttonTitleAtIndex(page), for: .normal)
    }
}
    
// MARK: - Actions
extension FtuxViewController {
    @IBAction func nextButtonTapped(_ sender: Any) {
        let toPage = min(viewModel.numberOfItems, pageControl.currentPage + 1)
//        if toPage != pageControl.currentPage {
//            goToPage(toPage)
//        }
        viewModel.currentIndex.value = toPage
    }
}

// MARK: - UICollectionViewDataSource
extension FtuxViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ftux_cell", for: indexPath) as! FtuxViewCell
        
        cell.imageView.image = viewModel.imageAtIndex(indexPath.item)
        cell.titleLabel.text = viewModel.titleAtIndex(indexPath.item)
        cell.subtitleLabel.text = viewModel.subtitleAtIndex(indexPath.item)
        
        return cell
        
    }
}

// MARK: - UICollectionViewDelegate
extension FtuxViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        updatePage(page)
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FtuxViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
