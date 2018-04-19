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
    
    @IBOutlet var remainingCaloriesLabel: UILabel!
    @IBOutlet var breakfastCaloriesInputField: UITextField!
    @IBOutlet var lunchCaloriesInputField: UITextField!
    @IBOutlet var dinnerCaloriesInputField: UITextField!
    @IBOutlet var snackCaloriesInputField: UITextField!
        
    private var presenter: CalorieDistributionPresenter?

    var product: MealReplacementProduct?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CalorieDistributionPresenter(view: self)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CalorieDistributionViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.updateInputFields()
    }
    
    @IBAction func splitEquallyButtonPressed() {
        presenter?.didPressSplitEquallyButton()
    }

    @IBAction func inputFieldUpdated(_ sender: UITextField) {
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
        let alert = UIAlertController(title: Constants.General.warningAlertTitle, message: "\(Constants.CalorieDistributionPage.remainingCaloriesAlertMessagePart1)\(remainingCalories)\(Constants.CalorieDistributionPage.remainingCaloriesAlertMessagePart2)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Constants.General.yesButtonText, style: UIAlertActionStyle.default, handler: { action in
            self.performSegue(withIdentifier: Constants.MealPlanPage.segueToThisPageName, sender: nil)
        }))
        alert.addAction(UIAlertAction(title: Constants.General.noButtonText, style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        if let vc = segue.destination as? MealPlanViewController {
            vc.product = product
        }
    }
}
