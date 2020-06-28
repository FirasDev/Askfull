//
//  ViewController.swift
//  Stackfull
//
//  Created by Firas Ben Mbarek on 16/04/2020.
//  Copyright © 2020 4SIM1. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var loginBackBtn: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    static var session = ""
    static var id = ""
    static var port =  "http://askfullpp.eu-4.evennode.com"
    
    
    @IBAction func tappedLoginButton(_ sender: UIButton) {
        print("Tapped login btn")
        
        let parameters: [String: Any] = [
            "email" : emailTextField.text,
            "password" : passwordTextField.text
        ]
        var statusCode: Int = 0
        
        Alamofire.request(ViewController.port+"/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON{ response in
                statusCode = (response.response?.statusCode)!
                print(statusCode)
                let myresult = try? JSON(data: response.data!)
                if(statusCode == 201){
                   
                    print(myresult);
                    let name = myresult!["id"].stringValue
                    ViewController.id = name
                    print(ViewController.id)
                    
                    self.performSegue(withIdentifier: "login", sender: self)
                }else{
                    let alertController = UIAlertController(title: "Warning", message:
                           "Login failed: Invalid username or password", preferredStyle: .alert)
                       alertController.addAction(UIAlertAction(title: "Ok", style: .default))

                       self.present(alertController, animated: true, completion: nil)
                }

                
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailTextField.becomeFirstResponder()
        
        emailTextField.rx.text.map{ $0 ?? "" }.bind(to: loginViewModel.emailPublishSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.map{ $0 ?? "" }.bind(to: loginViewModel.passwordPublishSubject).disposed(by: disposeBag)
        
        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map{ $0 ? 1 : 0.3}.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "login"){
            ViewController.session = self.emailTextField.text!
            //var vc = segue.destination as! HomeController
            //vc.username = self.username
            
        }
    }
    
}



class LoginViewModel{
    
    let emailPublishSubject = PublishSubject<String>()
    let passwordPublishSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(emailPublishSubject.asObservable().startWith(""),
            passwordPublishSubject.asObservable().startWith("")).map {
                email,password in
                return email.count > 8 && password.count > 5
        }.startWith(false)
    }
}

