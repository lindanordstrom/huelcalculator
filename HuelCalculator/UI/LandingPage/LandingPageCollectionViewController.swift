//
//  LandingPageCollectionViewController.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-16.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CalorieDistributionViewController") as? CalorieDistributionViewController else {
            return
        }
        vc.product = product
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAppFeedback() {
        // TODO
    }

    func showErrorAndPersonalDetailsPage() {
        let alert = UIAlertController(title: "No profile added", message: "You need to enter your personal details to be able to calculate your daily needs", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
            self.performSegue(withIdentifier: "showPersonalDetailsPage", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItemsOnLandingPage() ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? LandingPageItemCell

        let titleAndImage = presenter?.getTitleAndImageFrom(indexPath: indexPath)

        cell?.title.text = titleAndImage?.title
        cell?.image.image = titleAndImage?.image
    
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = view.frame.size.width * 0.4
        let height = width
        // in case you you want the cell to be 40% of your controllers view
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = view.frame.size.width * 0.07
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return view.frame.size.width * 0.07
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItemOnLandingPage(indexPath: indexPath)
    }
}
