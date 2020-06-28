//
//  StepTwoController.swift
//  
//
//  Created by Firas Ben Mbarek on 20/06/2020.
//

import UIKit

class StepTwoController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var tf_fname: UITextField!
    @IBOutlet weak var tf_lname: UITextField!
    @IBOutlet weak var pic_gender: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Connect data:
        self.pic_gender.delegate = self
        self.pic_gender.dataSource = self
        
        // Input the data into the array
        pickerData = ["Male", "Female"]

        // Do any additional setup after loading the view.
    }
    

    @IBAction func stepThree(_ sender: Any) {
        
        if(isValidName(testStr: tf_fname.text!) ){
            if(isValidName(testStr: tf_lname.text!)){
                self.performSegue(withIdentifier: "stepThree", sender: self)
              
            }else{
                let alertController = UIAlertController(title: "Warning", message:
                    "Last Name failed: Please check you input...", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default))

                self.present(alertController, animated: true, completion: nil)
            }
        }else{
            let alertController = UIAlertController(title: "Warning", message:
                   "First Name failed: Please check you input...", preferredStyle: .alert)
               alertController.addAction(UIAlertAction(title: "Ok", style: .default))

               self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stepThree"){
            StepOneController.fname = self.tf_fname.text!
            StepOneController.lname  = self.tf_lname.text!
            StepOneController.gender = pickerData[pic_gender.selectedRow(inComponent: 0)]
        }
    }
    
    
    func isValidName(testStr:String) -> Bool {
        guard testStr.count > 4, testStr.count < 22 else { return false }

        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
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
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
