//
//  SecondViewController.swift
//  LaboratorioUrbanoSensorial
//
//  Created by Luis Alfredo León Villapún on 20/04/18.
//  Copyright © 2018 Luis Alfredo León Villapún. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var interviewed: String?
    var numEnt: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let DestViewController = segue.destination as! InterviewSubjectInfoViewController
        DestViewController.inter = interviewed
        DestViewController.numEnt = numEnt
    }
    
}
