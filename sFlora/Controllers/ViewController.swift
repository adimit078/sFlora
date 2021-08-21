//
//  ViewController.swift
//  sFlora
//
//  Created by Aditya Mittal on 8/9/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var plantsScanned = Int16()
    
    var plantOptions = ["Apple","Bell Pepper","Blueberry","Cherry","Corn","Grape","Orange","Peach","Potato","Raspberry","Soybean","Sqaush","Strawberry","Tomato"]
    var selectedplant = String()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plantOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return plantOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedplant = plantOptions[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scanButton.layer.cornerRadius = 25
        pickerView.layer.cornerRadius = 30
                
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    @IBAction func scanPressed(_ sender: UIButton) {
        if selectedplant != "Other" {
            self.performSegue(withIdentifier: "goToScan", sender: self)
        } else {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToScan") {
            let displayVC = segue.destination as! scanPrepViewController
            displayVC.selectedPlant = selectedplant
        }
    }
    
}

