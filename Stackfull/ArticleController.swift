//
//  ArticleController.swift
//  Stackfull
//
//  Created by Firas Ben Mbarek on 23/06/2020.
//  Copyright © 2020 4SIM1. All rights reserved.
//

import UIKit

class ArticleController: UIViewController {

    @IBOutlet weak var fullname: UILabel!
   
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var desc: UITextView!
     static var  myid = ""
     var  name = ""
     var  titre = ""
     var  myDescription = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fullname.text = name
        myTitle.text = titre
        desc.text = myDescription
    }
    

    @IBAction func add_reponse(_ sender: Any) {
        
    }
    

}
