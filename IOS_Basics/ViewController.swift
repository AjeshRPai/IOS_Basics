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
    
    var twoDimensionalArray = [
        ExpandableNames(isExapnded: true, names:["Ajesh","Arun"].map{ Contact(name:$0,isFavourite:false)} ),
         ExpandableNames(isExapnded: true, names:["Vineetha","Veena"].map{ Contact(name:$0,isFavourite:false)}),
          ExpandableNames(isExapnded: true, names:["Varun"].map{ Contact(name:$0,isFavourite:false)}),
           ExpandableNames(isExapnded: true, names:["Ananthu"].map{ Contact(name:$0,isFavourite:false)}),
    ]
    
    
    func favCallback(cell:UITableViewCell){
        
        let indexPathTapped = tableView.indexPath(for: cell)
        let contact=twoDimensionalArray[indexPathTapped!.section]
            .names[indexPathTapped!.row]
        let hasFavourited = !contact.isFavourite
        twoDimensionalArray[indexPathTapped!.section]
            .names[indexPathTapped!.row].isFavourite = hasFavourited
        cell.accessoryView?.tintColor = hasFavourited ? UIColor.red : .gray
        
    }
    
    var showindexpaths=false
    
    @objc func handleShowIndexpath(){
        
        var indexpathtoReload=[IndexPath]()
        for section in twoDimensionalArray.indices{
            for row in twoDimensionalArray[section].names.indices{
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
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellid)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type:.system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.tag = section
        button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return button
    }
    
    @objc private func handleClose(button:UIButton){
        let section=button.tag
        var indexPaths=[IndexPath]()
        for row in twoDimensionalArray[section].names.indices{
            let indexpath=IndexPath(row: row, section: section)
            indexPaths.append(indexpath)
        }
    
        button.setTitle(twoDimensionalArray[section].isExapnded ? "Open": "Close", for: .normal)
        twoDimensionalArray[section].isExapnded = !twoDimensionalArray[section].isExapnded
        if(twoDimensionalArray[section].isExapnded){
            tableView.insertRows(at: indexPaths, with: .left)
        }else{
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! ContactCell
        cell.link = self
        let contact = twoDimensionalArray[indexPath.section].names[indexPath.row]
        cell.accessoryView?.tintColor = contact.isFavourite ? UIColor.red : .gray
        if(showindexpaths){
            cell.textLabel?.text = contact.name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!twoDimensionalArray[section].isExapnded){
            return 0
        }
        return twoDimensionalArray[section].names.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


