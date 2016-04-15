//
//  SingleOne.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/8.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import Foundation


class SingleTwo {
    var strrrr : String?

    //单例
    class func shareSingleTwo()->SingleTwo{
        
        struct Singleton{
            static var onceToken : dispatch_once_t = 0
            static var single:SingleTwo?
        }
        dispatch_once(&Singleton.onceToken,{
            Singleton.single=shareSingleTwo()
            }
        )
        return Singleton.single!
    }
    
}


class SingleOne {
 
    var str:String?
    
    var arrary = NSMutableArray()
     //单例
    static let shareSingleOne = SingleOne()
    
}

