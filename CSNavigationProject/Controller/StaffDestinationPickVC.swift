//
//  StaffDestinationPickVC.swift
//  CSNavigationProject
//
//  Created by Matthew Soh on 9/4/23.
//

import UIKit

class StaffDestinationPickVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var textFieldDisplay: UITextField!
    @IBOutlet weak var textField: UITextField!
    
    let pickerView = UIPickerView()
    var chosenStaffRoom = "Art"
    let departments = ["Art", "Computer Science", "Dance", "DT", "Food and Nutrition", "Drama", "English", "Film Studies", "Business Studies", "Economics", "Geography", "History", "Languages", "Mathematics", "Music", "Physical Education", "Science"]
    
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
        textField.resignFirstResponder()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return departments.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return departments[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenStaffRoom = departments[row]
        textFieldDisplay.text = chosenStaffRoom
        switch chosenStaffRoom {
            case "Computer Science", "DT", "Food and Nutrition", "English", "Geography", "History", "Mathematics", "Science":
                view.backgroundColor = UIColor.systemRed
            case "Art", "Dance", "Drama", "Film Studies", "Music":
                view.backgroundColor = UIColor.orange
        default:
            break
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? StaffRoomVC {
            vc.chosenStaffRoom = chosenStaffRoom
//            vc.currentClassroomChanged = false
        }
        if let vc = segue.destination as? StaffCurrentLocationPickVC {
            vc.destinationStaffRoom = departments[pickerView.selectedRow(inComponent: 0)]
        }
    }
    
    @IBAction func unwindFromVCStaffRoomCurrentLocationOrVCStaffRoomDisplay(unwindSegue: UIStoryboardSegue) {
        
    }
}
