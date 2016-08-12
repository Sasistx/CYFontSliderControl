//
//  CYSliderView.swift
//  CYFontSliderControl
//
//  Created by 高天翔 on 16/8/4.
//  Copyright © 2016年 CYGTX. All rights reserved.
//

import Foundation
import UIKit

class CYSliderView: UIView {
    
    var count = 0
    var originX : CGFloat = 40
    var originY : CGFloat = 0
    let thumbImageView = UIImageView.init(frame: CGRectMake(0, 0, 30, 30))
    
    var currentIdx = 0 {
        
        didSet{
            
            if (currentIdx != oldValue){
                
                self.updateThumbImagePosition(currentIdx)
            }
        }
    }
    
    var thumbImage = UIImage.init(named: "CY_thumbImage"){
        
        didSet{
            
            if (thumbImage != oldValue){
                
                thumbImageView.image = thumbImage
            }
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, titleCount: Int) {
        
        self.init(frame: frame)
        count = titleCount
        originY = frame.size.height / 2 - 10
        thumbImageView.image = UIImage.init(named: "CY_thumbImage")
        self.addSubview(thumbImageView)
        self.updateThumbImagePosition(0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, 1)
        CGContextSetAllowsAntialiasing(context, true)
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextSetStrokeColorWithColor(context, UIColor.init(red: 215 / 255.0, green: 226 / 255.0, blue: 232 / 255.0, alpha: 1).CGColor)
        CGContextBeginPath(context)
        
        CGContextMoveToPoint(context, originX, originY)
        CGContextAddLineToPoint(context, rect.size.width - originX, originY)
        CGContextStrokePath(context)
        
        for idx in 1...count {
            
            let indexPoint = self.getIndexPoint(idx - 1, frame: rect)
            CGContextMoveToPoint(context, indexPoint.x, indexPoint.y - 5)
            CGContextAddLineToPoint(context, indexPoint.x, indexPoint.y + 5)
            CGContextStrokePath(context)
        }
    }
    
// Mark: - 数据计算
    
    func updateThumbImagePosition(index: Int) {
        
        thumbImageView.center = self.getIndexPoint(index, frame: self.frame)
    }
    
    func getIndexPoint(index: Int, frame: CGRect) -> CGPoint {
        
        let divWidth = (frame.size.width - 2 * originX) / CGFloat((count - 1))
        return CGPointMake(originX + CGFloat(index) * divWidth, originY)
    }

}