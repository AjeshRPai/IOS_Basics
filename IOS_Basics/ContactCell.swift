//
//  ContactCell.swift
//  IOS_Basics
//
//  Created by AJESH R PAI on 06/01/18.
//  Copyright © 2018 Ajesh. All rights reserved.
//

import Foundation

import UIKit


class ContactCell: UITableViewCell{
    
    var link: ViewController?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let button = UIButton(type:.system)
        button.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        button.tintColor = .red
        button.addTarget(self, action: #selector(handleFav), for: .touchUpInside)
        accessoryView = button
    
    }
    

    
    
    
    
    
    @objc private func handleFav(){
        link?.favCallback(cell:self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder hasnt been implemented yet")
    }

}
