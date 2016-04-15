//
//  ZHZViewController.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/6.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit

class ZHZViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
         setupChildVC()
         self.setValue(MainTabBar(), forKey: "tabBar")
     }
      private func setupChildVC(){
         seupViewController(ZHZOneViewController(), title: "首页", imageName: "v2_home@2x.png", selectedImageName: "v2_home_r@2x.png")
        seupViewController(ZHZTwoViewController(), title: "闪电超市", imageName: "v2_order", selectedImageName: "v2_order_r")
        seupViewController(ZHZThreeViewController(), title: "购物车", imageName: "shopCart", selectedImageName: "shopCart")
        seupViewController(ZHZFourViewController(), title: "我的", imageName: "v2_my", selectedImageName: "v2_my_r")
      }
   private func seupViewController(vc:UIViewController,title:String,imageName: String, selectedImageName: String){
    
    
    let img = UIImage(named:imageName)?.imageWithRenderingMode(.AlwaysOriginal)
    let seletedImg = UIImage(named:selectedImageName)?.imageWithRenderingMode(.AlwaysOriginal)
     vc.tabBarItem = UITabBarItem(title: title, image: img, selectedImage: seletedImg)
        let thnav = ZHZNavViewController(rootViewController: vc)
    
    if title == "闪电超市"{
    
        
    }else{
        vc.title = title
     }
    
        addChildViewController(thnav)
     }
    class MainTabBar:UITabBar {
        override init(frame: CGRect) {
            super.init(frame: frame)
             self.translucent = false
            self.selectionIndicatorImage = UIImage(named: "navigationbar_button_background")
//            self.backgroundImage = UIImage(named: "tabbar_background")
          }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        
        
        
        
        
        
        
        
        
        
        
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
