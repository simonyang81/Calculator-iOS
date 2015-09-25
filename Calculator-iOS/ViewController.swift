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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.display                = UILabel()
        self.display!.textColor     = UIColor.blackColor()
//        self.display!.font          = UIFont(name: "HelveticaNeue", size: 14.0)
        self.display!.textAlignment = NSTextAlignment.Center
        self.display?.text          = "Simon's Calculator"
        
        view.addSubview(display!)
        
        constrain(display!) { view in
            view.centerX  == view.superview!.centerX
            view.leading == view.superview!.leading + 20
            view.trailing == view.superview!.trailing - 20
            view.top == view.superview!.top + 100
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
