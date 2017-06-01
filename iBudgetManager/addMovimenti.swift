//
//  addMovimenti.swift
//  iBudgetManager
//
//  Created by Moreno on 01/06/2017.
//  Copyright © 2017 Ospite. All rights reserved.
//

import Foundation
import UIKit

class addMovimenti: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var tfDescrizione: UITextField!
    @IBOutlet weak var tfImporto: UITextField!
    @IBOutlet weak var btnChiudi: UIButton!
    
    @IBOutlet weak var btnSalva: UIButton!
    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet weak var myDate: UIDatePicker!
    
    var categorie:[Categoria] = MyDB.instance.getCategorie()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPicker.delegate   = self
        myPicker.dataSource = self
        
        myDate.date = Date()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnChiudi_TouchUp(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSalva_TouchUp(_ sender: Any) {
        
        if(tfImporto.text = "" || tfDescrizione.text = ""){            let allertcontroller = UIAlertController(title: "Inserimento Categoria", message: "Impossibile aggiungere categoria vuota", preferredStyle: UIAlertControllerStyle.alert)
            allertcontroller.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alertController,animated: true,completion: nil)

        }
        else{
        
        let myMovimento:Movimento = Movimento(myDate.date,tfDescrizione.text,Double(tfImporto.text),myPicker.selectedRow(inComponent: 0))
        
        let id = MyDB.addMovimento(myMovimento)
            
            if id != -1
            {
                let allertcontroller = UIAlertController(title: "Inserimento Categoria", message: "Impossibile aggiungere categoria vuota", preferredStyle: UIAlertControllerStyle.alert)
                allertcontroller.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alertController,animated: true,completion: nil)
            
                self.dismiss(animated: true, completion: nil)
            }
            else
            {
                print("Errore inserimento")
            }
        }
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
    
}
