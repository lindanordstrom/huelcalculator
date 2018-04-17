//
//  AppFeedbackViewController.swift
//  HuelCalculator
//
//  Created by Linda on 2018-04-17.
//  Copyright © 2018 Linda CC Nordstrom. All rights reserved.
//

import UIKit
import MessageUI

class AppFeedbackViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func emailButtonPressed(_ sender: Any) {
        let mailComposeController = configureMailController()
        guard MFMailComposeViewController.canSendMail() else {
            showMailError()
            return
        }

        present(mailComposeController, animated: true, completion: nil)
    }

    @IBAction func rateTheAppButtonPressed(_ sender: Any) {
        UrlManager.shared.open(Constants.AppFeedbackPage.appStoreUrl)
    }

    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self

        mailComposerVC.setToRecipients([Constants.AppFeedbackPage.emailRecipient])
        mailComposerVC.setSubject(Constants.AppFeedbackPage.emailSubject)
        mailComposerVC.setMessageBody(Constants.AppFeedbackPage.emailMessage, isHTML: true)

        return mailComposerVC
    }

    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: Constants.AppFeedbackPage.couldNotOpenEmailAlertTitle, message: Constants.AppFeedbackPage.couldNotOpenEmailAlertMessage, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: Constants.General.okButtonText, style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)

        present(sendMailErrorAlert, animated: true, completion: nil)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
