//
//  User.swift
//  LaboratorioUrbanoSensorial
//
//  Created by Luis Fernando Flores Luna on 30/04/18.
//  Copyright © 2018 Luis Alfredo León Villapún. All rights reserved.
//

import Foundation

struct User: Decodable, Encodable{
    let username: String
    let password: String
    let nombre: String
    let id: Int
    let numEntrevistas: Int
}
