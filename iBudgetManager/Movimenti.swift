//
//  Movimenti.swift
//  iBudgetManager
//
//  Created by Ospite on 31/05/17.
//  Copyright © 2017 Ospite. All rights reserved.
//

import Foundation

class Movimento{
    var id:Int64
    var data:Date
    var descrizione:String
    var importo:Double
    var tipo:Int64
    
    init()
    {
     self.id = 0
     self.data = Date()
     self.descrizione = ""
     self.importo = 0.0
     self.tipo = 0
    }
    
    init(_ cData:Date,_ cDescrizione:String,_ cImporto:Double,_ cTipo:Int64)
    {
     self.id = 0
     self.data = cData
     self.descrizione = cDescrizione
     self.importo = cImporto
     self.tipo = cTipo
    }

}
