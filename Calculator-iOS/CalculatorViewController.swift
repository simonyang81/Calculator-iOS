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
    
    var btnArray     = [UIButton]()
    var operandStack = [Double]()
    
    var enterBtn     = UIButton(type: UIButtonType.System)
    var multipBtn    = UIButton(type: UIButtonType.System)
    var diviBtn      = UIButton(type: UIButtonType.System)
    var additionBtn  = UIButton(type: UIButtonType.System)
    var subBtn       = UIButton(type: UIButtonType.System)
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var brain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        可选类型 (Optional) 显式解析 和 隐式解析
//        let possibleString: String? = "An optional string."
//        let forcedString: String = possibleString! // 需要惊叹号来获取值
//        let assumedString: String! = "An implicitly unwrapped optional string."
//        let implicitString: String = assumedString // 不需要感叹号

        self.navigationItem.title  = "Calculator"
//        self.navigationItem.leftBarButtonItem?.title = ""

        self.display               = UILabel()
        self.display.textColor     = UIColor.blackColor()
        self.display.font          = UIFont.systemFontOfSize(36.0)
        self.display.textAlignment = NSTextAlignment.Right
        self.display.text          = "0"
        
        view.addSubview(display)
        
        for idx in 0...9 {
            btnArray.append(UIButton(type: UIButtonType.System))
            btnArray[idx].setTitle("\(idx)", forState: UIControlState.Normal)
            btnArray[idx].titleLabel!.font = UIFont.systemFontOfSize(28.0)
            
            view.addSubview(btnArray[idx])
            
            btnArray[idx].addTarget(self, action: Selector("appendDigit:"),
                forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        enterBtn.setTitle("⏎", forState: UIControlState.Normal)
        enterBtn.titleLabel!.font = UIFont.systemFontOfSize(28.0)
        view.addSubview(enterBtn)
        enterBtn.addTarget(self, action: Selector("enter:"),
            forControlEvents: UIControlEvents.TouchUpInside)

        initArithmeticButton(multipBtn,     opera: "×");
        initArithmeticButton(diviBtn,       opera: "÷");
        initArithmeticButton(additionBtn,   opera: "+");
        initArithmeticButton(subBtn,        opera: "−");
        
        layoutViews()
    
    }
    
    func initArithmeticButton(btn: UIButton, opera: String) {
        btn.setTitle(opera, forState: UIControlState.Normal)
        btn.titleLabel!.font = UIFont.systemFontOfSize(28.0)
        view.addSubview(btn)
        btn.addTarget(self, action: Selector("operate:"),
            forControlEvents: UIControlEvents.TouchUpInside)

    }
    
    func layoutViews() {
        
        constrain(display) { view in
            view.centerX    == view.superview!.centerX
            view.leading    == view.superview!.leading + 20
            view.trailing   == view.superview!.trailing - 20
            view.top        == view.superview!.top + 70
        }
        
        constrain(btnArray[7], btnArray[8], btnArray[9], multipBtn, display) { view1, view2, view3, view4, view5 in
            layoutButttons(view1, view2: view2, view3: view3, view4: view4, view5: view5)
        }
        
        constrain(btnArray[4], btnArray[5], btnArray[6], diviBtn, btnArray[7]) { view1, view2, view3, view4, view5 in
            layoutButttons(view1, view2: view2, view3: view3, view4: view4, view5: view5)
        }
        
        constrain(btnArray[1], btnArray[2], btnArray[3], additionBtn, btnArray[4]) { view1, view2, view3, view4, view5 in
            layoutButttons(view1, view2: view2, view3: view3, view4: view4, view5: view5)
        }
        
        constrain(btnArray[0], btnArray[2]) { view1, view2 in
            layoutButttons(view1, view2: view2)
        }
        
        constrain(enterBtn, btnArray[3]) {view1, view2 in
            layoutButttons(view1, view2: view2)
        }
        
        constrain(subBtn, additionBtn) { view1, view2 in
            layoutButttons(view1, view2: view2)
        }

        
    }
    
    func layoutButttons(view1: LayoutProxy, view2: LayoutProxy) {
        view1.top       == view2.bottom + 10
        view1.leading   == view2.leading
        view1.trailing  == view2.trailing

    }
    
    func layoutButttons(view1: LayoutProxy, view2: LayoutProxy,
        view3: LayoutProxy, view4: LayoutProxy, view5: LayoutProxy) {
        
        view1.top == view5.bottom + 10
        view2.top == view5.bottom + 10
        view3.top == view5.bottom + 10
        view4.top == view5.bottom + 10
           
        view1.leading   == view1.superview!.leading + 50
        view4.trailing  == view3.superview!.trailing  - 50
        
        view1.width == view2.width
        view2.width == view3.width
        view3.width == view4.width
        
        view1.trailing  == view2.leading - 10
        view2.trailing  == view3.leading - 10
        view3.trailing  == view4.leading - 10
        
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
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    func enter(sender: UIButton) {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        
        
//        operandStack.append(displayValue)
//        
//        print("operandStack == \(operandStack)")
    }
    
    func operate(sender: UIButton) {
//        let opetation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter(sender)
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
            
        }
        
        
//        switch opetation {
//            case "×":
//                performOperation(sender) { $0 * $1 }
//            
//            case "÷":
//                performOperation(sender) { $1 / $0 }
//
//            case "+":
//                performOperation(sender) { $0 + $1 }
//            
//            case "−":
//                performOperation(sender) { $1 - $0 }
//            
//            default: break
//        }
    }

    func performOperation(sender: UIButton, operation: (Double, Double) -> Double) {
        
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter(sender)
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
