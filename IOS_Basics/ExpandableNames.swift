//
//  ExpandableNames.swift
//  IOS_Basics
//
//  Created by AJESH R PAI on 05/01/18.
//  Copyright © 2018 Ajesh. All rights reserved.
//

import Foundation
import Contacts

struct ExpandableNames {

    var isExapnded:Bool
    var names:[FavouriteContacts]
}


struct FavouriteContacts{
    var contact:CNContact
    var isFavourite:Bool
}
