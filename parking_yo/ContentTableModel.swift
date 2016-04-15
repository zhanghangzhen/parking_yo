//
//  ContentTableModel.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/12.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit


class Article: NSObject {
    var userName: String?
//    var articleTitle: String?
//    var previewImageStr: String?
//    var timeValue: String?
//    var readNumber: NSNumber?
//    var commentNumber: NSNumber?
//    var favorNumber: NSNumber?
    
}

protocol Repository{
    var pageID: Int? { get }
    //func loadInfoList(pageID: Int)->[Article]
    func loadInfoList(pageID: Int,moreArticlePage: Int)->[Article]
}

class ArticleRepository: Repository {
    
    var pageID: Int?
    var articleArray: NSArray?
    var emptyResult: NSMutableArray = []
    
    func loadInfoList(pageID: Int,moreArticlePage: Int)->[Article]{
//        let query = AVQuery(className: "FindContentModel")
//        query.whereKey("pageID", equalTo: pageID)
//        query.addDescendingOrder("updatedAt")
//        query.skip = 8 * (moreArticlePage - 1)
//        query.limit = 8
//        let jsonResult = query.findObjects()
//        guard jsonResult != nil else{
//            return emptyResult as! [Article]
//        }
//        let jsonArray = jsonResult as NSArray
//        articleArray = Article.mj_objectArrayWithKeyValuesArray(jsonArray.valueForKey("localData"))
        articleArray = NSMutableArray()
        for index in 0..<10{
//            emptyResult.addObject(String(index))
            let model = Article()
            model.userName = String(index)
             emptyResult.addObject(model)
        }
        articleArray = NSArray(array: emptyResult)
        return articleArray! as! [Article]
    }
}


class ContentTableModel: NSObject {

}
