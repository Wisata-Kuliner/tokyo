//
//  ChatViewController.swift
//  goridepay
//
//  Created by Bryanza on 05/08/21.
//  Copyright © 2021 Apple Developer Academy. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var chatSearchBar: UISearchBar!
    @IBOutlet weak var chatTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func editButton(_ sender: UIButton) {
        self.navigationController!.pushViewController(LandingViewController(nibName: "LandingViewController", bundle: nil), animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
