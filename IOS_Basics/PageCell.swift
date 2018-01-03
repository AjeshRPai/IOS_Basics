//
//  PageCell.swift
//  IOS_Basics
//
//  Created by AJESH R PAI on 21/12/17.
//  Copyright © 2017 Ajesh. All rights reserved.
//

import Foundation
import UIKit

class PageCell: UICollectionViewCell{
    
    var page:Page?{
        didSet{
            guard let unWrappedPage = page else {
                return
            }
            imageView.image=UIImage(named:unWrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(
                string:unWrappedPage.headerText,
                attributes:[NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 18 )])
            
            attributedText.append(NSAttributedString(
                string:unWrappedPage.bodyText,
                attributes:[NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13 ),
                            NSAttributedStringKey.foregroundColor:UIColor.lightGray]))
            
            descriptionTextview.attributedText = attributedText
            descriptionTextview.textAlignment = .center

        }
    }
    
   
    
    let imageView:UIImageView = {
        let imageview = UIImageView(image:#imageLiteral(resourceName: "og.png"))
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints=false
        return imageview
    }()
    
    let descriptionTextview:UITextView = {
        let textView=UITextView()
        textView.translatesAutoresizingMaskIntoConstraints=false
        textView.textAlignment = NSTextAlignment.center
        textView.isEditable=false
        textView.isScrollEnabled=false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupImageview()
        setupTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
   
    
    private func setupImageview(){
        
        let topImageContainerView=UIView()
        addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints=false
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive=true
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        topImageContainerView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive=true
        topImageContainerView.addSubview(imageView)
        
        imageView.centerXAnchor
            .constraint(equalTo: topImageContainerView.centerXAnchor)
            .isActive=true
        imageView.centerYAnchor
            .constraint(equalTo: topImageContainerView.centerYAnchor)
            .isActive=true
        imageView.widthAnchor
            .constraint(equalToConstant: 200)
            .isActive=true
        imageView.heightAnchor
            .constraint(equalToConstant: 100)
            .isActive=true
    }
    
    private func setupTextView(){
        addSubview(descriptionTextview)
        descriptionTextview.topAnchor
            .constraint(equalTo: imageView.bottomAnchor,constant:120)
            .isActive=true
        descriptionTextview.leftAnchor
            .constraint(equalTo:leftAnchor)
            .isActive=true
        descriptionTextview.rightAnchor
            .constraint(equalTo: rightAnchor)
            .isActive=true
        descriptionTextview.bottomAnchor
            .constraint(equalTo: bottomAnchor)
            .isActive=true
    }
}
