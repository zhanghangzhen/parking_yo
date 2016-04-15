//
//  ScrollViewLoop.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/8.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit
class ScrollViewLoop: UIView,UIScrollViewDelegate {
    var ImgUrl = NSMutableArray()
    private var count = 0
    var delegate : circleViewDelegate?
    private var imgv : UIImageView?
    private var scrollView : UIScrollView?
    private var pageControl : UIPageControl?
    private var timer : NSTimer?
    func buildUI(ImgUrls:NSMutableArray){
        ImgUrl .addObjectsFromArray(ImgUrls as [AnyObject])
         scrollView = UIScrollView(frame: self.frame)
        scrollView!.delegate = self
        self.addSubview(scrollView!)
        scrollView!
            .contentSize = CGSizeMake(CGFloat(Float(self.frame.width) * Float(ImgUrls.count)), self.frame.height)
         scrollView!.pagingEnabled = true
         scrollView!.showsHorizontalScrollIndicator = true
         scrollView!.bounces = true
         let crect = CGRectMake(self.frame.width/2 - CGFloat(30 * ImgUrls.count)/2, self.frame.size.height - 40, CGFloat(30 * ImgUrls.count), 20)
          pageControl = UIPageControl(frame:crect)
          self.addSubview(pageControl!)
         pageControl!.currentPage = 0
        pageControl!.numberOfPages = ImgUrls.count
        pageControl!.currentPageIndicatorTintColor = UIColor.redColor()
        pageControl!.pageIndicatorTintColor = UIColor(red: 1, green: 1, blue: 0.5, alpha: 0.8)
        pageControl!.userInteractionEnabled = false
         for index in 1...(ImgUrls.count){
            imgv = UIImageView()
         imgv!.frame = CGRectMake(CGFloat(Float(index-1) * Float(self.frame.width)) , 0, self.frame.width, self.frame.height)
            scrollView!.addSubview(imgv!)
            imgv!.image = ImgUrls.objectAtIndex(index - 1) as? UIImage
              imgv!.tag = index
             let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("imageGestureTap:"))
             tap.numberOfTapsRequired = 1
            tap.numberOfTouchesRequired = 1
            imgv!.userInteractionEnabled = true
            imgv!.addGestureRecognizer(tap)
         }
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "timerAction", userInfo: nil, repeats: true)
        NSRunLoop().addTimer(self.timer!, forMode: NSDefaultRunLoopMode)
     }
     func imageGestureTap(tap:UITapGestureRecognizer){
     
         if delegate != nil{
             delegate?.clickCurrentImg((tap.view?.tag)!)
        }
     }
    //定时器
     func timerAction(){
         if count >= ImgUrl.count{
        count = 0
         }
        pageControl?.currentPage = count
         scrollView?.setContentOffset(CGPointMake(CGFloat(Float(self.frame.size.width) * Float(count)), 0), animated: true)
         count++
     }
      func scrollViewDidScroll(scrollView: UIScrollView) {
//         print(scrollView.contentOffset.x)
         if count >= ImgUrl.count{
             count = 0
        }
            pageControl?.currentPage = Int(scrollView.contentOffset.x/self.frame.size.width)
          count++
      }
     override func drawRect(rect: CGRect) {
         super.drawRect(rect)
     }
}
//协议 点击照片的代理
 protocol circleViewDelegate {
     func clickCurrentImg(index:Int)
 }


 




