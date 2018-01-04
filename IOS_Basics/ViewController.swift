//
//  ViewController.swift
//  IOS_Basics
//
//  Created by AJESH R PAI on 17/12/17.
//  Copyright © 2017 Ajesh. All rights reserved.
//

import UIKit



class ViewController: UITableViewController {
    
    let cellid="cellid"
    
    let twoDimensionalArray = [
        ["Ajesh","Arun"],
        ["Vineetha","Veena"],
        ["Varun"],
        ["Ananthu"]
    ]
    
    var showindexpaths=false
    
    @objc func handleShowIndexpath(){
        var indexpathtoReload=[IndexPath]()
        
        for section in twoDimensionalArray.indices{
            for row in twoDimensionalArray[section].indices{
                let indexpath=IndexPath(row: row, section: section)
                indexpathtoReload.append(indexpath)
            }
        }
        showindexpaths = !showindexpaths
        
        let animationStyle = showindexpaths ? UITableViewRowAnimation.right : .left
        
        tableView.reloadRows(at: indexpathtoReload, with: animationStyle)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show index path",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleShowIndexpath))
        
        navigationItem.title="Contacts"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label=UILabel()
        label.text="Header"
        label.backgroundColor=UIColor.lightGray
        return label
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        
        let name = twoDimensionalArray[indexPath.section][indexPath.row]
        
        if(showindexpaths){
            cell.textLabel?.text = name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimensionalArray[section].count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


