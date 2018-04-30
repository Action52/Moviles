//
//  ViewController.swift
//  LaboratorioUrbanoSensorial
//
//  Created by Luis Alfredo León Villapún on 20/04/18.
//  Copyright © 2018 Luis Alfredo León Villapún. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let defaultSession = URLSession(configuration: .default)
    var dataTask : URLSessionDataTask?

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        if dataTask != nil {
            dataTask?.cancel()
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let usernameStr = username.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let passwordStr = password.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://laboratorio-db.herokuapp.com/users?username=" + usernameStr! )
        
        /*let url = NSURL(string: + usernameStr! + "&password=" + passwordStr!)*/
        /*var request = URLRequest(url: url!)
         //request.httpMethod = "GET"
         //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         //let postDictionary = ["username": "mike3Run",
         "password": "passwordStr",
         "nombre": "Miguel Palau"]
         
         do{
         let jsonBody = try JSONSerialization.data(withJSONObject: postDictionary, options: [])
         request.httpBody = jsonBody
         } catch{}*/
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { //request para post
            (data, _, _) in DispatchQueue.main.async{
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            guard let data = data else { return }
            do{
                let users = try JSONDecoder().decode([User].self, from: data)
                for user in users{
                    //print(user.password)
                    if(user.password != passwordStr){
                        DispatchQueue.main.async{
                            self.showResult()
                        }
                    }
                    else{
                        DispatchQueue.main.async{
                            self.changeView()
                        }
                    }
                }
            }catch{}
        }
        task.resume()
    }
    
    func showResult(){
        let str = "Wrong Password or Username"
        let alert = UIAlertController(title: "Server Response", message: str, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func changeView(){
        performSegue(withIdentifier: "segue", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //if segue.identifier == "showInterviewLengthController"{
        //}
    }


}

