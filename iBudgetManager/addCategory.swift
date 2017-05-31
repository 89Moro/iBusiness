//
//  addCategory.swift
//  iBudgetManager
//
//  Created by Ospite on 31/05/17.
//  Copyright © 2017 Ospite. All rights reserved.
//

import Foundation
import UIKit

class addCategory: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource
{
    @IBOutlet weak var btnModifica: UIButton!
    @IBOutlet weak var btnElimina: UIButton!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myLable: UITextField!

    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet weak var mySegment: UISegmentedControl!
    @IBOutlet weak var btnAnnulla: UIButton!
    @IBOutlet weak var btnAggiungi: UIButton!
//buba
    var categorie:[Categoria] = MyDB.instance.getCategorie()
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        myPicker.delegate = self
        myPicker.dataSource = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnAnnulla_TouchpP(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func btnAggiungi_TouchUp(_ sender: Any) {
        //add category

        
        if (myLable.text! == ""){
            let allertcontroller = UIAlertController(title: "Inserimento Categoria", message: "Impossibile aggiungere categoria vuota", preferredStyle: UIAlertControllerStyle.alert)
           allertcontroller.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        }
        
        let tipoCategoria:Int = mySegment.selectedSegmentIndex
        
        let myCategoria:Categoria = Categoria(myLable.text!,tipoCategoria)
        let id:Int64 = MyDB.instance.addCategoria(myCategoria)!
        if id == -1 {
            print("Errore su AggiungiCategoria")
        }
        myLable.text = ""
        categorie = MyDB.instance.getCategorie()
        myPicker.reloadAllComponents()
        
        //self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorie.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorie[row].descrizione
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
        myLable.text = categorie[row].descrizione
        mySegment.selectedSegmentIndex = categorie[row].tipo
    }
    
    @IBAction func btnElimina_TouchUp(_ sender: Any) {
        MyDB.instance.deleteCategoria(categorie[selectedIndex].id)
        
        myLable.text = ""
        categorie = MyDB.instance.getCategorie()
        myPicker.reloadAllComponents()
    }

    @IBAction func btnModifica_TouchUp(_ sender: Any) {
        
        let myCategoria:Categoria = Categoria(myLable.text!,mySegment.selectedSegmentIndex)
        MyDB.instance.updateCategoria(categorie[selectedIndex].id,myCategoria)
        
        myLable.text = ""
        categorie = MyDB.instance.getCategorie()
        myPicker.reloadAllComponents()
    }

}
