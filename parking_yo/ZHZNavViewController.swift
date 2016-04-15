//
//  ZHZNavViewController.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/6.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit

class ZHZNavViewController: UINavigationController {
    
    lazy var backBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setImage(UIImage(named: "v2_goback"), forState: .Normal)
        btn.titleLabel?.hidden = true
        btn.addTarget(self, action: "goBack", forControlEvents: .TouchUpInside)
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        let btnW: CGFloat = ScreenWidth > 375.0 ? 50 : 44
        btn.frame = CGRectMake(0, 0, btnW, 40)
    return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer!.delegate = nil
      }
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        viewController.navigationItem.hidesBackButton = true
        if childViewControllers.count > 0{
            UINavigationBar.appearance().backItem?.hidesBackButton = false
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
              viewController.hidesBottomBarWhenPushed = true
          }
        super.pushViewController(viewController, animated: animated)
    }
    func goBack(){
    
        popViewControllerAnimated(true)
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
