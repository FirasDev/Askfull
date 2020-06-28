//
//  HomeController.swift
//  Stackfull
//
//  Created by Firas Ben Mbarek on 20/06/2020.
//  Copyright © 2020 4SIM1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    var arr_questiontitle = [String]()
    var arr_questiondesc = [String]()
    var arr_usernames = [String]()
    var arr_ids = [String]()
    
    
    @IBOutlet weak var mytableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ViewController.session)
       self.mytableview.delegate = self
       self.mytableview.dataSource = self
        getData();

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_questiontitle.count
    }
    
    
    func getData()
    {
        Alamofire.request(ViewController.port+"/allquestions").responseString { (response) in

            let myresult = try? JSON(data: response.data!)
            

        self.arr_questiontitle.removeAll()
        self.arr_questiondesc.removeAll()
        self.arr_usernames.removeAll()
            self.arr_ids.removeAll()
            
            for i in myresult!.arrayValue  {
                print("x");
                let questionTitle = i["title"].stringValue
                self.arr_questiontitle.append(questionTitle)
                let questionDesc = i["text"].stringValue
                self.arr_questiondesc.append(questionDesc)
                let  fullname = i["firstname"].stringValue + " " + i["lastname"].stringValue
                
                self.arr_usernames.append(fullname)
                let idNum = i["id"].stringValue
                self.arr_ids.append(idNum)
            }
            self.mytableview.reloadData()
           }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableview.dequeueReusableCell(withIdentifier: "mycell")
        let contentView = cell?.viewWithTag(1)
        let title = contentView?.viewWithTag(2) as! UILabel
        let desc = contentView?.viewWithTag(3) as! UITextView
        let username = contentView?.viewWithTag(5) as! UILabel
      
        title.text = arr_questiontitle[indexPath.row]
        desc.text = arr_questiondesc[indexPath.row]
        username.text = arr_usernames[indexPath.row]
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier:"article", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier == "article"){
            let indexPath = sender as! IndexPath
        let indice = indexPath.row
        let dvc = segue.destination as! ArticleController
            dvc.titre = arr_questiontitle[indice]
            dvc.name = arr_usernames[indice]
            dvc.myDescription = arr_questiondesc[indice]
            ArticleController.myid = arr_ids[indice]
        
        }
    }

}
