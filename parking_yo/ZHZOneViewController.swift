//
//  ZHZOneViewController.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/6.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit

class ZHZOneViewController: ZHZBaseViewController,UITableViewDelegate,UITableViewDataSource,SendMessageDelegate,circleViewDelegate,SWTableViewCellDelegate{
     private var tabV:UITableView?
    
     var loopView:ScrollViewLoop?
     var swipIndexPath:NSIndexPath?
     var Score:LDXScore?
    
    /**
     表示是否现实星星
     */
    var showScore = false

      lazy var dataArr:NSMutableArray = {
         var arr = NSMutableArray()
        
//        for index in 1...100 {
//              arr .addObject(NSString(format: "%d", index))
//         }
        return arr
        
    }()
    
    lazy var dataImg:NSMutableArray = {
        var arr1 = NSMutableArray()
        arr1 .addObject(UIImage(named: "guide_35_1")!)
        arr1.addObject(UIImage(named: "guide_35_4")!)
        arr1.addObject(UIImage(named: "second.jpg")!)
        return arr1
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Score = LDXScore(frame: CGRectMake(100,10,100,22))
        self.Score?.isSelect = true
        self.Score?.normalImg = UIImage(named: "btn_star_evaluation_normal")
        self.Score?.highlightImg = UIImage(named: "btn_star_evaluation_press")
        self.Score?.max_star = 5
        self.Score?.show_star = 5
        
        
        
        
        initTab()
        setUpLeftBtn()
        setUpRightBtn()
       }
    
    private func setUpRightBtn(){
        let nextItem = UIBarButtonItem(title: "测试", style: .Plain, target: self, action: "leftBtnClick")
        self.navigationItem.leftBarButtonItem = nextItem
        
    }
    private func setUpLeftBtn(){
        let nextItem = UIBarButtonItem(title: "编辑", style: .Plain, target: self, action:"rightBtnClick")
          self.navigationItem.rightBarButtonItem = nextItem
      }
      func rightBtnClick(){
          tabV!.setEditing(!tabV!.editing, animated: true)
        if (tabV!.editing == true ) {
            self.navigationItem.leftBarButtonItem!.enabled = true
            self.navigationItem.rightBarButtonItem!.title = "完成"
        }else{
            self.navigationItem.leftBarButtonItem!.enabled = false
            self.navigationItem.rightBarButtonItem!.title = "编辑"
         }
     }
     func leftBtnClick(){
        
        
          let vc = ZHZtext_oneVC()
         FactoryTool.addTitleWithTile(vc, title1: "关闭", title2: "")
        vc.view.backgroundColor = UIColor.whiteColor()
         self.presentViewController(vc, animated: true) { () -> Void in
            
        }
     }
    private func initTab(){
        
         tabV = UITableView(frame: CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height - 60), style: .Plain)
        tabV!.delegate = self;
        tabV!.dataSource = self;
         loopView = ScrollViewLoop()
        loopView?.frame = CGRectMake(0, 0, self.view.frame.size.width, 250)
        loopView?.delegate = self
         loopView?.buildUI(self.dataImg)
         tabV?.tableHeaderView = loopView
        self.tabV?.registerClass(ZHZTabbleViewCell.classForCoder(), forCellReuseIdentifier: "cell")

        
        tabV?.tableFooterView = UIView()
        
        tabV?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("headerRefresh"))
        
        tabV?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: Selector("footerRefresh"))
          view .addSubview(tabV!)
        tabV?.mj_header.beginRefreshing()
     }
      func headerRefresh(){
         sleep(2)
        self.tabV?.mj_header.endRefreshing()
        self.dataArr .removeAllObjects()
           for i in 0...9{
             self.dataArr.addObject(String(i))
         }
        print(self.dataArr)
          self.tabV!.reloadData()
     }
     func footerRefresh(){
        sleep(1)
        self.tabV?.mj_footer.endRefreshing()
        self.dataArr .addObject("zhanghangzhen")
        self.tabV?.reloadData()
     }
    //总行数
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.dataArr.count
     }
    //加载数据
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tabV?.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? ZHZTabbleViewCell
         cell!.delegate = self;
        cell?.rightUtilityButtons = returnRightBtn()
        
        if self.showScore && indexPath.row == self.dataArr.count - 1 {
            cell!.contentView.addSubview(self.Score!)
        }
        
         return cell!
     }
    
    func returnRightBtn()->[AnyObject]{
        let btn1 = UIButton(frame: CGRectMake(0,0,88,88))
        btn1.backgroundColor = UIColor.orangeColor()
        btn1.setTitle("编辑", forState: .Normal)
        
        let btn2 = UIButton(frame:CGRectMake(0,0,88,88))
        btn2.backgroundColor = UIColor.redColor()
        btn2.setTitle("删除", forState: .Normal)
        
        return [btn1,btn2]
    }
    /**
     SWTableViewCellDelegate
     */
     
    func swipeableTableViewCell(cell: SWTableViewCell!, scrollingToState state: SWCellState) {
        let indexPath = self.tabV?.indexPathForCell(cell)

        if state == .CellStateRight{
             if self.swipIndexPath != nil && self.swipIndexPath?.row != indexPath?.row {
                let swipedCell = self.tabV?.cellForRowAtIndexPath(self.swipIndexPath!) as? ZHZTabbleViewCell
                swipedCell?.hideUtilityButtonsAnimated(true)
            }
            self.swipIndexPath = indexPath
        }else if state == .CellStateCenter{
             self.swipIndexPath = nil
        }
     }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerLeftUtilityButtonWithIndex index: Int) {
        cell.hideUtilityButtonsAnimated(true)

        let indexpath = self.tabV?.indexPathForCell(cell)
        
//        let objct = self.dataArr[(indexpath?.row)!]
        if index == 0{
             let vc = ZHZTestViewController()
             self.navigationController?.pushViewController(vc, animated: true)
        }else{
            ProgressHUD.show("")
            self.tabV?.beginUpdates()
self.dataArr.removeObjectAtIndex((indexpath?.row)!)
            self.tabV?.deleteRowsAtIndexPaths([indexpath!], withRowAnimation: .Left)
            
            self.tabV?.endUpdates()
        }
    }


    //选中行
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        self.tabV?.deselectRowAtIndexPath(indexPath, animated: true)

        if indexPath.row == self.dataArr.count - 1 {
        
        
            self.tableViewSelectScore()
            
         
        }else{let testVC = ZHZTestViewController()
            testVC.arr = self.dataArr
            testVC.bloc = MyBlock
            self.navigationController!.pushViewController(testVC, animated: true)
}
        
             }
     func MyBlock(sssss:String)->Void{
         print(sssss)
    }
     func next(){
        let testVC = ZHZTestViewController()
         testVC.title = "测试"
         testVC.arr = self.dataArr
         testVC.delegate = self
          self.navigationController? .pushViewController(testVC, animated: true)
      }
    func clickCurrentImg(index: Int) {
        print("点击的是第\(index)个视图")
    }
     func sendMsg(str: String) {
        print(str)
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
         let index = indexPath.row as Int
         self.dataArr.removeObjectAtIndex(index)
         self.tabV?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
     }
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath.row)
        
        cell.textLabel?.text = dataArr[indexPath.row] as? String
        cell.accessoryType = UITableViewCellAccessoryType.DetailDisclosureButton
     }
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let single = SingleOne()
        print(single.str)
        if single.str == nil{
        }else{
            print(single.str)
        }
    }
    
    
    /**
     *  选择评分
     */
    func tableViewSelectScore(){
        
        /**
        *  插入cell移除cell的动画
        */
        self.tabV?.beginUpdates()
        let tempIndexPath = [NSIndexPath(forRow: self.dataArr.count - 1, inSection: 0)]
        
        if self.showScore{
            self.dataArr.removeObjectAtIndex(self.dataArr.count - 1)
            self.tabV?.deleteRowsAtIndexPaths(tempIndexPath, withRowAnimation: .Right)
            self.showScore = false
        }else{
//            self.dataArr.insert("", atIndex: 2)
            self.dataArr.insertObject("", atIndex: self.dataArr.count - 1)
            self.tabV?.insertRowsAtIndexPaths(tempIndexPath, withRowAnimation: .Left)
            self.showScore = true
        }
        
        self.tabV?.endUpdates()
        
    }

    
    
}

