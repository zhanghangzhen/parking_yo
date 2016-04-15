//
//  ZHZTwoViewController.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/6.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit

enum ThemeScrollViewtype {

    case Article
    case Subject
    
}


class ZHZTwoViewController: ZHZBaseViewController,FindViewDelegate {

    var datamodel = FindViewModel()
    
    lazy var articleViewController:ThemeScrollVC = ThemeScrollVC(type:.Article)
    lazy var subjectViewController: ThemeScrollVC = ThemeScrollVC(type:.Subject )

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = true
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeBackGroundColor:", name: "zhang", object: nil)
//         buildCollectionView()
        
        if let view = view as? FindView {
            
//            self.navigationItem.title = nil
             navigationItem.titleView = view.segmentView
             self.addChildViewController(articleViewController)
            self.addChildViewController(subjectViewController)
            view.containerScrollView.addSubview((articleViewController.view)!)
            articleViewController.view?.snp_makeConstraints(closure: { (make) -> Void in
                make.top.left.equalTo(0)
                make.width.equalTo(ScreenWidth)
                make.bottom.equalTo(view).offset(-globalTabbarHeight)
            })
            
            view.containerScrollView.addSubview((subjectViewController.view)!)
            subjectViewController.view?.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo((articleViewController.view)!).offset(ScreenWidth)
                make.top.width.bottom.equalTo((articleViewController.view)!)
            })
        }
    }
    
    func changeBackGroundColor(noti:NSNotification){
          self.view.backgroundColor = UIColor.redColor()
      }
    
    deinit{
         NSNotificationCenter.defaultCenter().removeObserver(self, name: "zhang", object: nil)
     }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func loadView() {
        super.loadView()
        view = FindView(delegate: self)
    }
    func segmentValueChange(){
        if let view = view as? FindView {
            view.containerScrollView.setContentOffset(CGPointMake(ScreenWidth * CGFloat(view.segmentView.selectedSegmentIndex), 0), animated: true)
        }
    }
    func segmentTitleArray() -> Array<String> {
        return datamodel.segmentItemTitles
    }
 }
 