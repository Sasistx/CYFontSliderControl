//
//  ViewController.swift
//  CYFontSliderControl
//
//  Created by 高天翔 on 16/8/4.
//  Copyright © 2016年 CYGTX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let sliderControl = CYFontSliderControl.init(frame: CGRectMake(0, 400, self.view.frame.size.width, 100), titles: ["正常", "大", "特大", "超大"]) { (index) in
            
            print(index)
        }
        sliderControl.backgroundColor = UIColor.whiteColor()
        sliderControl.currentIndex = 1
        self.view.addSubview(sliderControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

