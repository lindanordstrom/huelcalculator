//
//  PersonalDetailsViewController.swift
//  HuelCalculator
//
//  Created by Linda on 09/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit

protocol PersonalDetailsUI: class {
    func resetAllFields()
    func populateFieldsWith(user: User)
    func showErrorMessage(_ flag: Bool)
    func dismissViewController()
    func updateUIToImperialSystem()
    func updateUIToMetricSystem()
}

class PersonalDetailsViewController: UIViewController, PersonalDetailsUI {
    
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
    @IBOutlet var errorMessageLabel: UILabel!
    @IBOutlet var heightInputFieldShowFeetConstraint: NSLayoutConstraint!
    @IBOutlet var heightInputFieldHideFeetConstraint: NSLayoutConstraint!
    
    private var selectedActivity: User.ActivityLevel?
    private var selectedActivityIndex: Int?

    private var presenter: PersonalDetailsPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        addListenerToDismissKeyboardOnTap()
        presenter = PersonalDetailsPresenter(view: self)
        presenter?.didLoadView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.didLoadView()
    }
    
    @IBAction func doneButtonPressed() {
        dismissKeyboard()

        // TODO: sort this out - always save height and weight in metric instead?
        let inches = Float(inchesInputField.text ?? "") ?? 0
        let height = (Float(heightInputField.text ?? "") ?? 0) + inches * 0.0833333333
        
        let user = User(preferredUnitOfMeasurement: User.UnitOfMeasurement(rawValue: measurementSystemSelector.selectedSegmentIndex),
                        age: Int(ageInputField.text ?? ""),
                        gender: User.Gender(rawValue: genderSelector.selectedSegmentIndex),
                        height: height > 0 ? height : nil,
                        weight: Float(weightInputField.text ?? ""),
                        goal: User.Goal(rawValue: goalSelector.selectedSegmentIndex),
                        activityLevel: selectedActivity)

        presenter?.didPressDoneButton(user: user)
    }
    
    @IBAction func resetButtonPressed() {
        dismissKeyboard()
        presenter?.didPressResetButton()
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
        let index = measurementSystemSelector.selectedSegmentIndex
        let selectedUnitOfMeasurement = User.UnitOfMeasurement(rawValue: index)
        presenter?.didChangeMeasurementValue(value: selectedUnitOfMeasurement)
    }
    
    func resetAllFields() {
        measurementSystemSelector.selectedSegmentIndex = 0
        ageInputField.text = nil
        genderSelector.selectedSegmentIndex = 0
        heightInputField.text = nil
        weightInputField.text = nil
        goalSelector.selectedSegmentIndex = 0
        setActivity(activity: User.ActivityLevel.moderately, index: 2)
        updateUIToMetricSystem()
        showErrorMessage(false)
    }

    func populateFieldsWith(user: User) {
        guard let preferredUnitOfMeasurementIndex = user.preferredUnitOfMeasurement?.rawValue,
            let age = user.age,
            let genderIndex = user.gender?.rawValue,
            let height = user.height,
            let weight = user.weight,
            let goalIndex = user.goal?.rawValue,
            let activity = user.activityLevel,
            let activityIndex = user.activityLevel?.rawValue else {
                resetAllFields()
                return
        }

        measurementSystemSelector.selectedSegmentIndex = preferredUnitOfMeasurementIndex
        ageInputField.text = "\(age)"
        genderSelector.selectedSegmentIndex = genderIndex
        if user.preferredUnitOfMeasurement == User.UnitOfMeasurement.imperial {
            let feetAndInches = feetToFeetWithInches(feetWithRemainder: height)
            heightInputField.text = "\(feetAndInches.0)"
            inchesInputField.text = "\(feetAndInches.1)"
        } else {
            heightInputField.text = "\(Int(height))"
        }
        weightInputField.text = "\(weight)"
        goalSelector.selectedSegmentIndex = goalIndex
        setActivity(activity: activity, index: activityIndex)
    }
    
    func showErrorMessage(_ flag: Bool) {
        errorMessageLabel.isHidden = !flag
    }

    private func feetToFeetWithInches(feetWithRemainder: Float) -> (Int, Int) {
        let remainder = feetWithRemainder.truncatingRemainder(dividingBy: 1)
        let feet = Int(feetWithRemainder)
        let inches = Int(round(remainder / 0.0833333333))
        return (feet, inches)
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
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }

    private func addListenerToDismissKeyboardOnTap() {
        let action = #selector(dismissKeyboard)
        let tap = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
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
}
