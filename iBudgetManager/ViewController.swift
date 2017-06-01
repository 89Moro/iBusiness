//
//  ViewController.swift
//  iBudgetManager
//
//  Created by Ospite on 31/05/17.
//  Copyright © 2017 Ospite. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var btnPlus: UIButton!

    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var btnPlus2: UIButton!
    
    var movimenti:[Movimento] = MyDB.instance.getMovimenti()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movimenti.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier:nil)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        
        cell.detailTextLabel?.text = "\(formatter.string(from: movimenti[indexPath.row].descrizione))/"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        movimenti = MyDB.instance.getMovimenti()
        myTable.reloadData()
    }



    @IBAction func btnPlus_TouchUp(_ sender: Any) {
        performSegue(withIdentifier: "segueAddCategory",sender:self)
    }

    @IBAction func btnPlus2_TouchUp(_ sender: Any) {
                performSegue(withIdentifier: "segueToAddMovimenti",sender:self)
    }
}

