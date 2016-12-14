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
    @IBOutlet var activityInputField: UITextField!
    @IBOutlet var goalInputField: UITextField!
    @IBOutlet var calculateButton: UIButton!
    
    private let presenter = PersonalDetailsPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.set(view: self)
    }
    
    @IBAction func resetButtonPressed() {
        presenter.didPressResetButton()
    }
    
    func resetAllFields() {
        measurementSystemSelector.selectedSegmentIndex = 0
        ageInputField.text = ""
        genderSelector.selectedSegmentIndex = 0
        goalInputField.text = ""
        heightInputField.text = ""
        weightInputField.text = ""
        activityInputField.text = ""
        goalInputField.text = ""
    }
}
