//
//  StepThreeController.swift
//  
//
//  Created by Firas Ben Mbarek on 20/06/2020.
//

import UIKit
import CountryPickerView

class StepThreeController: UIViewController , CountryPickerViewDelegate, CountryPickerViewDataSource{

    @IBOutlet weak var tf_phone: UITextField!
    //@IBOutlet weak var cpvMain: CountryPickerView!
    
    @IBOutlet weak var dp_date: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //cpvMain.delegate = self
        //cpvMain.dataSource = self
    }
    
    @IBAction func stepFourth(_ sender: Any) {
        self.performSegue(withIdentifier: "stepFourth", sender: self)
        
        /*  if(isValidNumber(testStr: tf_phone.text!)){
              self.performSegue(withIdentifier: "stepFourth", sender: self)
          }else{
              let alertController = UIAlertController(title: "Warning", message:
                  "Phone Number failed: Please check you input...", preferredStyle: .alert)
              alertController.addAction(UIAlertAction(title: "Ok", style: .default))

              self.present(alertController, animated: true, completion: nil)
          }*/
      }
      
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if (segue.identifier == "stepFourth"){
              let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "dd-MM-yyyy"
             let dateString = dateFormatter.string(from: dp_date.date)
              StepOneController.date_of_birth = dateString
              StepOneController.phone  = self.tf_phone.text!
              //StepOneController.country = self.cpvMain.selectedCountry.name
             }
         }
      
       func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {}

      func isValidNumber(testStr:String) -> Bool {
          let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
          let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
          return phoneTest.evaluate(with: testStr)
      }
      
      func isValid(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
      let allowedCharacters = CharacterSet.decimalDigits
      let characterSet = CharacterSet(charactersIn: string)
      return allowedCharacters.isSuperset(of: characterSet)
    }
    

}
