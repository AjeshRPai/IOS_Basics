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
        
        setUpBottom_Controls()
        
        
        
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
    
    private let prev_button:UIButton = {
        let button=UIButton(type:.system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font=UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.gray,for:.normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    
    private let next_button:UIButton = {
        let button=UIButton(type:.system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font=UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink,for:.normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext(){
        let nextIndex = min(page_control.currentPage+1,pages.count-1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        page_control.currentPage=nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handlePrev(){
        let nextIndex = max(page_control.currentPage-1,0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        page_control.currentPage=nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var page_control:UIPageControl = {
        let pc=UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
        let pc_color=UIColor(displayP3Red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        pc.pageIndicatorTintColor=pc_color
        return pc
    }()
    
    fileprivate func setUpBottom_Controls(){
        let bottomControlsStackView = UIStackView(arrangedSubviews:
            [prev_button,page_control,next_button])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints=false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x=targetContentOffset.pointee.x
        page_control.currentPage=Int(x/view.frame.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            let indexpath = IndexPath(item:self.page_control.currentPage,section:0)
            self.collectionView?.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
            
        }) { (_) in
            
        }
        
    }
    
    
    
}
