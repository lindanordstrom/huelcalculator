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

class LandingPageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, LandingPageUI {
    var presenter: LandingPagePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LandingPagePresenter(view: self)
    }

    func showCalculationPage(with product: MealReplacementProduct) {
        presenter?.showPersonalDetailsPageIfNeeded()
        let storyboard = UIStoryboard(name: Constants.General.storyboardMain, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.CalorieDistributionPage.viewControllerName) as? CalorieDistributionViewController else {
            return
        }
        vc.product = product
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAppFeedback() {
        let storyboard = UIStoryboard(name: Constants.General.storyboardMain, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.AppFeedbackPage.viewControllerName) as? AppFeedbackViewController else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    func showErrorAndPersonalDetailsPage() {
        let alert = UIAlertController(title: Constants.LandingPage.noProfileAlertTitle, message: Constants.LandingPage.noProfileAlertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Constants.General.okButtonText, style: UIAlertActionStyle.default, handler: { action in
            self.performSegue(withIdentifier: Constants.PersonalDetailsPage.segueToThisPageName, sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItemsOnLandingPage() ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.LandingPage.cellIdentifier, for: indexPath) as? LandingPageItemCell

        let titleAndImage = presenter?.getTitleAndImageFrom(indexPath: indexPath)

        cell?.title.text = titleAndImage?.title
        cell?.image.image = titleAndImage?.image
        cell?.image.highlightedImage = titleAndImage?.highlightedImage
    
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = view.frame.size.width * 0.4
        let height = width

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = view.frame.size.width * 0.07
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return view.frame.size.width * 0.07
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItemOnLandingPage(indexPath: indexPath)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            switch kind {
            case UICollectionElementKindSectionHeader:
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            default:
                assert(false, "Unexpected element kind")
            }
    }
}
