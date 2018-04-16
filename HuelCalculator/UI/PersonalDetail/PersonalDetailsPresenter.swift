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

    init(view: PersonalDetailsUI) {
        self.view = view
    }

    func didLoadView() {
        guard let user = HuelUserManager.shared.getSignedInUser() else {
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
        guard user?.age != nil, user?.weight != nil, user?.height != nil else {
            view?.showErrorMessage(true)
            return
        }
        HuelUserManager.shared.saveOldCalorieDistributionsIfNeeded(user: &user)
        HuelUserManager.shared.saveUserToDataStore(user: user)
        HuelUserManager.shared.setUsersDailyCalorieConsumption()
        view?.showErrorMessage(false)
        view?.dismissViewController()
    }
    
    func didChangeMeasurementValue(value: User.UnitOfMeasurement?) {
        guard let value = value else { return }
        switch value {
        case .imperial:
            view?.updateUIToImperialSystem()
        case .metric:
            view?.updateUIToMetricSystem()
        }
    }
}
