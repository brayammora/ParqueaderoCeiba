//
//  ParkingVehicleViewController.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 23/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import UIKit

class ParkingVehicleViewController: UIViewController {
    
    @IBOutlet weak var vehicleTypePicker: UIPickerView!
    @IBOutlet weak var numberPlateTextField: UITextField!
    @IBOutlet weak var ccTextField: UITextField!
    
    var viewModel: ParkingVehicleViewModel?
    let sceneDelegate = SceneDelegate()
    
    init(withViewModel viewModel: ParkingVehicleViewModel) {
        super.init(nibName: "ParkingVehicle", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupTypePicker()
        setupTextFields()
    }
    
    private func setupNavbar() {
        self.navigationItem.title = viewModel!.navigationTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(callAddVehicle))
    }
    
    @objc private func callAddVehicle() {
        if numberPlateTextField.text != "" && ccTextField.text != "" {
            let numberPlate = numberPlateTextField.text!
            let cc = ccTextField.text!
            let type = viewModel!.pickerOptions[vehicleTypePicker.selectedRow(inComponent: 0)]
            
            if cc.isNumber() {
                viewModel?.allowEntryVehicle(numberPlate, cc, type)
                
                let alert = UIAlertController(title: "Alert!", message: viewModel?.message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                ccTextField.layer.borderColor = UIColor.red.cgColor
                ccTextField.layer.borderWidth = 1.0
                ccTextField.resignFirstResponder()
            }
            
        } else {
            let alert = UIAlertController(title: "Alert!", message: viewModel?.messageMandatoryFields, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func setupTypePicker() {
        vehicleTypePicker.delegate = self
        vehicleTypePicker.dataSource = self
    }
    
    private func setupTextFields() {
        ccTextField.delegate = self
        numberPlateTextField.delegate = self
    }
    
}

extension ParkingVehicleViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel!.pickerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel!.pickerOptions[row]
    }
}

extension String {
    func isNumber() -> Bool {
        return NumberFormatter().number(from: self) != nil
    }
}

extension ParkingVehicleViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == ccTextField {
            ccTextField.layer.borderColor = .none
            ccTextField.layer.borderWidth = 0
        }
    }
}

extension ParkingVehicleViewController: UIPickerViewDelegate {
}

