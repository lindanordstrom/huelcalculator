//
//  AppFeedbackPresenter.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-17.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import UIKit

class AppFeedbackPresenter {
    private weak var view: AppFeedbackUI?
    private var device: DeviceInfo
    private var urlManager: UrlManager

    init(view: AppFeedbackUI, device: DeviceInfo = UIDevice.current, urlManager: UrlManager = UrlManager.shared) {
        self.view = view
        self.device = device
        self.urlManager = urlManager
    }

    func didPressSendEmailButton(canSendMail: Bool) {
        guard canSendMail else {
            view?.showMailError()
            return
        }

        let osVersion = device.systemVersion
        let modelName = device.modelName
        let appVersion = Bundle.main.infoDictionary?[Constants.AppFeedbackPage.appVersionKey] as? String ?? Constants.General.emptyString

        let recipients = [Constants.AppFeedbackPage.emailRecipient]
        let subject = Constants.AppFeedbackPage.emailSubject
        let message = String(format: Constants.AppFeedbackPage.emailMessage, appVersion, modelName, osVersion)

        view?.showMailComposeView(recipients: recipients, subject: subject, message: message)
    }

    func didPressRateTheApp() {
        urlManager.open(Constants.AppFeedbackPage.appStoreUrl)
    }
}
