//
//  ZHZTabbleViewCell.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/11.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit

class ZHZTabbleViewCell: SWTableViewCell {

    var headImg: UIImageView?
    var title: UILabel?
    var detleText:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style:UITableViewCellStyle,reuseIdentifier:String?){
         super.init(style:style,reuseIdentifier:reuseIdentifier)
          for view in self.contentView.subviews{
             view.removeFromSuperview()
        }
        
        self.title = UILabel(frame: CGRectMake(78,8,242,25))
        self.detleText = UILabel(frame: CGRectMake(78,33,242,25))
        
        
        self.title?.font = UIFont(name: MY_FONT, size: 15)
        self.detleText?.font = UIFont(name: MY_FONT, size: 15)
        
        self.contentView.addSubview(self.title!)
        self.contentView.addSubview(self.detleText!)
        
         self.headImg = UIImageView(frame: CGRectMake(8,9,56,70))
        self.contentView.addSubview(self.headImg!)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    

}
