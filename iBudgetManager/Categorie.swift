//
//  Categorie.swift
//  iBudgetManager
//
//  Created by Ospite on 31/05/17.
//  Copyright © 2017 Ospite. All rights reserved.
//

import Foundation

class Categoria {
    var id:Int64
    var descrizione:String
    var tipo:Int

    init()
    {
        self.id = 0
        self.descrizione = ""
        self.tipo = 0
        
    }

    init (_ cDescrizione:String, _ cTipo:Int)
    {
        self.id = 0
        self.descrizione = cDescrizione
        self.tipo = cTipo
    }

}
