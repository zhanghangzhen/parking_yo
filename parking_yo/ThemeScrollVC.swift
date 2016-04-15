//
//  ThemeScrollVC.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/12.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit

class ThemeScrollVC: UIViewController {

    let topSVC:TopScrollViewController
    let bottomVC = BotomScrollViewController()
    let tempVc = UITableViewController()
     var maskView = UIView()
    
    init(type:ThemeScrollViewtype){
        topSVC = TopScrollViewController(type:type)
        super.init(nibName: nil, bundle: nil)
     }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addTopScrollView()
        addBottomScrollView()

    }
    
    func addTopScrollView() {
        addChildViewController(topSVC)
        view.addSubview(topSVC.view)
        topSVC.view.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(view)
            make.height.equalTo(topScrollHeight)
        }
    }
    
    func addBottomScrollView() {
        addChildViewController(bottomVC)
        view.addSubview(bottomVC.view)
        bottomVC.view.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(topSVC.view.snp_bottom)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK: - 接收BottomScrollViewController事件
extension ThemeScrollVC {
    /**
     从TopScrollViewController那里获取数组长度，方便自己设置scrollview的宽度
     
     :returns: 数组长度
     */
    func getTitleArrayNumber() -> Int {
        guard topSVC.labelTitleArray() != nil else { return 0 }
         return topSVC.labelTitleArray()!.count
    }
}

// MARK: - 接收TopScrollViewController事件
extension ThemeScrollVC {
    /**
     处理TopScrollViewController的label被点击的事件
     
     :param: recognizer 触摸手势识别器
     */
    func labelClicked(recognizer: UITapGestureRecognizer){
        let targetPage = recognizer.view!.tag
        updateTopScrollViewLabel(targetPage)  // 更新label颜色
        
        if let buttomScrollView = bottomVC.view as? BotomScrollView {
            if targetPage > topSVC.lastClickedLabelTag + 1 {  // 右侧不相邻label被点击了
                bottomVC.shouldLoadPage = false
                let previousOffSetX = CGFloat(targetPage - 1) * ScreenWidth  // 先不带动画滑到前一页
                if let bottomScrollView = bottomVC.view as? BotomScrollView,
                    maskView = bottomVC.currentDisplayViewController()?.view {
                        bottomVC.bindDataSourceWithViewController(tempVc, page: targetPage)
                        
                        buttomScrollView.bottomScroll.setContentOffset(CGPointMake(previousOffSetX, 0), animated: false)
                        bottomScrollView.addBottomViewAtIndex(targetPage - 1, view: maskView)
                        bottomScrollView.addBottomViewAtIndex(targetPage, view: tempVc.view)
                }
            }
            if targetPage < topSVC.lastClickedLabelTag - 1 {  // 左侧不相邻label被点击了
                bottomVC.shouldLoadPage = false
                let previousOffSetX = CGFloat(targetPage + 1) * ScreenWidth  // 先不带动画滑到前一页
                if let bottomScrollView = bottomVC.view as? BotomScrollView,
                    maskView = bottomVC.currentDisplayViewController()?.view {
                        bottomVC.bindDataSourceWithViewController(tempVc, page: targetPage)
                        
                        buttomScrollView.bottomScroll.setContentOffset(CGPointMake(previousOffSetX, 0), animated: false)
                        bottomScrollView.addBottomViewAtIndex(targetPage + 1, view: maskView)
                        bottomScrollView.addBottomViewAtIndex(targetPage, view: tempVc.view)
                }
            }
            let offSetX = CGFloat(targetPage) * ScreenWidth
            buttomScrollView.bottomScroll.setContentOffset(CGPointMake(offSetX, 0), animated: true)
        }
    }
}
// MARK: - 停止滑动时，更新顶部文字样式
extension ThemeScrollVC {
    func updateTopScrollViewLabel(index: Int) {
        topSVC.updateLabelsWithPurpleIndex(index)
    }
}
// MARK - 实现UIScrollViewDelegate协议
extension ThemeScrollVC{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x / ScreenWidth)
        topSVC.lastClickedLabelTag = index  // 更新当前选中的label的tag
        updateTopScrollViewLabel(index)  // 更新label颜色
        
        if let view = topSVC.view as? TopScrollView {
            let titleLabel = view.topScroll.subviews[0].subviews[index] as! UILabel
            var offSetX = titleLabel.center.x - view.topScroll.frame.size.width * 0.5
            let offSetMaxX = view.topScroll.contentSize.width - view.topScroll.frame.size.width
            if offSetX < 0 {
                offSetX = 0
            }
            else if (offSetX > offSetMaxX) {
                offSetX = offSetMaxX
            }
            view.topScroll.setContentOffset(CGPointMake(offSetX, 0), animated: true)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        maskView.removeFromSuperview()
        tempVc.view.removeFromSuperview()
        
        bottomVC.shouldLoadPage = true
        bottomVC.loadAllPages(bottomVC.currentPage)
    }
}


