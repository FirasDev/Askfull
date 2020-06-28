//
//  QuestionController.swift
//  Stackfull
//
//  Created by Firas Ben Mbarek on 22/06/2020.
//  Copyright © 2020 4SIM1. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class QuestionController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {

    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var category: UIPickerView!
    @IBOutlet weak var desc: UITextView!
    
    var pickerData: [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Connect data:
        self.category.delegate = self
        self.category.dataSource = self
        
        // Input the data into the array
        pickerData = ["Software", "Hardware", "Theoritcal", "Programming", "Gaming", "Other"]
    }
    

    
    @IBAction func add_question(_ sender: Any) {
        
        
        let parameters: [String: Any] = [
            "id" : ViewController.id,
            "title" : question.text,
            "category" : pickerData[category.selectedRow(inComponent: 0)],
            "img" : "question.jpg",
            "text": desc.text,
        ]

        var statusCode: Int = 0

          Alamofire.request(ViewController.port+"/addquestion", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON{ response in
                statusCode = (response.response?.statusCode)!
                print(statusCode)
                if(statusCode == 200){
                    let alertController = UIAlertController(title: "Success", message:
                        "Question added with success", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action: UIAlertAction!) in
                          print("Handle Ok logic here")
                        
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        let vc: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
                        vc.selectedIndex = 3
                        self.navigationController?.pushViewController(vc, animated: true)
                    }))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                }else{
                    let alertController = UIAlertController(title: "Warning", message:
                           "failed: Invalid Data", preferredStyle: .alert)
                       alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                       self.present(alertController, animated: true, completion: nil)
                }


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
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
}
