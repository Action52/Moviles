//
//  InterviewSubjectInfoViewController.swift
//  LaboratorioUrbanoSensorial
//
//  Created by Luis Alfredo León Villapún on 25/04/18.
//  Copyright © 2018 Luis Alfredo León Villapún. All rights reserved.
//

import UIKit

class InterviewSubjectInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask : URLSessionDataTask?
    var selectedGenderIndex = 0
    var selectedAgeIndex = 0
    var inter: String!
    var numEnt: Int!
    
    @IBOutlet weak var pickerViewAge: UIPickerView!
    @IBOutlet weak var pickerViewGender: UIPickerView!
    @IBOutlet weak var localidad: UITextField!
    @IBOutlet weak var ocupacion: UITextField!
    
    let pickerAgeData = ["10-20 años", "21-30 años", "31-40 años", "41-50 años", "51-60 años", "61-70 años"]
    let pickerGenderData = ["Masculino", "Femenino"]
    
    @IBAction func info(_ sender: UIButton) {
        if dataTask != nil {
            dataTask?.cancel()
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let num = String(numEnt)
        let int = String(inter)
        let localidadStr = localidad.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let ocupacionStr = ocupacion.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let edadStr = pickerAgeData[selectedAgeIndex]
        let generoStr = pickerGenderData[selectedGenderIndex]
        
        let urlAct = URL(string: "https://laboratorio-db.herokuapp.com/interviewed?numEntrevistas=" + num + "&Entrevistador=" + int)
        print(urlAct!)
        let sessionAct = URLSession.shared
        let taskAct = sessionAct.dataTask(with: urlAct!) {
            (dataG, _, _) in DispatchQueue.main.async{
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            guard let dataG = dataG else { return }
            do{
                let actors = try JSONDecoder().decode([Post].self, from: dataG)
                for act in actors{
                    
         //PUT
        let url = URL(string: "https://laboratorio-db.herokuapp.com/interviewed/" + String(act.id))
        var requestGet = URLRequest(url: url!)
        requestGet.httpMethod = "PUT"
        requestGet.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let postDictionary = ["Entrevistador": self.inter, "numEntrevistas": self.numEnt, "LocalidadEntrevistado": localidadStr!, "OcupacionEntrevistado": ocupacionStr!, "GeneroEntrevistado": edadStr, "RangoEdadEntrevistado": generoStr, "LimpiezaCalificacion": act.LimpiezaCalificacion, "LimpiezaImagen": act.LimpiezaImagen, "LimpiezaColor": act.LimpiezaColor, "LimpiezaMejoramiento": act.LimpiezaMejoramiento, "MobiliarioCalificacion": act.MobiliarioCalificacion, "MobiliarioImagen": act.MobiliarioImagen, "MobiliarioColor": act.MobiliarioColor, "MobiliarioMejoramiento": act.MobiliarioMejoramiento, "RuidoCalificacion": act.RuidoCalificacion, "RuidoImagen": act.RuidoImagen, "RuidoColor": act.RuidoColor, "RuidoMejoramiento": act.RuidoMejoramiento, "SeguridadCalificacion": act.SeguridadCalificacion, "SeguridadImagen": act.SeguridadImagen, "SeguridadColor": act.SeguridadColor, "SeguridadMejoramiento": act.SeguridadMejoramiento, "NaturalezaCalificacion": act.NaturalezaCalificacion, "NaturalezaImagen": act.NaturalezaImagen, "NaturalezaColor": act.NaturalezaColor, "NaturalezaMejoramiento": act.NaturalezaMejoramiento] as [String : Any]
        /*let newPost = Post(id: act.id, Entrevistador: self.inter, numEntrevistas: self.numEnt, LocalidadEntrevistado: localidadStr!, OcupacionEntrevistado: ocupacionStr!, GeneroEntrevistado: edadStr, RangoEdadEntrevistado: generoStr, LimpiezaCalificacion: act.LimpiezaCalificacion, LimpiezaImagen: act.LimpiezaImagen, LimpiezaColor: act.LimpiezaColor, LimpiezaMejoramiento: act.LimpiezaMejoramiento, MobiliarioCalificacion: act.MobiliarioCalificacion, MobiliarioImagen: act.MobiliarioImagen, MobiliarioColor: act.MobiliarioColor, MobiliarioMejoramiento: act.MobiliarioMejoramiento, RuidoCalificacion: act.RuidoCalificacion, RuidoImagen: act.RuidoImagen, RuidoColor: act.RuidoColor, RuidoMejoramiento: act.RuidoMejoramiento, SeguridadCalificacion: act.SeguridadCalificacion, SeguridadImagen: act.SeguridadImagen, SeguridadColor: act.SeguridadColor, SeguridadMejoramiento: act.SeguridadMejoramiento, NaturalezaCalificacion: act.NaturalezaCalificacion, NaturalezaImagen: act.NaturalezaImagen, NaturalezaColor: act.NaturalezaColor, NaturalezaMejoramiento: act.NaturalezaMejoramiento)*/
        do{
            /*let jsonBody = try JSONEncoder().encode(newPost)
            requestGet.httpBody = jsonBody*/
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
        //FIN PUT
        //DELETE
        let urlDel = URL(string: "https://laboratorio-db.herokuapp.com/interviewed/" + String(act.id+1))
        var requestDel = URLRequest(url: urlDel!)
        requestDel.httpMethod = "DELETE"
        requestDel.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let sessionDel = URLSession.shared
        let taskDel = sessionDel.dataTask(with: requestDel) {
        (data, _, _) in DispatchQueue.main.async{
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        guard let data = data else { return }
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: [])
        }catch{}
        }
        taskDel.resume()
        //FIN DELETE
                }
            }catch{}
        }
        taskAct.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewAge.delegate = self
        pickerViewAge.dataSource = self
        pickerViewGender.delegate = self
        pickerViewGender.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == pickerViewAge){
            return pickerAgeData.count
        }else{
            return pickerGenderData.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == pickerViewAge){
            selectedAgeIndex = row
            return pickerAgeData[row]
        }else{
            selectedGenderIndex = row
            return pickerGenderData[row]
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
