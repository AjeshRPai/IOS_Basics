//
//  SwipingViewController.swift
//  IOS_Basics
//
//  Created by AJESH R PAI on 21/12/17.
//  Copyright © 2017 Ajesh. All rights reserved.
//

import Foundation

import UIKit

struct Page{
    let imageName:String
    let headerText:String
    let bodyText:String
}

class SwipingViewController:UICollectionViewController,UICollectionViewDelegateFlowLayout{
    
    
    let pages = [
        Page(imageName:"apple_2",headerText:"This is header text 1",bodyText:"This is body text 1"),
        Page(imageName:"apple_3",headerText:"This is header text 2",bodyText:"This is body text 2"),
        Page(imageName:"apple_4",headerText:"This is header text 3",bodyText:"This is body text 3"),
        Page(imageName:"og",headerText:"This is header text 4",bodyText:"This is body text 4")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled=true

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        cell.page=pages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:view.frame.width,height:view.frame.height)
    }
    
    
    
}
