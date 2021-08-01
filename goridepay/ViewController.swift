//
//  ViewController.swift
//  goridepay
//
//  Created by Bryanza on 01/08/21.
//  Copyright © 2021 Apple Developer Academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController!.pushViewController(EntranceViewController(nibName: "EntranceViewController", bundle: nil), animated: true)
        // Register Nib
//        let entryViewController = EntranceViewController(nibName: "EntranceViewController", bundle: nil)

        // Present View "Modally"
//        self.present(entryViewController, animated: true, completion: nil)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        storyboard.instantiateViewController(withIdentifier: "EntranceViewController") as! EntranceViewController
    }


}

