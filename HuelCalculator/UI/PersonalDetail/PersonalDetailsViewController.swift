//
//  PersonalDetailsViewController.swift
//  HuelCalculator
//
//  Created by Linda on 09/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit

class PersonalDetailsViewController: UIViewController, PersonalDetailsPresentable {
    
    @IBOutlet var measurementSystemSelector: UISegmentedControl!
    @IBOutlet var ageInputField: UITextField!
    @IBOutlet var genderSelector: UISegmentedControl!
    @IBOutlet var heightInputField: UITextField!
    @IBOutlet var heightUnitLabel: UILabel!
    @IBOutlet var weightInputField: UITextField!
    @IBOutlet var weightUnitLabel: UILabel!
    @IBOutlet var activityButton: UIButton!
    @IBOutlet var goalSelector: UISegmentedControl!
    @IBOutlet var flavourSelector: UISegmentedControl!
    @IBOutlet var errorMessageLabel: UILabel!
    
    var selectedActivity: User.ActivityLevel? = .moderately
    
    private let presenter = PersonalDetailsPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.set(view: self)
    }
    
    @IBAction func calculateButtonPressed() {
        errorMessageLabel.isHidden = true
        let user = User(preferredUnitOfMeasurement: User.UnitOfMeasurement(rawValue: measurementSystemSelector.selectedSegmentIndex),
                        age: Int(ageInputField.text ?? ""),
                        gender: User.Gender(rawValue: genderSelector.selectedSegmentIndex),
                        height: Float(heightInputField.text ?? ""),
                        weight: Float(weightInputField.text ?? ""),
                        goal: User.Goal(rawValue: goalSelector.selectedSegmentIndex),
                        activityLevel: selectedActivity,
                        flavour: User.Flavour(rawValue: flavourSelector.selectedSegmentIndex))
        presenter.didPressCalculateButton(user: user)
    }
    
    @IBAction func resetButtonPressed() {
        errorMessageLabel.isHidden = true
        presenter.didPressResetButton()
    }
    
    @IBAction func activitySelectorPressed() {
        // show picker
    }
    
    @IBAction func measurementSelectorValueChanged() {
        presenter.didChangeMeasurementValue(value: User.UnitOfMeasurement(rawValue: measurementSystemSelector.selectedSegmentIndex))
    }
    
    func resetAllFields() {
        measurementSystemSelector.selectedSegmentIndex = 0
        ageInputField.text = nil
        genderSelector.selectedSegmentIndex = 0
        heightInputField.text = nil
        weightInputField.text = nil
        goalSelector.selectedSegmentIndex = 0
        activityButton.setTitle("Select activity...", for: .normal)
        selectedActivity = nil
    }
    
    func showErrorMessage() {
        errorMessageLabel.isHidden = false
    }
    
    func updateUIToImperialSystem() {
        heightUnitLabel.text = "feet"
        weightUnitLabel.text = "pounds"
    }
    
    func updateUIToMetricSystem() {
        heightUnitLabel.text = "cm"
        weightUnitLabel.text = "kg"
    }
    
    func navigateToCalorieDistributionViewController(user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CalorieDistributionViewController") as? CalorieDistributionViewController else {
            return
        }
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
}
