//
//  PickFloorMapVC.swift
//  CSNavigationProject
//
//  Created by Matthew Soh on 5/2/23.
//
import UIKit

class PickFloorMapVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
//    @IBOutlet weak var textFieldDisplay: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldDisplay: UITextField!
    
    let pickerView = UIPickerView()
    let buildings = ["Senior School", "Junior School", "Performing Arts"]
    var floors = ["1", "2", "3", "4", "5", "6"]
    var buildingAbbreviations = ["SS", "JS", "PA"]
    var chosenLevel = "SS1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        textField.inputView = pickerView
        textField.tintColor = UIColor.clear
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
    }
    
    @IBAction func textFieldTapped(_ sender: Any) {
        textField.becomeFirstResponder()
    }
    
    @objc func doneButtonTapped() {
////        let chosenImage = chosenLevel+"FloorMap"
//        let buildingIndex = pickerView.selectedRow(inComponent: 0)
//        let floorIndex = pickerView.selectedRow(inComponent: 1)
//        let selectedBuilding = buildingAbbreviations[buildingIndex]
//        let selectedFloor = floors[floorIndex]
        
        textField.resignFirstResponder()
//        textField.resignFirstResponder()
//        return chosenImage
//        return "
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return buildings.count
        } else {
            return floors.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return buildings[row]
        } else {
            print(row)
            return floors[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            switch buildings[row] {
            case "Senior School":
                floors = ["1", "2", "3", "4", "5", "6"]
                view.backgroundColor = UIColor.systemRed
            case "Junior School":
                floors = ["3"]
                view.backgroundColor = UIColor.blue
            case "Performing Arts":
                floors = ["1", "2", "3", "4"]
                view.backgroundColor = UIColor.orange
            default:
                break
            }
            pickerView.selectRow(0, inComponent: 1, animated: false)
            pickerView.reloadComponent(1)
        }
        let buildingIndex = pickerView.selectedRow(inComponent: 0)
        let floorIndex = pickerView.selectedRow(inComponent: 1)
        chosenLevel = buildingAbbreviations[buildingIndex] + floors[floorIndex]
        textFieldDisplay.text = chosenLevel
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FloorMapVC{
            vc.chosenFloor = chosenLevel
        }
    }
    
    @IBAction func unwindFromVCFloorMapDisplay(unwindSegue: UIStoryboardSegue) {
        
    }
}
