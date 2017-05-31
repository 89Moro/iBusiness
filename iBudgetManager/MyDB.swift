//
//  MyDB.swift
//  iBudgetManager
//
//  Created by Ospite on 31/05/17.
//  Copyright © 2017 Ospite. All rights reserved.
//

import Foundation
import SQLite

class MyDB {

    static let instance = MyDB()
    
    private let db: Connection?
    
    private let movimenti     = Table("movimenti")
    private let id            = Expression<Int64>("id_mov")
    private let data          = Expression<Date>("data")
    private let descrizione   = Expression<String>("descrizione")
    private let importo       = Expression<Double>("importo")
    private let id_cat_fk     = Expression<Int64>("id_cat")
    
    private let categorie   = Table("categorie")
    private let id_cat      = Expression<Int64>("id_cat")
    private let descriz_cat = Expression<String>("desrizione")
    private let tipo_cat    = Expression<Int>("tipo")
    
    private init()
    {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do
        {
            db = try Connection("\(path)/BudgetManager.sqlite3")
        }
        catch
        {
            db = nil
            print("Imposibile aprire Databse")
        }
        createTable()
    }
    
    func createTable()
    {
        do
        {
            try db!.run(categorie.create(ifNotExists: true)
            {
                table
                in
                table.column(id_cat, primaryKey: true)
                table.column(descriz_cat)
                table.column(tipo_cat)
               
            })
        }
        catch
        {
        print("impossibile creare Categorie")
        }
        
        do{
            try db!.run(movimenti.create(ifNotExists:true) {
            table
            in
            table.column(id,primaryKey:true)
            table.column(data)
            table.column(descrizione)
            table.column(importo)
            table.foreignKey(id_cat_fk, references:categorie,id_cat, delete:.setNull)
            })
        }
        catch
        {
        print("impossibile creare Movimenti")
        }
        
        
    }
    
    func addCategoria(_ cCategoria:Categoria) -> Int64?
    {
        do
        {
         let insert = categorie.insert(descriz_cat <- cCategoria.descrizione, tipo_cat <- cCategoria.tipo)
         let id = try db!.run(insert)
         return id
        }
        catch
        {
         print("error on insert")
         return -1
        }
    }
    
    func addMovimento(_ cMovimento:Movimento) -> Int64? {
    
        do
        {
            let insert = movimenti.insert(data <- cMovimento.data, descrizione <- cMovimento.descrizione,importo <- cMovimento.importo)
            let id = try db!.run(insert)
            return id
        }
        catch
        {
            print("error on insert")
            return -1
        }
    
    
    }
    
    func deleteCategoria(_ cid:Int64) -> Bool {
        do
        {
            let categoria = categorie.filter(id_cat == cid)
            try db!.run(categoria.delete())
            return true
        }
        catch
        {
            print("Errore on delete Categoria")
            return false
        }
    }
    
    func deleteMovimento(_ cid:Int64) -> Bool {
        do
        {
            let movimento = movimenti.filter(id == cid)
            try db!.run(movimento.delete())
            return true
        }
        catch
        {
            print("Errore on delete Movimenti")
            return false
        }
    }
    
    func updateCategoria(_ cid: Int64,_ cCategoria: Categoria ) -> Bool
    {
        let categoria = categorie.filter(id_cat == cid)
        do {
            let update = categoria.update(descrizione <- cCategoria.descrizione,tipo_cat <- cCategoria.tipo)
            if try db!.run(update) > 0
            {
                return true
            }
        }
        catch
        {
            print("Error on update categoria")
            
        }
        return false
    }
    
    func updateMovimento(_ cid: Int64,_ cMovimento: Movimento ) -> Bool
    {
        let movimento = movimenti.filter(id == cid)
        do {
            let update = movimento.update(data <- cMovimento.data,descrizione <- cMovimento.descrizione,id_cat_fk <- cMovimento.tipo,importo <- cMovimento.importo)
            if try db!.run(update) > 0
            {
                return true
            }
        }
        catch
        {
            print("Error on update movimento")
            
        }
        return false
    }
    
    func getCategorie() -> [Categoria]
    {
        var ret_categorie = [Categoria]()
        
        do
        {
            for myCategoria in try
                db!.prepare(self.categorie)
            {
                let tmpCategoria:Categoria = Categoria(myCategoria[descriz_cat],myCategoria[tipo_cat])
                ret_categorie.append(tmpCategoria)
            }
        }
        catch
        {
            print("Error on select")
        }
        return ret_categorie
    
    }
    
    
    func getMovimenti() -> [Movimento]
    {
        var ret_movimenti = [Movimento]()
        
        do
        {
            for myMovimento in try
                db!.prepare(self.movimenti)
            {
                let tmpMovimento:Movimento = Movimento(myMovimento[data],myMovimento[descrizione],myMovimento[importo],myMovimento[id_cat_fk])
                ret_movimenti.append(tmpMovimento)
            }
        }
        catch
        {
            print("Error on select")
        }
        return ret_movimenti
        
    }
    
}
