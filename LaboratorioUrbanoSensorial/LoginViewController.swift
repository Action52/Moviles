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
    
    var inter: String?
    var numInter: Int?

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        if dataTask != nil {
            dataTask?.cancel()
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let usernameStr = username.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let passwordStr = password.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    //validation GET
        let url = URL(string: "https://laboratorio-db.herokuapp.com/users?username=" + usernameStr! )
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { //request para post
            (dataN, _, _) in DispatchQueue.main.async{
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            guard let dataN = dataN else { return }
            do{
                let users = try JSONDecoder().decode([User].self, from: dataN)
                for user in users{
                    if(user.password != passwordStr){
                        DispatchQueue.main.async{
                            self.showResult()
                        }
                    }
                    else{
                        //PUT USER
                        let aumentar = (user.numEntrevistas+1)
                        let userNam = user.username
                        let userNom = user.nombre
                        let pass = user.password
                        let urlGet = URL(string: "https://laboratorio-db.herokuapp.com/users/" + String(user.id))
                        var requestGet = URLRequest(url: urlGet!)
                        requestGet.httpMethod = "PUT"
                        requestGet.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        let postDictionary = ["numEntrevistas": aumentar, "username": userNam, "password": pass, "nombre": userNom] as [String : Any]
                        do{
                            let jsonHead = try JSONSerialization.data(withJSONObject: postDictionary, options: [])
                            requestGet.httpBody = jsonHead
                        }catch{}
                        let sessionGet = URLSession.shared
                        let taskGet = sessionGet.dataTask(with: requestGet) {
                            (data, _, _) in DispatchQueue.main.async{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                            guard let data = data else { return }
                            do{
                                let json = try JSONSerialization.jsonObject(with: data, options: [])
                            }catch{}
                        }
                        taskGet.resume()
                        //GET USER UPDATED
                        let urlAct = URL(string: "https://laboratorio-db.herokuapp.com/users?username=" + usernameStr! )
                        let sessionAct = URLSession.shared
                        let taskAct = sessionAct.dataTask(with: urlAct!) {
                            (dataG, _, _) in DispatchQueue.main.async{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                            guard let dataG = dataG else { return }
                            do{
                                let actors = try JSONDecoder().decode([User].self, from: dataG)
                        for act in actors{
                                    
                        //POST
                        let entrevistador = act.nombre
                        let num = act.numEntrevistas
                         DispatchQueue.main.async {
                            self.changeValue(entrevistador: entrevistador, num: num)
                        }
                        let urlPost = URL(string: "https://laboratorio-db.herokuapp.com/interviewed")
                        var request = URLRequest(url: urlPost!)
                        request.httpMethod = "POST"
                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        let newPost = PostNo(Entrevistador: entrevistador, numEntrevistas: act.numEntrevistas, LocalidadEntrevistado: "", OcupacionEntrevistado: "", GeneroEntrevistado: "", RangoEdadEntrevistado: "", LimpiezaCalificacion: 0, LimpiezaImagen: 0, LimpiezaColor: 0, LimpiezaMejoramiento: "", MobiliarioCalificacion: 0, MobiliarioImagen: 0, MobiliarioColor: 0, MobiliarioMejoramiento: "", RuidoCalificacion: 0, RuidoImagen: 0, RuidoColor: 0, RuidoMejoramiento: "", SeguridadCalificacion: 0, SeguridadImagen: 0, SeguridadColor: 0, SeguridadMejoramiento: "", NaturalezaCalificacion: 0, NaturalezaImagen: 0, NaturalezaColor: 0, NaturalezaMejoramiento: "")
                        do{
                            let jsonBody = try JSONEncoder().encode(newPost)
                            request.httpBody = jsonBody
                        } catch{}
                        let sessionPost = URLSession.shared
                        let taskPost = sessionPost.dataTask(with: request) {
                            (data, _, _) in DispatchQueue.main.async{
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                            guard let data = data else { return }
                            do{
                                let json = try JSONSerialization.jsonObject(with: data, options: [])
                            }catch{}
                        }
                        taskPost.resume()
                        //FIN DEL POST
                        
                                }
                            }catch{}
                        }
                        taskAct.resume()
                        //CAMBIO DE VIEWCONTROLLER
                        DispatchQueue.main.async{
                            self.changeView()
                        }
                        
                    } // Fin else
                } // Fin users
            }catch{} //Fin fo
        } // Fin Task
        task.resume()
    }
    
    func changeValue(entrevistador: String, num: Int) {
        self.inter = entrevistador
        self.numInter = num
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
        let DestViewController = segue.destination as! SecondViewController
        DestViewController.interviewed = "LuisFlores"
        DestViewController.numEnt = 2
    }
    
}

