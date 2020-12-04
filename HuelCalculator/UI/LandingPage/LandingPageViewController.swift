//
//  LandingPageCollectionViewController.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-16.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import UIKit

protocol LandingPageUI: class {
    func showCalculationPage(with product: MealReplacementProduct)
    func showAppFeedback()
    func showErrorAndPersonalDetailsPage()
}

class LandingPageViewController: UIViewController, LandingPageUI {
    var presenter: LandingPagePresenter?

    @IBOutlet private var collectionView: UICollectionView!
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = collectionView.indexPathsForSelectedItems?.first {
            collectionView.deselectItem(at: indexPath, animated: animated)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LandingPagePresenter(view: self)
        Analytics.log(withName: "LandingPage", contentType: "Page", contentId: nil, customAttributes: nil)
    }

    func showCalculationPage(with product: MealReplacementProduct) {
        presenter?.showPersonalDetailsPageIfNeeded()
        let storyboard = UIStoryboard(name: Constants.General.storyboardMain, bundle: nil)
        let identifier = Constants.CalorieDistributionPage.viewControllerName
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? CalorieDistributionViewController else {
            return
        }
        viewController.product = product
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showAppFeedback() {
        let storyboard = UIStoryboard(name: Constants.General.storyboardMain, bundle: nil)
        let identifier = Constants.AppFeedbackPage.viewControllerName
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? AppFeedbackViewController else {
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showErrorAndPersonalDetailsPage() {
        let alert = UIAlertController(title: Constants.LandingPage.noProfileAlertTitle,
                                      message: Constants.LandingPage.noProfileAlertMessage,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Constants.General.okButtonText,
                                      style: UIAlertActionStyle.default) { _ in
            self.performSegue(withIdentifier: Constants.PersonalDetailsPage.segueToThisPageName, sender: nil)
            }
        )
        present(alert, animated: true, completion: nil)
    }
}

// MARK: UICollectionViewDataSource
extension LandingPageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItemsOnLandingPage() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.LandingPage.cellIdentifier,
                                                      for: indexPath) as? LandingPageItemCell
        
        let titleAndImage = presenter?.getTitleAndImageFrom(indexPath: indexPath)
        
        cell?.title.text = titleAndImage?.title
        cell?.image.image = titleAndImage?.image
        cell?.image.highlightedImage = titleAndImage?.highlightedImage
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width * 0.4
        let height = width * 0.9
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = view.frame.size.width * 0.07
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
}

// MARK: UICollectionViewDelegate
extension LandingPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItemOnLandingPage(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: "Header",
                                                                   for: indexPath)
        default:
            assert(false, "Unexpected element kind")
            return UICollectionReusableView()
        }
    }
}
