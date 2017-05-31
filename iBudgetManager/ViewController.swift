//
//  ViewController.swift
//  iBudgetManager
//
//  Created by Ospite on 31/05/17.
//  Copyright © 2017 Ospite. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btnPlus: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var btnAddCategory_TouchUp: UIButton!

    @IBAction func btnPlus_TouchUp(_ sender: Any) {
        performSegue(withIdentifier: "segueAddCategory",sender:self)
    }

}

