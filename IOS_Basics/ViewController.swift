//
//  ViewController.swift
//  IOS_Basics
//
//  Created by AJESH R PAI on 17/12/17.
//  Copyright © 2017 Ajesh. All rights reserved.
//

import UIKit

extension UIColor{
    static var mainPink=UIColor(displayP3Red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class ViewController: UIViewController {

        let imageView:UIImageView = {
            let imageview = UIImageView(image:#imageLiteral(resourceName: "og.png"))
            imageview.contentMode = .scaleAspectFit
            imageview.translatesAutoresizingMaskIntoConstraints=false
            return imageview
        }()
        
        let descriptionTextview:UITextView = {
            let textView=UITextView()
            let attributedText = NSMutableAttributedString(
                string:"Join us today in our fun and game",
                attributes:[NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 18 )])
            
            attributedText.append(NSAttributedString(
                string:"\n\n\nthis is the description",
                attributes:[NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13 ),
                            NSAttributedStringKey.foregroundColor:UIColor.lightGray]))
            
            textView.attributedText=attributedText
            
            textView.translatesAutoresizingMaskIntoConstraints=false
            textView.textAlignment = NSTextAlignment.center
            textView.isEditable=false
            textView.isScrollEnabled=false
            return textView
        }()
    
        
    
    
        
    
        
        override func viewWillAppear(_ animated: Bool) {
        }
        
        override func viewDidAppear(_ animated: Bool) {
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            view.addSubview(descriptionTextview)
            setupImageview()
            setupTextView()
        }
    
    
        
        private func setupImageview(){
            
            let topImageContainerView=UIView()
        
            view.addSubview(topImageContainerView)
            
            topImageContainerView.translatesAutoresizingMaskIntoConstraints=false
            
            topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive=true
            
            topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
            
            topImageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
            
            topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
            
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
            descriptionTextview.topAnchor
                .constraint(equalTo: imageView.bottomAnchor,constant:120)
                .isActive=true
            descriptionTextview.leftAnchor
                .constraint(equalTo: view.leftAnchor)
                .isActive=true
            descriptionTextview.rightAnchor
                .constraint(equalTo: view.rightAnchor)
                .isActive=true
            descriptionTextview.bottomAnchor
                .constraint(equalTo: view.bottomAnchor)
                .isActive=true
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        override func viewWillDisappear(_ animated: Bool) {
        }
        
        
        override func viewDidDisappear(_ animated: Bool) {
        }
        
        
        
        
}

