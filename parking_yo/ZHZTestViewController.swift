//
//  ZHZTestViewController.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/6.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit


protocol SendMessageDelegate{

    func sendMsg(str:String)
}

typealias testBlock = (sss:String)->Void

 class ZHZTestViewController: ZHZBaseViewController {
     var delegate : SendMessageDelegate?
    var arr = NSMutableArray()
    
    var bloc:testBlock?
    
//    func setBack(tempBlcok1:testBlock){
//     
//        self.bloc = tempBlcok1
//    }
    
    
      override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = UIColor.grayColor()
        print(self.arr)
         let btn = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: "back")
          self.navigationItem.leftBarButtonItem = btn
                 notifigation()
        
        let btn1 = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: "backclick")
        self.navigationItem.rightBarButtonItem = btn1
        notifigation()

//          SingleTwo.shareSingleTwo().strrrr = "dddddd"
        
        
        let addBookBtn = UIButton(frame: CGRectMake(200, 200, SCREEN_WIDTH, 45))
        addBookBtn.setTitleColor(UIColor.purpleColor(), forState: .Normal)
        addBookBtn.setTitle("    新建书评", forState: .Normal)
        addBookBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 25)
        addBookBtn.contentHorizontalAlignment = .Left        //按钮文字现实居左
        
        addBookBtn.addTarget(self, action: Selector("pushNewBook"), forControlEvents: .TouchUpInside)
        
        self.view .addSubview(addBookBtn)
        
        }
//传值
    
    func pushNewBook(){
    print("字体超炫的")
        
        ProgressHUD.showSuccess("完美~~~~~字体超炫的")
//        ProgressHUD.showError("用户名或密码错误")
     }
    
    
    func backclick(){
    
        if self.bloc != nil{
             self.bloc!(sss: "block传值")
        }
          self.navigationController?.popViewControllerAnimated(true)
      }
    
    func back(){
            if self.delegate != nil {
             delegate?.sendMsg("张航振")
        }
        self.navigationController?.popViewControllerAnimated(true)
     }
    
    func notifigation(){
         let dic = ["1":"one"]
          NSNotificationCenter.defaultCenter().postNotificationName("zhang", object: nil, userInfo: dic)
      }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    deinit{
    
    
        print("sasuygnuuybggg")
    }
    
    
    
}
