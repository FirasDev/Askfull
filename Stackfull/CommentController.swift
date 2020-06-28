//
//  CommentController.swift
//  Stackfull
//
//  Created by Firas Ben Mbarek on 28/06/2020.
//  Copyright © 2020 4SIM1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CommentController:   UIViewController,UITableViewDelegate,UITableViewDataSource  {

    var arr_date = [String]()
    var arr_questiondesc = [String]()
    var arr_usernames = [String]()
    var arr_ids = [String]()
    var id = ViewController.id
    var qId = ArticleController.myid
    
    @IBOutlet weak var mytableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(ViewController.session)
        self.mytableview.delegate = self
        self.mytableview.dataSource = self
         getData();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_questiondesc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableview.dequeueReusableCell(withIdentifier: "mycell")
        let contentView = cell?.viewWithTag(1)
        let date = contentView?.viewWithTag(6) as! UILabel
        let desc = contentView?.viewWithTag(3) as! UITextView
        let username = contentView?.viewWithTag(5) as! UILabel
      
        date.text = arr_date[indexPath.row]
        desc.text = arr_questiondesc[indexPath.row]
        username.text = arr_usernames[indexPath.row]
        
        return cell!
    }
    
    func getData()
    {
        Alamofire.request(ViewController.port+"/getreponses/"+qId+"/"+id).responseString { (response) in

            let myresult = try? JSON(data: response.data!)
            

        self.arr_date.removeAll()
        self.arr_questiondesc.removeAll()
        self.arr_usernames.removeAll()
            self.arr_ids.removeAll()
            
            for i in myresult!.arrayValue  {
                let type = i["type"].stringValue
                if (type == "1"){
                    let date = i["date_create"].stringValue
                    self.arr_date.append(date)
                    
                    let questionDesc = i["text"].stringValue
                    self.arr_questiondesc.append(questionDesc)
                    let  fullname = i["firstname"].stringValue + " " + i["lastname"].stringValue
                    
                    self.arr_usernames.append(fullname)
                    let idNum = i["id"].stringValue
                    self.arr_ids.append(idNum)
                }
            }
            self.mytableview.reloadData()
           }
    }
    

   

}
