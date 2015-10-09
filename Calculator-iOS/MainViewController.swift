//
//  MainViewController.swift
//  Calculator-iOS
//
//  Created by Simon Yang on 9/27/15.
//  Copyright © 2015 Simon Yang. All rights reserved.
//

import UIKit
import Cartography

class MainViewController: UIViewController {

    let gcdBtn = UIButton(type: UIButtonType.System)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Practice"
        
        let rightBtn = UIBarButtonItem(title: "Calculator",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: Selector("gotoCalculatorScreen:"))
        self.navigationItem.rightBarButtonItem = rightBtn
                
        gcdBtn.setTitle("测试GCD", forState: UIControlState.Normal)
        gcdBtn.titleLabel!.font = UIFont.systemFontOfSize(26.0)
        view.addSubview(gcdBtn)
        gcdBtn.addTarget(self, action: Selector("gotoGCDController:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        constrain(gcdBtn) { view in
            view.centerX    == view.superview!.centerX
            view.leading    == view.superview!.leading + 20
            view.trailing   == view.superview!.trailing - 20
            view.top        == view.superview!.top + 100
        }
        
        
    }
    
    func gotoCalculatorScreen(sender: UIButton) {
        let vc = CalculatorViewController()
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func gotoGCDController(sender: UIButton) {
        let vc = GCDViewController()
        self.navigationController!.pushViewController(vc, animated: true)
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
