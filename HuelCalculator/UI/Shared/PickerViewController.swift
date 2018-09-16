//
//  PickerViewController.swift
//  HuelCalculator
//
//  Created by Linda on 20/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {
    
    private let animationTime: TimeInterval = 0.3
    private var selectedIndex: Int
    
    @IBOutlet private weak var background: UIView?
    @IBOutlet private weak var picker: UIPickerView? {
        didSet {
            picker?.delegate = self
            picker?.dataSource = self
            picker?.selectRow(selectedIndex, inComponent: 0, animated: false)
        }
    }
    
    @IBOutlet private weak var visibleConstraint: NSLayoutConstraint?
    @IBOutlet private weak var inVisibleConstraint: NSLayoutConstraint?
    
    private var closure: ((Pickable?) -> Void)?
    private var pickableType: Pickable.Type
    
    init(with type: Pickable.Type, index: Int, closure: ((Pickable?) -> Void)?) {
        selectedIndex = index
        self.closure = closure
        self.pickableType = type
        super.init(nibName: Constants.PersonalDetailsPage.pickerViewController, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialState()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doneButtonPressed))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeVisible()
    }
    
    @IBAction private func doneButtonPressed() {
        guard let index = picker?.selectedRow(inComponent: 0) else { return }
        let item = pickableType.itemAt(rawValue: index)
        closure?(item)
        makeInvisible()
    }
    
    @IBAction private func cancelButtonPressed() {
        makeInvisible()
    }
    
    private func makeVisible() {
        UIView.animate(withDuration: animationTime) {
            self.inVisibleConstraint?.isActive = false
            self.visibleConstraint?.isActive = true
            self.background?.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func makeInvisible() {
        UIView.animate(withDuration: animationTime, animations: {
            self.setInitialState()
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    private func setInitialState() {
        visibleConstraint?.isActive = false
        inVisibleConstraint?.isActive = true
        background?.alpha = 0
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickableType.itemCount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickableType.itemAt(rawValue: row)?.description
    }
}
