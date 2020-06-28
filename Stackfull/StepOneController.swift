//
//  StepOneController.swift
//  
//
//  Created by Firas Ben Mbarek on 20/06/2020.
//

import UIKit

class StepOneController: UIViewController {

    @IBOutlet weak var email_tf: UITextField!
    @IBOutlet weak var password_tf: UITextField!
    @IBOutlet weak var confirmPass_tf: UITextField!
    
    static var email = ""
    static var password = ""
    static var fname = ""
    static var lname = ""
    static var gender = "Male"
    static var phone = ""
    static var country = "Tunisie"
    static var reason = "13 reasons why"
    static var speciality = "Dev"
    static var date_of_birth = "09-03-1991"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func stepTwo(_ sender: Any) {
        print("1");
        if(isValidEmailAddress(emailAddressString: email_tf.text!)){
            print("2");
            if(password_tf.text == confirmPass_tf.text){
                print("3");
                if(password_tf.text?.count ?? 0 >= 8 ){
                    print("4");
                    self.performSegue(withIdentifier: "stepTwo", sender: self)
                }else{
                    let alertController = UIAlertController(title: "Warning", message:
                           "Password failed: Passwor lenght less than 8", preferredStyle: .alert)
                       alertController.addAction(UIAlertAction(title: "Ok", style: .default))

                       self.present(alertController, animated: true, completion: nil)
                }
                
            }else{
                let alertController = UIAlertController(title: "Warning", message:
                       "Password failed: Passcords not match please verify", preferredStyle: .alert)
                   alertController.addAction(UIAlertAction(title: "Ok", style: .default))

                   self.present(alertController, animated: true, completion: nil)
            }
            
        }else{
            let alertController = UIAlertController(title: "Warning", message:
                   "Email failed: Invalid Email Format", preferredStyle: .alert)
               alertController.addAction(UIAlertAction(title: "Ok", style: .default))

               self.present(alertController, animated: true, completion: nil)
        }
    }
    
    /*@IBAction func stepTwo(_ sender: Any) {
        print("1");
        if(isValidEmailAddress(emailAddressString: email_tf.text!)){
            print("2");
            if(password_tf.text == confirmPass_tf.text){
                print("3");
                if(password_tf.text?.count ?? 0 >= 8 ){
                    print("4");
                    self.performSegue(withIdentifier: "stepTwo", sender: self)
                }else{
                    let alertController = UIAlertController(title: "Warning", message:
                           "Password failed: Passwor lenght less than 8", preferredStyle: .alert)
                       alertController.addAction(UIAlertAction(title: "Ok", style: .default))

                       self.present(alertController, animated: true, completion: nil)
                }
                
            }else{
                let alertController = UIAlertController(title: "Warning", message:
                       "Password failed: Passcords not match please verify", preferredStyle: .alert)
                   alertController.addAction(UIAlertAction(title: "Ok", style: .default))

                   self.present(alertController, animated: true, completion: nil)
            }
            
        }else{
            let alertController = UIAlertController(title: "Warning", message:
                   "Email failed: Invalid Email Format", preferredStyle: .alert)
               alertController.addAction(UIAlertAction(title: "Ok", style: .default))

               self.present(alertController, animated: true, completion: nil)
        }
        
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "stepTwo"){
                StepOneController.email = self.email_tf.text!
                StepOneController.password  = self.password_tf.text!
            }
        }
        
        
          func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }

}
