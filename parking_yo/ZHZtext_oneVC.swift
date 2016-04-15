//
//  ZHZtext_oneVC.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/11.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit

class ZHZtext_oneVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sure(){
        
     }
    func close(){
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    /**
     查看内存是否有泄露的最简单的方法就是看deinit方法是否实现了
     */
    deinit{
        print("sasuygnuuybggg")
    }
}
