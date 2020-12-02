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
    private var infoPopupKey: String

    private let menuItems: [MenuItem] = [.huelShake, .huelBlackShake, .huelReadyToDrink, .bar, .shop, .appFeedback]

    init(view: LandingPageUI, urlManager: UrlManager = UrlManager.shared, userManager: UserManager = HuelUserManager.shared, infoPopupKey: String = "infoPopupShown") {
        self.view = view
        self.urlManager = urlManager
        self.userManager = userManager
        self.infoPopupKey = infoPopupKey
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
        case .huelShake:
            image = #imageLiteral(resourceName: "menu_shake")
            highlightedImage = #imageLiteral(resourceName: "menu_shake_highlighted")
        case .huelBlackShake:
            image = #imageLiteral(resourceName: "menu_shake_black")
            highlightedImage = #imageLiteral(resourceName: "menu_shake_highlighted")
        case .huelReadyToDrink:
            image = #imageLiteral(resourceName: "menu_readytodrink")
            highlightedImage = #imageLiteral(resourceName: "menu_readytodrink_highlighted")
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
        case .huelShake:
            view?.showCalculationPage(with: HuelShake())
        case .huelBlackShake:
            view?.showCalculationPage(with: HuelBlackEditionShake())
        case .huelReadyToDrink:
            view?.showCalculationPage(with: HuelReadyToDrink())
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
    
    func showInfoPopupAlertIfNeeded() {
        if !UserDefaults.standard.bool(forKey: infoPopupKey) {
            UserDefaults.standard.set(true, forKey: infoPopupKey)
            
            view?.showInfoPopupAlert()
        }
    }

    private func didPressGetHuel() {
        urlManager.open(Constants.LandingPage.getHuelUrl)
        Analytics.log(withName: "GetHuel", contentType: "WebPage", contentId: nil, customAttributes: nil)
    }
}
