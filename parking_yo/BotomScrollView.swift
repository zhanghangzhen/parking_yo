
//
//  BotomScrollView.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/12.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit

class BotomScrollView: UIView {

    var bottomScroll = UIScrollView()
    var bottomContainerView = UIView()
    var rightConstraint: Constraint?
    var pageNumber: Int
    
    init(pages: Int){
        self.pageNumber = pages
        super.init(frame: CGRectNull)
        setBottomScroll()
    }
     required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     func setBottomScroll(){
        bottomScroll.pagingEnabled = true
        bottomScroll.showsHorizontalScrollIndicator = false
        bottomScroll.bounces = false
        
        addSubview(bottomScroll)
        bottomScroll.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        
        bottomContainerView.backgroundColor = bottomScroll.backgroundColor
        bottomScroll.addSubview(bottomContainerView)
        
        bottomContainerView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(bottomScroll)
            make.top.bottom.equalTo(self)
            make.width.equalTo(CGFloat(pageNumber) * ScreenWidth)
        }
    }
}
 extension BotomScrollView {
    func addBottomViewAtIndex(index: Int, view: UIView) {
        bottomContainerView.addSubview(view)
         view.snp_removeConstraints()
        view.snp_makeConstraints(closure: { (make) -> Void in
            make.top.height.equalTo(bottomContainerView)
            make.width.equalTo(ScreenWidth)
            make.left.equalTo(CGFloat(index) * ScreenWidth)
        })
    }
}
