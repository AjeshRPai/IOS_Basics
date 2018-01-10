//
//  ViewController.swift
//  IOS_Basics
//
//  Created by AJESH R PAI on 17/12/17.
//  Copyright © 2017 Ajesh. All rights reserved.
//

import UIKit
import Contacts
class ViewController: UITableViewController {
    
    let cellid="cellid"
    var twoDimensionalArray = [ExpandableNames]()

    func favCallback(cell:UITableViewCell){
        let indexPathTapped = tableView.indexPath(for: cell)
        let contact = self.twoDimensionalArray[indexPathTapped!.section]
            .names[indexPathTapped!.row]
        let hasFavourited = !contact.isFavourite
        twoDimensionalArray[indexPathTapped!.section]
            .names[indexPathTapped!.row].isFavourite = hasFavourited
        cell.accessoryView?.tintColor = hasFavourited ? UIColor.red : .gray
    }
    
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    DispatchQueue.main.async(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mapViewControllerObj = storyboard.instantiateViewController(withIdentifier: "1234") as? SecondViewController
        if(mapViewControllerObj != nil){
           self.present(mapViewControllerObj!, animated: true, completion: nil)
        }else {
           print("This was empty")
        }
    }
    
    }
    
    var showindexpaths=false

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContacts()
        navigationItem.title="Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellid)
    }
    
    private func fetchContacts(){
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, error) in
            if(granted){
                let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do{
                    var contacts=[FavouriteContacts]()
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        contacts.append(FavouriteContacts(contact:contact,isFavourite:false))
                    })
                    
                    let names = ExpandableNames(isExapnded:true,names:contacts)
                    self.twoDimensionalArray=[names]
                    self.tableView.reloadData()
                }catch let _{
                    fatalError("There has beeen some error in the Calculation ")
                }
            }else {
                fatalError("there was some error ")
            }
        }
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
        return self.twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactCell(style: .subtitle, reuseIdentifier: cellid)
        cell.link = self
        let favouritableContact = twoDimensionalArray[indexPath.section].names[indexPath.row]
        print(favouritableContact.contact.givenName)
        cell.accessoryView?.tintColor = favouritableContact.isFavourite ? UIColor.red : .gray
        cell.textLabel?.text = favouritableContact.contact.givenName + " " + favouritableContact.contact.familyName
        cell.detailTextLabel?.text = favouritableContact.contact.phoneNumbers.first?.value.stringValue
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


