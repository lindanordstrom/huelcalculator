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
    @IBOutlet var inchesInputField: UITextField!
    @IBOutlet var weightInputField: UITextField!
    @IBOutlet var weightUnitLabel: UILabel!
    @IBOutlet var activityButton: UIButton!
    @IBOutlet var goalSelector: UISegmentedControl!
    @IBOutlet var flavourSelector: UISegmentedControl!
    @IBOutlet var errorMessageLabel: UILabel!
    @IBOutlet var heightInputFieldShowFeetConstraint: NSLayoutConstraint!
    @IBOutlet var heightInputFieldHideFeetConstraint: NSLayoutConstraint!
    
    var selectedActivity: User.ActivityLevel?
    var selectedActivityIndex: Int?
    var activityPicker: UIPickerView?
    
    private let presenter = PersonalDetailsPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.set(view: self)
        resetAllFields()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PersonalDetailsViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func calculateButtonPressed() {
        dismissKeyboard()
        errorMessageLabel.isHidden = true
        
        let inches = Float(inchesInputField.text ?? "")
        let height = (Float(heightInputField.text ?? "") ?? 0) + (inches ?? 0) * 0.0833333333
        
        let user = User(preferredUnitOfMeasurement: User.UnitOfMeasurement(rawValue: measurementSystemSelector.selectedSegmentIndex),
                        age: Int(ageInputField.text ?? ""),
                        gender: User.Gender(rawValue: genderSelector.selectedSegmentIndex),
                        height: height > 0 ? height : nil,
                        weight: Float(weightInputField.text ?? ""),
                        goal: User.Goal(rawValue: goalSelector.selectedSegmentIndex),
                        activityLevel: selectedActivity,
                        flavour: User.Flavour(rawValue: flavourSelector.selectedSegmentIndex))
        presenter.didPressCalculateButton(user: user)
    }
    
    @IBAction func resetButtonPressed() {
        dismissKeyboard()
        errorMessageLabel.isHidden = true
        presenter.didPressResetButton()
    }
    
    @IBAction func activitySelectorPressed() {
        dismissKeyboard()
        let pickerView = ActivityPickerViewController(index: selectedActivityIndex ?? 0)
        pickerView.modalPresentationStyle = .overCurrentContext
        pickerView.set { (activityValue, index) in
            self.setActivity(activity: activityValue, index: index)
        }
        present(pickerView, animated: false, completion: nil)
    }
    
    @IBAction func measurementSelectorValueChanged() {
        presenter.didChangeMeasurementValue(value: User.UnitOfMeasurement(rawValue: measurementSystemSelector.selectedSegmentIndex))
    }
    
    private func setActivity(activity: User.ActivityLevel?, index: Int?) {
        guard let activity = activity else {
            selectedActivity = nil
            selectedActivityIndex = nil
            return
        }
        let activityString = User.ActivityLevel.getActivityString(activity: activity)
        activityButton.setTitle(activityString, for: .normal)
        selectedActivity = activity
        selectedActivityIndex = index
    }
    
    func resetAllFields() {
        measurementSystemSelector.selectedSegmentIndex = 0
        ageInputField.text = nil
        genderSelector.selectedSegmentIndex = 0
        heightInputField.text = nil
        weightInputField.text = nil
        goalSelector.selectedSegmentIndex = 0
        setActivity(activity: User.ActivityLevel.moderately, index: 2)
        flavourSelector.selectedSegmentIndex = 0
        updateUIToMetricSystem()
    }
    
    func showErrorMessage() {
        errorMessageLabel.isHidden = false
    }
    
    func updateUIToImperialSystem() {
        heightUnitLabel.text = "inches"
        weightUnitLabel.text = "pounds"
        for index in 0..<goalSelector.numberOfSegments {
            let title = goalSelector.titleForSegment(at: index)?.replacingOccurrences(of: "0.5 kg", with: "1 lb")
            goalSelector.setTitle(title, forSegmentAt: index)
        }
        heightInputFieldHideFeetConstraint.isActive = false
        heightInputFieldShowFeetConstraint.isActive = true
    }
    
    func updateUIToMetricSystem() {
        heightUnitLabel.text = "cm"
        weightUnitLabel.text = "kg"
        for index in 0..<goalSelector.numberOfSegments {
            let title = goalSelector.titleForSegment(at: index)?.replacingOccurrences(of: "1 lb", with: "0.5 kg")
            goalSelector.setTitle(title, forSegmentAt: index)
        }
        heightInputFieldShowFeetConstraint.isActive = false
        heightInputFieldHideFeetConstraint.isActive = true
        inchesInputField.text = nil
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
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
