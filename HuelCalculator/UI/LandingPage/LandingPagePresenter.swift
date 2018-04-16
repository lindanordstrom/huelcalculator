//
//  LandingPagePresenter.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-16.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import UIKit

protocol UrlHandler {
    func openURL(_ url: URL) -> Bool
}

extension UIApplication: UrlHandler {}

class LandingPagePresenter {

    private let urlHandler: UrlHandler
    private let huelUrl = "https://huel.com/products/huel"
    private weak var view: LandingPageUI?

    private enum menuItem: String {
        case vanillaShake = "Vanilla shake"
        case unflavouredShake = "Unflavoured shake"
        case bar = "Bar"
        case shop = "Buy Huel"
        case appFeedback = "App Feedback"
    }

    private let menuItems: [menuItem] = [.unflavouredShake, .vanillaShake, .bar, .shop, .appFeedback]

    init(view: LandingPageUI, urlHandler: UrlHandler = UIApplication.shared) {
        self.view = view
        self.urlHandler = urlHandler
    }

    func numberOfItemsOnLandingPage() -> Int {
        return menuItems.count
    }

    func getTitleAndImageFrom(indexPath: IndexPath) -> (title: String?, image: UIImage?) {
        let menuItem = menuItems[indexPath.item]

        let title = menuItem.rawValue
        var image: UIImage?

        switch menuItem {
        case .unflavouredShake, .vanillaShake:
            image = #imageLiteral(resourceName: "menu_shake")
        case .bar:
            image = #imageLiteral(resourceName: "menu_bar")
        case .shop:
            image = #imageLiteral(resourceName: "menu_shop")
        case .appFeedback:
            image = #imageLiteral(resourceName: "menu_feedack")
        }

        return (title: title, image: image)
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

    private func didPressGetHuel() {
        guard let url = URL(string: huelUrl) else {
            return
        }
        _ = urlHandler.openURL(url)
    }
}
