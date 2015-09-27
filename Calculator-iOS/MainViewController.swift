//
//  MainViewController.swift
//  Calculator-iOS
//
//  Created by Simon Yang on 9/27/15.
//  Copyright © 2015 Simon Yang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Practice"
        
        let rightBtn = UIBarButtonItem(title: "Calculator",
            style: UIBarButtonItemStyle.Plain,
            target:self,
            action: Selector("gotoCalculatorScreen:"))
        self.navigationItem.rightBarButtonItem = rightBtn
        
    }
    
    func gotoCalculatorScreen(sender: UIButton) {
        let vc = CalculatorViewController()
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
