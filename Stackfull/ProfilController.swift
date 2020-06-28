//
//  ProfilController.swift
//  Stackfull
//
//  Created by Firas Ben Mbarek on 22/06/2020.
//  Copyright © 2020 4SIM1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfilController: UIViewController {

    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var nbr_questions: UILabel!
    @IBOutlet weak var nb_answers: UILabel!
    @IBOutlet weak var nb_comments: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()

        // Do any additional setup after loading the view.
    }
    

   func getData()
   {
   
    var statusCode: Int = 0
    Alamofire.request(ViewController.port+"/getUserInfo/"+ViewController.id).responseString { (response) in

        statusCode = (response.response?.statusCode)!
           let myresult = try? JSON(data: response.data!)
           
           if(statusCode == 200){
              
               print(myresult);
            let fname = myresult!["firstname"].stringValue
            let lname = myresult!["lastname"].stringValue
            self.fullname.text = fname + " " + lname
            self.country.text = myresult!["country"].stringValue
            self.phone.text = myresult!["phone"].stringValue
            self.nbr_questions.text = myresult!["question"].stringValue
            self.nb_answers.text = myresult!["reponse"].stringValue
            self.nb_comments.text = myresult!["comment"].stringValue
               
               
           }else{
               let alertController = UIAlertController(title: "Warning", message:
                      "Could not get Data from server", preferredStyle: .alert)
                  alertController.addAction(UIAlertAction(title: "Ok", style: .default))

                  self.present(alertController, animated: true, completion: nil)
           }
          }
   }

}
