//
//  LandingPagePresenter.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-16.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import UIKit

class LandingPagePresenter {
    private weak var view: LandingPageUI?
    private var urlManager: UrlManager
    private var userManager: UserManager

    private let menuItems: [menuItem] = [.unflavouredShake, .vanillaShake, .bar, .shop, .appFeedback]

    init(view: LandingPageUI, urlManager: UrlManager = UrlManager.shared, userManager: UserManager = HuelUserManager.shared) {
        self.view = view
        self.urlManager = urlManager
        self.userManager = userManager
    }

    func numberOfItemsOnLandingPage() -> Int {
        return menuItems.count
    }

    func getTitleAndImageFrom(indexPath: IndexPath) -> (title: String?, image: UIImage?, highlightedImage: UIImage?) {
        let menuItem = menuItems[indexPath.item]

        let title = menuItem.rawValue
        var image: UIImage?
        var highlightedImage: UIImage?

        switch menuItem {
        case .unflavouredShake, .vanillaShake:
            image = #imageLiteral(resourceName: "menu_shake")
            highlightedImage = #imageLiteral(resourceName: "menu_shake_highlighted")
        case .bar:
            image = #imageLiteral(resourceName: "menu_bar")
            highlightedImage = #imageLiteral(resourceName: "menu_bar_highlighted")
        case .shop:
            image = #imageLiteral(resourceName: "menu_shop")
            highlightedImage = #imageLiteral(resourceName: "menu_shop_highlighted")
        case .appFeedback:
            image = #imageLiteral(resourceName: "menu_feedack")
            highlightedImage = #imageLiteral(resourceName: "menu_feedack_highlighted")
        }

        return (title: title, image: image, highlightedImage: highlightedImage)
    }

    func didSelectItemOnLandingPage(indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.item]

        switch menuItem {
        case .unflavouredShake:
            view?.showCalculationPage(with: HuelUnflavouredShake())
        case .vanillaShake:
            view?.showCalculationPage(with: HuelVanillaShake())
        case .bar:
            view?.showCalculationPage(with: HuelBar())
        case .shop:
            didPressGetHuel()
        case .appFeedback:
            view?.showAppFeedback()
        }
    }

    func showPersonalDetailsPageIfNeeded() {
        guard !userManager.signedInUserExists() else {
            return
        }

        view?.showErrorAndPersonalDetailsPage()
    }

    private func didPressGetHuel() {
        urlManager.open(Constants.LandingPage.getHuelUrl)
    }
}
