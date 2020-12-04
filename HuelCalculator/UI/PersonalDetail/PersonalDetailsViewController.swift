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
    func showKcalMessage(_ flag: Bool, calories: Int?)
    func dismissViewController()
    func updateUIToImperialSystem()
    func updateUIToMetricSystem()
}

class PersonalDetailsViewController: UIViewController, PersonalDetailsUI {

    @IBOutlet private var measurementSystemSelector: UISegmentedControl!
    @IBOutlet private var bornYearInputField: UITextField!
    @IBOutlet private var genderSelector: UISegmentedControl!
    @IBOutlet private var heightInputField: UITextField!
    @IBOutlet private var heightUnitLabel: UILabel!
    @IBOutlet private var feetLabel: UILabel!
    @IBOutlet private var inchesInputField: UITextField!
    @IBOutlet private var weightInputField: UITextField!
    @IBOutlet private var weightUnitLabel: UILabel!
    @IBOutlet private var activityButton: UIButton!
    @IBOutlet private var goalSelector: UISegmentedControl!
    @IBOutlet private var errorMessageLabel: UILabel!
    @IBOutlet private var kcalLabel: UILabel!
    @IBOutlet private var heightInputFieldShowFeetConstraint: NSLayoutConstraint!
    @IBOutlet private var heightInputFieldHideFeetConstraint: NSLayoutConstraint!

    private var selectedActivity: User.ActivityLevel?

    private var presenter: PersonalDetailsPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        addListenerToDismissKeyboardOnTap()
        presenter = PersonalDetailsPresenter(view: self)
        presenter?.didLoadView()
        Analytics.log(withName: "PersonalDetails", contentType: "Page", contentId: nil, customAttributes: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        measurementSystemSelector.addTarget(self, action: #selector(personalDetailsChanged), for: .valueChanged)
        bornYearInputField.addTarget(self, action: #selector(personalDetailsChanged), for: .allEditingEvents)
        genderSelector.addTarget(self, action: #selector(personalDetailsChanged), for: .valueChanged)
        heightInputField.addTarget(self, action: #selector(personalDetailsChanged), for: .allEditingEvents)
        inchesInputField.addTarget(self, action: #selector(personalDetailsChanged), for: .allEditingEvents)
        weightInputField.addTarget(self, action: #selector(personalDetailsChanged), for: .allEditingEvents)
        goalSelector.addTarget(self, action: #selector(personalDetailsChanged), for: .valueChanged)
        
        presenter?.didLoadView()
    }
    
    @objc func personalDetailsChanged() {
        presenter?.fieldWasUpdated(user: getUserWithCurrentDetails())

    }

    @IBAction private func doneButtonPressed() {
        dismissKeyboard()
        presenter?.didPressDoneButton(user: getUserWithCurrentDetails())
    }
    
    private func getUserWithCurrentDetails() -> User {
        let inches = Float(inchesInputField.text ?? Constants.General.emptyString) ?? 0
        let height = (Float(heightInputField.text ?? Constants.General.emptyString) ?? 0) + inches * 0.0833333333
        
        let preferredUnitOfMeasurement = User.UnitOfMeasurement(rawValue: measurementSystemSelector.selectedSegmentIndex)
        
        return User(preferredUnitOfMeasurement: preferredUnitOfMeasurement,
                    bornYear: bornYearInputField.text,
                    gender: User.Gender(rawValue: genderSelector.selectedSegmentIndex),
                    height: height > 0 ? height : nil,
                    weight: Float(weightInputField.text ?? Constants.General.emptyString),
                    goal: User.Goal(rawValue: goalSelector.selectedSegmentIndex),
                    activityLevel: selectedActivity)
    }
    
    @IBAction private func resetButtonPressed() {
        dismissKeyboard()
        presenter?.didPressResetButton()
    }

    @IBAction private func closeButtonPressed(_ sender: Any) {
        dismissViewController()
    }
    
    @IBAction private func activitySelectorPressed() {
        dismissKeyboard()
        let pickerView = PickerViewController(with: User.ActivityLevel.self,
                                              index: selectedActivity?.rawValue ?? 0) { (activityLevel: Pickable?) in
            self.setActivity(activity: activityLevel as? User.ActivityLevel)
            self.personalDetailsChanged()
        }
        pickerView.modalPresentationStyle = .overCurrentContext
        present(pickerView, animated: false, completion: nil)
    }
    
    @IBAction private func measurementSelectorValueChanged() {
        let index = measurementSystemSelector.selectedSegmentIndex
        guard let selectedUnitOfMeasurement = User.UnitOfMeasurement(rawValue: index) else { return }
        presenter?.didChangeMeasurementValue(value: selectedUnitOfMeasurement)
    }
    
    func resetAllFields() {
        measurementSystemSelector.selectedSegmentIndex = 0
        bornYearInputField.text = nil
        genderSelector.selectedSegmentIndex = 0
        heightInputField.text = nil
        weightInputField.text = nil
        goalSelector.selectedSegmentIndex = 0
        setActivity(activity: User.ActivityLevel.moderately)
        updateUIToMetricSystem()
        showErrorMessage(false)
        showKcalMessage(false, calories: nil)
    }

    func populateFieldsWith(user: User) {
        guard let preferredUnitOfMeasurementIndex = user.preferredUnitOfMeasurement?.rawValue,
            let genderIndex = user.gender?.rawValue,
            let height = user.height,
            let weight = user.weight,
            let goalIndex = user.goal?.rawValue,
            let activity = user.activityLevel else {
                resetAllFields()
                return
        }

        measurementSystemSelector.selectedSegmentIndex = preferredUnitOfMeasurementIndex
        bornYearInputField.text = user.bornYear
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
        setActivity(activity: activity)
    }
    
    func showErrorMessage(_ flag: Bool) {
        errorMessageLabel.isHidden = !flag
    }
    
    func showKcalMessage(_ flag: Bool, calories: Int?) {
        kcalLabel.isHidden = !flag
        if let calories = calories {
            kcalLabel.text = "\(calories) kcal per day"
        }
    }

    private func feetToFeetWithInches(feetWithRemainder: Float) -> (Int, Int) {
        let remainder = feetWithRemainder.truncatingRemainder(dividingBy: 1)
        let feet = Int(feetWithRemainder)
        let inches = Int(round(remainder / 0.0833333333))
        return (feet, inches)
    }
    
    func updateUIToImperialSystem() {
        inchesInputField.isHidden = false
        feetLabel.isHidden = false
        
        heightUnitLabel.text = Constants.PersonalDetailsPage.inches
        weightUnitLabel.text = Constants.PersonalDetailsPage.pounds
        for index in 0..<goalSelector.numberOfSegments {
            var title = goalSelector.titleForSegment(at: index)
            title = title?.replacingOccurrences(of: Constants.PersonalDetailsPage.halfKilo,
                                                with: Constants.PersonalDetailsPage.onePound)
            goalSelector.setTitle(title, forSegmentAt: index)
        }
        heightInputFieldHideFeetConstraint.isActive = false
        heightInputFieldShowFeetConstraint.isActive = true
    }
    
    func updateUIToMetricSystem() {
        heightUnitLabel.text = Constants.PersonalDetailsPage.centimeter
        weightUnitLabel.text = Constants.PersonalDetailsPage.kilo
        for index in 0..<goalSelector.numberOfSegments {
            var title = goalSelector.titleForSegment(at: index)
            title = title?.replacingOccurrences(of: Constants.PersonalDetailsPage.onePound,
                                                with: Constants.PersonalDetailsPage.halfKilo)
            goalSelector.setTitle(title, forSegmentAt: index)
        }
        heightInputFieldShowFeetConstraint.isActive = false
        heightInputFieldHideFeetConstraint.isActive = true
        inchesInputField.text = nil
        inchesInputField.isHidden = true
        feetLabel.isHidden = true
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

    private func setActivity(activity: User.ActivityLevel?) {
        guard let activity = activity else {
            selectedActivity = nil
            return
        }
        let activityString = activity.description
        activityButton.setTitle(activityString, for: .normal)
        selectedActivity = activity
    }
}
