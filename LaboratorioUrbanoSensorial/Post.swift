//
//  Post.swift
//  LaboratorioUrbanoSensorial
//
//  Created by Luis Fernando Flores Luna on 30/04/18.
//  Copyright © 2018 Luis Alfredo León Villapún. All rights reserved.
//

import Foundation

struct Post: Decodable, Encodable {
    let id: Int
    let Entrevistador: String
    let numEntrevistas: Int
    let LocalidadEntrevistado: String
    let OcupacionEntrevistado: String
    let GeneroEntrevistado: String
    let RangoEdadEntrevistado: String
    let LimpiezaCalificacion: Int
    let LimpiezaImagen: Int
    let LimpiezaColor: Int
    let LimpiezaMejoramiento: String
    let MobiliarioCalificacion: Int
    let MobiliarioImagen: Int
    let MobiliarioColor: Int
    let MobiliarioMejoramiento: String
    let RuidoCalificacion: Int
    let RuidoImagen: Int
    let RuidoColor: Int
    let RuidoMejoramiento: String
    let SeguridadCalificacion: Int
    let SeguridadImagen: Int
    let SeguridadColor: Int
    let SeguridadMejoramiento: String
    let NaturalezaCalificacion: Int
    let NaturalezaImagen: Int
    let NaturalezaColor: Int
    let NaturalezaMejoramiento: String
}
