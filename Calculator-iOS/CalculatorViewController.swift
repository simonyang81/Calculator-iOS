//
//  CalculatorViewController.swift
//  Calculator-iOS
//
//  Created by Simon Yang on 9/27/15.
//  Copyright © 2015 Simon Yang. All rights reserved.
//

import UIKit
import Cartography

class CalculatorViewController: UIViewController {

    var display: UILabel!
    // Which is equivalent to "var display: UILabel! = nil"
    // var display: UILabel? which is equivalent to "var display: UILabel? = nil", have to use '!' to unwrap optional type
    
    var btnArray = [UIButton]()
    var num0Btn = UIButton(type: UIButtonType.System)
    
    var userIsInTheMiddleOfTypingANumber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        可选类型 (Optional) 显式解析 和 隐式解析
//        let possibleString: String? = "An optional string."
//        let forcedString: String = possibleString! // 需要惊叹号来获取值
//        let assumedString: String! = "An implicitly unwrapped optional string."
//        let implicitString: String = assumedString // 不需要感叹号


        self.navigationItem.title  = "Calculator"
        self.navigationItem.leftBarButtonItem?.title = ""

        self.display               = UILabel()
        self.display.textColor     = UIColor.blackColor()
        self.display.font          = UIFont.systemFontOfSize(36.0)
        self.display.textAlignment = NSTextAlignment.Right
        self.display.text          = "0"
        
        view.addSubview(display)
        
        for idx in 0...8 {
            btnArray.append(UIButton(type: UIButtonType.System))
            btnArray[idx].setTitle("\(idx + 1)", forState: UIControlState.Normal)
            btnArray[idx].titleLabel!.font = UIFont.systemFontOfSize(24.0)
            
            view.addSubview(btnArray[idx])
            
            btnArray[idx].addTarget(self, action: Selector("appendDigit:"),
                forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        num0Btn.setTitle("0", forState: UIControlState.Normal)
        num0Btn.titleLabel!.font = UIFont.systemFontOfSize(24.0)
        view.addSubview(num0Btn)
        num0Btn.addTarget(self, action: Selector("appendDigit:"),
            forControlEvents: UIControlEvents.TouchUpInside)
        
        layoutViews()

    
    }
    
    func layoutViews() {
        
        constrain(display) { view in
            view.centerX  == view.superview!.centerX
            view.leading == view.superview!.leading + 20
            view.trailing == view.superview!.trailing - 20
            view.top == view.superview!.top + 70
        }
        
        constrain(btnArray[6], btnArray[7], btnArray[8], display) { view1, view2, view3, view4 in
            layoutButttons(view1, view2: view2, view3: view3, view4: view4)
        }
        
        constrain(btnArray[3], btnArray[4], btnArray[5], btnArray[6]) { view1, view2, view3, view4 in
            layoutButttons(view1, view2: view2, view3: view3, view4: view4)
        }
        
        constrain(btnArray[0], btnArray[1], btnArray[2], btnArray[3]) { view1, view2, view3, view4 in
            layoutButttons(view1, view2: view2, view3: view3, view4: view4)
        }
        
        constrain(num0Btn, btnArray[1]) { view1, view2 in
            view1.top == view2.bottom + 10
            view1.leading == view2.leading
            view1.trailing == view2.trailing
            
        }
        
        
    }
    
    func layoutButttons(view1: LayoutProxy, view2: LayoutProxy, view3: LayoutProxy, view4: LayoutProxy) {
        view1.top == view4.bottom + 10
        view2.top == view4.bottom + 10
        view3.top == view4.bottom + 10
        
        view1.leading   == view1.superview!.leading + 50
        view3.trailing  == view3.superview!.trailing  - 50
        
        view1.width == view2.width
        view2.width == view3.width
        
        view1.trailing  == view2.leading - 10
        view2.trailing  == view3.leading - 10
        
    }
    
    func appendDigit(sender: UIButton) {
        print("digit == \(sender.currentTitle!)" )
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + sender.currentTitle!
        } else {
            display.text = sender.currentTitle!
            userIsInTheMiddleOfTypingANumber = true
        }
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
