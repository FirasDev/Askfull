//
//  StepFourController.swift
//  
//
//  Created by Firas Ben Mbarek on 20/06/2020.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class StepFourController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var pic_speciality: UIPickerView!
    @IBOutlet weak var pic_reasons: UIPickerView!
    
    var pickerDataSpeciality: [String] = [String]()
    var pickerDataReasons: [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pic_speciality.tag = 1
        pic_reasons.tag = 2
        // Connect data:
               self.pic_speciality.delegate = self
               self.pic_speciality.dataSource = self
        
        // Connect data:
               self.pic_reasons.delegate = self
               self.pic_reasons.dataSource = self

        
        // Input the data into the array
               pickerDataSpeciality = ["Student", "Teacher","Other"]
        // Input the data into the array
               pickerDataReasons = ["Learn", "Teach", "Both", "Other"]
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func home(_ sender: Any) {
        StepOneController.speciality = pickerDataSpeciality[pic_speciality.selectedRow(inComponent: 0)]
        StepOneController.reason = pickerDataReasons[pic_reasons.selectedRow(inComponent: 0)]
         print(StepOneController.date_of_birth)
         print(StepOneController.country)
         print(StepOneController.reason)
        print(StepOneController.speciality)
        
        var gender = 0;
        if (StepOneController.gender == "Male"){
            gender = 0;
        }else {
            gender = 1;
        }
        
        let parameters: [String: Any] = [
            "email" : StepOneController.email,
            "password" : StepOneController.password,
            "fname" : StepOneController.fname,
            "lname" : StepOneController.lname,
            "gender" : gender,
            "country" : StepOneController.country,
            "birth_date" : StepOneController.date_of_birth,
            "specialty" : StepOneController.speciality,
            "reason" : StepOneController.reason
            
        ]
        var statusCode: Int = 0
        
        Alamofire.request(ViewController.port+"/register", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON{ response in
                statusCode = (response.response?.statusCode)!
                print(statusCode)
                if(statusCode == 201){
                    self.performSegue(withIdentifier: "home", sender: self)
                }else{
                    let alertController = UIAlertController(title: "Warning", message:
                           "Invalid data", preferredStyle: .alert)
                       alertController.addAction(UIAlertAction(title: "Ok", style: .default))

                       self.present(alertController, animated: true, completion: nil)
                }

                
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "home"){
            ViewController.session = StepOneController.email
        }
    }
    
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }

       // Number of columns of data
       func numberOfComponents(in pickerView: UIPickerView)-> Int {
           return 1
       }
       
       // The number of rows of data
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)->Int {
         if pickerView.tag == 1 {
                return pickerDataSpeciality.count
            } else {
                return pickerDataReasons.count
            }
       }
       
       // The data to return fopr the row and component (column) that's being passed in
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView.tag == 1 {
                return pickerDataSpeciality[row]
                
            } else {
                return pickerDataReasons[row]
            }
           
       }

}
