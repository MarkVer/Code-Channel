//
//  ViewController.swift
//  CodingApp
//
//  Created by Jasper Stokman on 02/03/16.
//  Copyright © 2016 Jasper Stokman. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBAction func backButton(sender: AnyObject) {
        let profiel = self.storyboard!.instantiateViewControllerWithIdentifier("TapVC")
        self.navigationController?.pushViewController(profiel, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    }



