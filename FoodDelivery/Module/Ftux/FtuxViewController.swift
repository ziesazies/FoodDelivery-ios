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
    
    var ftuxes: [Ftux] = []
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        
        loadFtuxes()
        
        
    }
    
    // MARK: - Helpers
    func setup() {
        nextButton.layer.cornerRadius = 28
        nextButton.layer.masksToBounds = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func goToPage(_ page: Int) {
        collectionView.scrollToItem(at: IndexPath(item: page, section: 0), at: .centeredHorizontally
, animated: true)
        updatePage(page)
    }
    
    func loadFtuxes() {
        ftuxes = FtuxProvider.shared.loadFtuxes()
        pageControl.numberOfPages = ftuxes.count
        updatePage(0)
    }
    
    func updatePage(_ page: Int) {
        pageControl.currentPage = page
        nextButton.setTitle(page == ftuxes.count - 1 ? "Let's begin": "Next", for: .normal)
    }
    
    // MARK: - Action
    @IBAction func nextButtonTapped(_ sender: Any) {
        let toPage = min(ftuxes.count - 1, pageControl.currentPage + 1)
        if toPage != pageControl.currentPage {
            goToPage(toPage)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FtuxViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ftuxes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ftux_cell", for: indexPath) as! FtuxViewCell
        
        let ftux = self.ftuxes[indexPath.item]
        cell.imageView.image = UIImage(named: ftux.image)
        cell.titleLabel.text = ftux.title
        cell.subtitleLabel.text = ftux.subtitle
        
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
