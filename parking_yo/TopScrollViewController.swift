
//
//  TopScrollViewController.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/12.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit

class TopScrollViewController: UIViewController,TopScrollViewDelegate{
    var type: ThemeScrollViewtype?
    var lastClickedLabelTag: Int = 0  // 最后一次被选中的按钮的tag
    lazy var themeDataModel: FindScrolllViewModel = FindScrolllViewModel()
    
    
    init(type: ThemeScrollViewtype) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func loadView() {
        super.loadView()
        view = TopScrollView(delegate: self)
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

}
// MARK: - 实现TopScrollViewDelegate协议
extension TopScrollViewController {
    func labelTitleArray() -> [String]?{
        switch type {
        case .Some(.Article): return themeDataModel.articleViewTitles
        case .Some(.Subject): return themeDataModel.subjectViewTitles
        default: return []
        }
    }
     func labelClicked(recognizer: UITapGestureRecognizer){
        let controller = parentViewController as? ThemeScrollVC
        controller?.labelClicked(recognizer)
        lastClickedLabelTag = recognizer.view!.tag
    }
}
// MARK: - 处理父ViewController请求
extension TopScrollViewController {
    func updateLabelsWithPurpleIndex(index: Int) {
        if let view = view as? TopScrollView {
            for label in (view.topScroll.subviews[0].subviews as? [UILabel])! {
                if label.tag == index {
                    label.transform = CGAffineTransformMakeScale(1.1,1.1)
                    label.textColor = UIColor.purpleColor()
                }
                else {
                    label.transform = CGAffineTransformMakeScale(1,1)
                    label.textColor = UIColor.blackColor()
                }
            }
        }
    }
}

