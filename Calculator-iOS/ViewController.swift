//
//  ViewController.swift
//  Calculator-iOS
//
//  Created by Simon Yang on 9/24/15.
//  Copyright © 2015 Simon Yang. All rights reserved.
//

import UIKit
import Cartography

class ViewController: UIViewController {
    
    var display: UILabel?
    var btnArray = [UIButton]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title   = "Calculator"

        self.display                = UILabel()
        self.display!.textColor     = UIColor.blackColor()
        self.display!.font          = UIFont(name: "HelveticaNeue", size: 32.0)
        self.display!.textAlignment = NSTextAlignment.Right
        self.display?.text          = "0"
        
        view.addSubview(display!)
        
        for idx in 0...8 {
            btnArray.append(UIButton(type: UIButtonType.System))
            btnArray[idx].setTitle("\(idx + 1)", forState: UIControlState.Normal)
            view.addSubview(btnArray[idx])
        }
        
        layoutViews()

    }
    
    
    func layoutViews() {
        
        constrain(display!) { view in
            view.centerX  == view.superview!.centerX
            view.leading == view.superview!.leading + 20
            view.trailing == view.superview!.trailing - 20
            view.top == view.superview!.top + 70
        }
        
        constrain(btnArray[6], btnArray[7], btnArray[8], display!) { view1, view2, view3, view4 in
            layoutButttons(view1, view2: view2, view3: view3, view4: view4)
        }

        constrain(btnArray[3], btnArray[4], btnArray[5], btnArray[6]) { view1, view2, view3, view4 in
            layoutButttons(view1, view2: view2, view3: view3, view4: view4)
        }

        constrain(btnArray[0], btnArray[1], btnArray[2], btnArray[3]) { view1, view2, view3, view4 in
            layoutButttons(view1, view2: view2, view3: view3, view4: view4)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
