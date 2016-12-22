//
//  ActivityPickerViewController.swift
//  HuelCalculator
//
//  Created by Linda on 20/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit

class ActivityPickerViewController: UIViewController {
    
    typealias SelectionClosure = (User.ActivityLevel?, Int) -> ()
    
    private let animationTime: TimeInterval = 0.3
    private var selectedIndex: Int
    
    @IBOutlet private weak var background: UIView?
    @IBOutlet private weak var picker: UIPickerView?
    
    @IBOutlet private weak var visibleConstraint: NSLayoutConstraint?
    @IBOutlet private weak var inVisibleConstraint: NSLayoutConstraint?
    
    private var selectionCallback: SelectionClosure?
    
    init(index: Int) {
        selectedIndex = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialState()
        picker?.delegate = self
        picker?.dataSource = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ActivityPickerViewController.doneButtonPressed))
        view.addGestureRecognizer(tap)
        picker?.selectRow(selectedIndex, inComponent: 0, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeVisible()
    }
    
    func set(selectionCallback: SelectionClosure?) {
        self.selectionCallback = selectionCallback
    }
    
    @IBAction private func doneButtonPressed() {
        guard let value = picker?.selectedRow(inComponent: 0) else {
            return
        }
        
        let activityLevel = User.ActivityLevel(rawValue: value)
        selectionCallback?(activityLevel, value)
        makeInvisible()
    }
    @IBAction func cancelButtonPressed() {
        makeInvisible()
    }
    
    private func makeVisible() {
        UIView.animate(withDuration: animationTime, animations: {
            self.inVisibleConstraint?.isActive = false
            self.visibleConstraint?.isActive = true
            self.background?.alpha = 1
            self.view.layoutIfNeeded()
        })
    }
    
    private func makeInvisible() {
        UIView.animate(withDuration: animationTime, animations: {
            self.setInitialState()
            self.view.layoutIfNeeded()
        }, completion: { (Bool) in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    private func setInitialState() {
        self.visibleConstraint?.isActive = false
        self.inVisibleConstraint?.isActive = true
        self.background?.alpha = 0
    }
}

extension ActivityPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return User.ActivityLevel.count.rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        guard let activityValue = User.ActivityLevel(rawValue: row) else {
            return UILabel()
        }
        
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Montserrat", size: 15)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        pickerLabel?.text = User.ActivityLevel.getActivityString(activity: activityValue)
        
        return pickerLabel ?? UILabel()
    }
    
}
