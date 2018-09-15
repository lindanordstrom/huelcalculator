//
//  AppFeedbackViewController.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-17.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import UIKit
import MessageUI

protocol AppFeedbackUI: class {
    func showMailComposeView(recipients: [String]?, subject: String, message: String)
    func showMailError()
}

class AppFeedbackViewController: UIViewController, AppFeedbackUI {

    private var presenter: AppFeedbackPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AppFeedbackPresenter(view: self)
        Analytics.log(withName: "AppFeedback", contentType: "Page", contentId: nil, customAttributes: nil)
    }

    @IBAction func emailButtonPressed(_ sender: Any) {
        let canSendMail = MFMailComposeViewController.canSendMail()
        presenter?.didPressSendEmailButton(canSendMail: canSendMail)
    }

    @IBAction func rateTheAppButtonPressed(_ sender: Any) {
        presenter?.didPressRateTheApp()
    }

    func showMailComposeView(recipients: [String]?, subject: String, message: String) {
        let mailComposeController = configureMailController(recipients: recipients, subject: subject, message: message)
        present(mailComposeController, animated: true, completion: nil)
    }

    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: Constants.AppFeedbackPage.couldNotOpenEmailAlertTitle, message: Constants.AppFeedbackPage.couldNotOpenEmailAlertMessage, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: Constants.General.okButtonText, style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)

        present(sendMailErrorAlert, animated: true, completion: nil)
    }

    private func configureMailController(recipients: [String]?, subject: String, message: String) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self

        mailComposerVC.setToRecipients(recipients)
        mailComposerVC.setSubject(subject)
        mailComposerVC.setMessageBody(message, isHTML: true)

        return mailComposerVC
    }
}

extension AppFeedbackViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
