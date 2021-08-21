//
//  scanPrepViewController.swift
//  sFlora
//
//  Created by Aditya Mittal on 8/11/21.
//

import UIKit

class scanPrepViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    var image = UIImage()

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var img3: UIImageView!
    
    @IBOutlet weak var camButton: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    var selectedPlant = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = selectedPlant
        
        view1.layer.cornerRadius = 10
        img1.layer.cornerRadius = 10
        
        view2.layer.cornerRadius = 10
        img2.layer.cornerRadius = 10
        
        view3.layer.cornerRadius = 10
        img3.layer.cornerRadius = 10
        
        camButton.layer.cornerRadius = 10
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backHome", sender: self)
    }
    
    @IBAction func camPressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = userPickedImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        performSegue(withIdentifier: "goToFinal", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToFinal") {
            let displayVC = segue.destination as! finalViewController
            displayVC.image = image
            displayVC.selectedPlant = selectedPlant
        }
    }
    
}
