//
//  FindView.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/12.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit


@objc protocol FindViewDelegate {
    
    func segmentValueChange()
    func segmentTitleArray()->Array<String>
    
}

class FindView: UIView {

    
    let segmentItemWidth: CGFloat = 60
    weak var delegate: FindViewDelegate?
    var containerScrollView:UIScrollView = UIScrollView()
    var segmentView: UISegmentedControl!

    var articleViewController:ThemeScrollVC?
    var subjectViewController: ThemeScrollVC?

    init(delegate:FindViewDelegate){
         super.init(frame:CGRectNull)
        self.delegate = delegate
        setContainerScrollView()
        setSegmentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  setContainerScrollView(){
    
        self.addSubview(containerScrollView)
        
        containerScrollView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(self).offset(-globalTabbarHeight)
         }
    }
    
    func  setSegmentView(){
        /// 通过代理回调返回一个数组
        if let items = delegate?.segmentTitleArray() {
            segmentView = UISegmentedControl(items: items)
            segmentView.setWidth(segmentItemWidth, forSegmentAtIndex: 0)
            segmentView.setWidth(segmentItemWidth, forSegmentAtIndex: 1)
            
            segmentView.selectedSegmentIndex = 0
            segmentView.addTarget(self, action: "segmentValueChanged", forControlEvents: UIControlEvents.ValueChanged)
        }
    }
     func segmentValueChanged() {
        delegate?.segmentValueChange()
    }
     deinit{
        print("销毁")
    }

}
