//
//  CalorieDistributionViewController.swift
//  HuelCalculator
//
//  Created by Linda on 09/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit

class CalorieDistributionViewController: UIViewController, CalorieDistributionPresentable {
    
    @IBOutlet var remainingCaloriesLabel: UILabel!
    @IBOutlet var breakfastCaloriesInputField: UITextField!
    @IBOutlet var lunchCaloriesInputField: UITextField!
    @IBOutlet var dinnerCaloriesInputField: UITextField!
    @IBOutlet var snackCaloriesInputField: UITextField!
    
    var user: User?
    
    private let presenter = CalorieDistributionPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.set(view: self)
        setRemainingCaloriesLabel(calories: user?.dailyCalorieConsumption ?? 0)
        setBreakfastCaloriesInputField(calories: user?.calorieDistribution.breakfast ?? 0)
        setLunchCaloriesInputField(calories: user?.calorieDistribution.lunch ?? 0)
        setDinnerCaloriesInputField(calories: user?.calorieDistribution.dinner ?? 0)
        setSnackCaloriesInputField(calories: user?.calorieDistribution.snacks ?? 0)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CalorieDistributionViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func nextButtonPressed() {
        user?.calorieDistribution.breakfast = Int(breakfastCaloriesInputField.text ?? "") ?? 0
        user?.calorieDistribution.lunch = Int(lunchCaloriesInputField.text ?? "") ?? 0
        user?.calorieDistribution.dinner = Int(dinnerCaloriesInputField.text ?? "") ?? 0
        user?.calorieDistribution.snacks = Int(snackCaloriesInputField.text ?? "") ?? 0
        presenter.didPressNextButton(remainingCalories: remainingCaloriesLabel.text)
    }
    
    @IBAction func splitEquallyButtonPressed() {
        presenter.didPressSplitEquallyButton(calories: user?.dailyCalorieConsumption)
    }

    @IBAction func inputFieldUpdated(_ sender: UITextField) {
        guard let breakfast = breakfastCaloriesInputField.text,
            let lunch = lunchCaloriesInputField.text,
            let dinner = dinnerCaloriesInputField.text,
            let snack = snackCaloriesInputField.text else {
                return
        }
        presenter.didUpdateInputField(dailyConsumtion: user?.dailyCalorieConsumption, breakfast: breakfast, lunch: lunch, dinner: dinner, snack: snack)
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
        let alert = UIAlertController(title: "Warning", message: "Your remaining calories are \(remainingCalories), are you sure you want to continue?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.default, handler: { action in
            self.navigateToMealPlanViewController()
        }))
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigateToMealPlanViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MealPlanViewController") as? MealPlanViewController else {
            return
        }
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
