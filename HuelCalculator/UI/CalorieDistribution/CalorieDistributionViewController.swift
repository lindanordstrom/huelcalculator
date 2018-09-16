//
//  CalorieDistributionViewController.swift
//  HuelCalculator
//
//  Created by Linda on 09/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit

protocol CalorieDistributionUI: class {
    func setRemainingCaloriesLabel(calories: Int)
    func setBreakfastCaloriesInputField(calories: Int)
    func setLunchCaloriesInputField(calories: Int)
    func setDinnerCaloriesInputField(calories: Int)
    func setSnackCaloriesInputField(calories: Int)
    func setRemainingCaloriesLabelRed()
    func setRemainingCaloriesLabelBlack()
    func showPopupWarning(remainingCalories: Int)
}

class CalorieDistributionViewController: UIViewController, CalorieDistributionUI {
    
    @IBOutlet private var remainingCaloriesLabel: UILabel!
    @IBOutlet private var breakfastCaloriesInputField: UITextField!
    @IBOutlet private var lunchCaloriesInputField: UITextField!
    @IBOutlet private var dinnerCaloriesInputField: UITextField!
    @IBOutlet private var snackCaloriesInputField: UITextField!
        
    private var presenter: CalorieDistributionPresenter?

    var product: MealReplacementProduct?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CalorieDistributionPresenter(view: self)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(CalorieDistributionViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        Analytics.log(withName: "CalorieDistribution", contentType: "Page", contentId: nil, customAttributes: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.updateInputFields()
    }
    
    @IBAction private func splitEquallyButtonPressed() {
        presenter?.didPressSplitEquallyButton()
    }

    @IBAction private func inputFieldUpdated(_ sender: UITextField) {
        let breakfast = Int(breakfastCaloriesInputField.text ?? Constants.General.zeroString) ?? 0
        let lunch = Int(lunchCaloriesInputField.text ?? Constants.General.zeroString) ?? 0
        let dinner = Int(dinnerCaloriesInputField.text ?? Constants.General.zeroString) ?? 0
        let snack = Int(snackCaloriesInputField.text ?? Constants.General.zeroString) ?? 0
        
        presenter?.updateUserConsumption(breakfast: breakfast, lunch: lunch, dinner: dinner, snack: snack)
        presenter?.updateInputFields()
    }

    func setRemainingCaloriesLabel(calories: Int) {
        remainingCaloriesLabel.text = "\(calories)"
    }

    func setBreakfastCaloriesInputField(calories: Int) {
        breakfastCaloriesInputField.text = "\(calories)"
    }
    
    func setLunchCaloriesInputField(calories: Int) {
        lunchCaloriesInputField.text = "\(calories)"
    }
    
    func setDinnerCaloriesInputField(calories: Int) {
        dinnerCaloriesInputField.text = "\(calories)"
    }
    
    func setSnackCaloriesInputField(calories: Int) {
        snackCaloriesInputField.text = "\(calories)"
    }
    
    func setRemainingCaloriesLabelRed() {
        remainingCaloriesLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    }
    
    func setRemainingCaloriesLabelBlack() {
        remainingCaloriesLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func showPopupWarning(remainingCalories: Int) {
        var message = Constants.CalorieDistributionPage.remainingCaloriesAlertMessagePart1
        message += "\(remainingCalories)"
        message += Constants.CalorieDistributionPage.remainingCaloriesAlertMessagePart2
        
        let alert = UIAlertController(title: Constants.General.warningAlertTitle,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Constants.General.yesButtonText,
                                      style: UIAlertActionStyle.default) { _ in
                                        self.performSegue(withIdentifier: Constants.MealPlanPage.segueToThisPageName, sender: nil)
            }
        )
        alert.addAction(UIAlertAction(title: Constants.General.noButtonText,
                                      style: UIAlertActionStyle.cancel,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == Constants.MealPlanPage.segueToThisPageName else {
            return true
        }
        return presenter?.shouldShowMealPlanPage(remainingCalories: Int(remainingCaloriesLabel.text ?? Constants.General.emptyString)) ?? false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? MealPlanViewController {
            viewController.product = product
        }
    }
}
