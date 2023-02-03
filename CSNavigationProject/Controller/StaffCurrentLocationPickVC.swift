//
//  StaffCurrentLocationPickVC.swift
//  CSNavigationProject
//
//  Created by Matthew Soh on 22/4/23.
//

import UIKit

class StaffCurrentLocationPickVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldDisplay: UITextField!
    
    let pickerView = UIPickerView()
    let buildings = ["Senior School", "Junior School", "Performing Arts"]
    var floors = ["1","2","3","4","5","6"]
    var classrooms = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10"]
    var buildingAbbreviations = ["SS", "JS", "PA"]
    var buildingClassrooms = [
        [
            ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10"],
            ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10"],
            ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10"],
            ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10"],
            ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10"],
            ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10"],
        ],
        [
            ["01", "02", "03", "04", "05", "06", "07", "08", "09"],
        ],
        [
            ["01", "02", "03", "04", "05", "06", "07", "08", "09"],
            ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10"],
            ["01 (Art Department Office)", "02", "03", "04", "05", "06", "07", "08", "09", "10", "20 (Music Department Office)"]
        ]
    ]
    var departmentLocations: [String : [Any]] = ["Art": [2, 2, 0], "Music": [2, 2, 10]]
    var chosenStaffRoom: String!
    var destinationStaffRoom: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let destinationStaffRoomInfo = departmentLocations[destinationStaffRoom]
        buildingClassrooms[destinationStaffRoomInfo![0] as! Int][destinationStaffRoomInfo![1] as! Int].remove(at: destinationStaffRoomInfo![2] as! Int)
        chosenStaffRoom = "SS1-" + classrooms[0]
        textFieldDisplay.text = chosenStaffRoom
        
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
        // let buildingIndex = pickerView.selectedRow(inComponent: 0)
        // let floorIndex = pickerView.selectedRow(inComponent: 1)
        // let classroomIndex = pickerView.selectedRow(inComponent: 2)
        // let selectedBuilding = buildingAbbreviations[buildingIndex]
        // let selectedFloor = floors[floorIndex]
        // let selectedClassroom = classrooms[classroomIndex]
        textField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return buildings.count
        }else if component == 1 {
            return floors.count
        }else {
            return classrooms.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return buildings[row]
        } else if component == 1 {
            return floors[row]
        } else {
            return classrooms[row]
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
                    floors = ["1", "2", "3"]
                    view.backgroundColor = UIColor.orange
            default:
                break
            }
            pickerView.selectRow(0, inComponent: 1, animated: false)
            pickerView.selectRow(0, inComponent: 2, animated: false)
            
            let floorIndex = pickerView.selectedRow(inComponent: 1)
            classrooms = buildingClassrooms[row][floorIndex]
            
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
        } else if component == 1 {
            
            pickerView.selectRow(0, inComponent: 2, animated: false)
            
            let buildingIndex = pickerView.selectedRow(inComponent: 0)
            classrooms = buildingClassrooms[buildingIndex][row]
            
            pickerView.reloadComponent(2)
        }
        let buildingIndex = pickerView.selectedRow(inComponent: 0)
        let floorIndex = pickerView.selectedRow(inComponent: 1)
        let classroomIndex = pickerView.selectedRow(inComponent: 2)
//            chosenLevel = buildingAbbreviations[buildingIndex] + String(floorIndex+1) + "-" +
//            pickerView.reloadComponent(1)
        chosenStaffRoom = buildingAbbreviations[buildingIndex] + floors[floorIndex] + "-" + classrooms[classroomIndex]
        textFieldDisplay.text = chosenStaffRoom

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? StaffRoomVC {
            vc.currentStaffRoom = chosenStaffRoom
            vc.currentLocationChanged = true
        }
    }

    @IBAction func unwindFromVCStaffRoomDisplay(unwindSegue: UIStoryboardSegue){
        
    }

}
