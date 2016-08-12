//
//  CYFontSliderControl.swift
//  CYFontSliderControl
//
//  Created by 高天翔 on 16/8/4.
//  Copyright © 2016年 CYGTX. All rights reserved.
//

import Foundation
import UIKit

typealias CYFontSliderValueDidChanged = (index: Int) -> Void

class CYFontSliderControl: UIView {
    
    var titleArray = [String]()
    
    var count = 0
    var originX : CGFloat = 40
    var sliderView : CYSliderView!
    var titles = [String]()
    var changeBlock : CYFontSliderValueDidChanged?
    
    var currentIndex = 0 {
    
        didSet{
        
            if currentIndex != oldValue {
                
                sliderView.currentIdx = currentIndex
            }
        }
    }
    
    var thumbImage = UIImage.init() {
    
        didSet{
        
            if thumbImage != oldValue {
                
                sliderView.thumbImage = thumbImage
            }
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, titles: [String], valueDidChanged: CYFontSliderValueDidChanged) {
        
        self.init(frame: frame)
        titleArray = titles
        count = titleArray.count
        changeBlock = valueDidChanged
        let viewFrame = CGRectMake(0, frame.size.height / 2, frame.size.width, frame.size.height / 2)
        self.createSliderView(viewFrame)
        self.createTitle(viewFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func createSliderView(frame: CGRect) {
        
        sliderView = CYSliderView.init(frame: frame, titleCount: count)
        sliderView.backgroundColor = UIColor.clearColor()
        self.addSubview(sliderView)
    }
    
    func createTitle(frame: CGRect) {
        
        let titleCenterY = frame.size.height / 2 + 10
        
        for index in 1...count {
            
            let title = titleArray[index - 1]
            let titleLabel = UILabel.init(frame: CGRectZero)
            titleLabel.backgroundColor = UIColor.clearColor()
            titleLabel.text = title
            titleLabel.font = UIFont.systemFontOfSize(16)
            titleLabel.textColor = UIColor.init(red: 50 / 255.0, green: 50 / 255.0, blue: 50 / 255.0, alpha: 1)
            titleLabel.sizeToFit()
            self.addSubview(titleLabel)
            
            let titleLabelCenter = sliderView.getIndexPoint(index - 1, frame: frame)
            titleLabel.center = CGPointMake(titleLabelCenter.x, titleCenterY)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first
        let touchPoint = touch?.locationInView(self)
        self.updateSlider(self.checkIndex(touchPoint!))
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first
        let touchPoint = touch?.locationInView(self)
        self.updateSlider(self.checkIndex(touchPoint!))
    }
    
    func checkIndex(byPoint: CGPoint) -> Int {
        
        let pointX = byPoint.x - originX
        let sliderWidth = self.frame.size.width - 2 * originX
        let divWidth = sliderWidth / (CGFloat(count) - 1)
        var index = Int(pointX) / Int(divWidth)
        let div = pointX % divWidth
        if div > divWidth / 2 {
            
            index += 1
        }
        
        if index < 0 {
            
            index = 0
        }
        
        if index > count {
            
            index = count
        }
        
        return index
    }
    
    func updateSlider(index: Int) {
        
        guard index != currentIndex else {
        
            return
        }
        
        currentIndex = index
        sliderView.currentIdx = index
        if let sliderChangeBlock = changeBlock {
            
            sliderChangeBlock(index: index)
        }
    }
}