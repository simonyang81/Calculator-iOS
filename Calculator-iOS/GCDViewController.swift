//
//  GCDViewController.swift
//  Calculator-iOS
//
//  Created by Simon Yang on 10/9/15.
//  Copyright © 2015 Simon Yang. All rights reserved.
//

import UIKit
import Cartography

class GCDViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title  = "Test GCD"
        
        print("Before - \(NSThread.currentThread())")
        
        let queue = dispatch_queue_create("simonist.Calculator-iOS", DISPATCH_QUEUE_SERIAL)
        
        dispatch_async(queue!) { () -> Void in
            
            for idx in 0 ..< 10000 {
                print("\(idx) ---> \(NSThread.currentThread())")
            }
            
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.navigationItem.title  = "Update Test GCD"
            })
            
        }
        
        print("After - \(NSThread.currentThread())")
        
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
