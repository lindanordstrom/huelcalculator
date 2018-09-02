//
//  PersonalDetailsPresenter.swift
//  HuelCalculator
//
//  Created by Linda on 12/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import Foundation

class PersonalDetailsPresenter {
    
    private weak var view: PersonalDetailsUI?
    private var userManager: UserManager

    init(view: PersonalDetailsUI, userManager: UserManager = HuelUserManager.shared) {
        self.view = view
        self.userManager = userManager
    }

    func didLoadView() {
        guard let user = userManager.getSignedInUser() else {
            view?.resetAllFields()
            return
        }

        let metricIsSelected = user.preferredUnitOfMeasurement == User.UnitOfMeasurement.metric

        if metricIsSelected {
            view?.updateUIToMetricSystem()
        } else {
            view?.updateUIToImperialSystem()
        }

        view?.populateFieldsWith(user: user)
    }

    func didPressResetButton() {
        view?.resetAllFields()
    }
    
    func didPressDoneButton(user: User?) {
        var user = user
        guard user?.bornYear?.isEmpty == false, user?.weight != nil, user?.height != nil else {
            view?.showErrorMessage(true)
            return
        }
        userManager.saveOldCalorieDistributionsIfNeeded(user: &user)
        userManager.saveUserToDataStore(user: user)
        userManager.setUsersDailyCalorieConsumption()
        view?.showErrorMessage(false)
        view?.dismissViewController()
    }
    
    func didChangeMeasurementValue(value: User.UnitOfMeasurement) {
        switch value {
        case .imperial:
            view?.updateUIToImperialSystem()
        case .metric:
            view?.updateUIToMetricSystem()
        }
    }
}
