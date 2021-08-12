//
//  MerchantViewController.swift
//  goridepay
//
//  Created by Bryanza on 12/08/21.
//  Copyright © 2021 Apple Developer Academy. All rights reserved.
//

import UIKit

class MerchantViewController: UIViewController {

    @IBOutlet weak var splashImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        splashScreen()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let parameters: [String: String] = [
            "username": emailTextField.text ?? "",
            "password": passwordTextField.text ?? ""
        ]
        let session = URLSession.shared
        Transfer().callHeroku(
            session: session,
            address: "https://product-goridepay.herokuapp.com/login/",
            contentType: "json",
            parameters: parameters) {
                (response) in
                if (response.split(separator: " ").count > 1 &&
                    response.split(separator: " ")[0] != "error") {
                    DispatchQueue.main.async {
                        self.navigationController!.pushViewController(CustomerViewController(nibName: "CustomerViewController", bundle: nil), animated: true)
                    }
                }
            }
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        self.navigationController!.pushViewController(LandingViewController(nibName: "LandingViewController", bundle: nil), animated: true)
    }
    
    func splashScreen() {
//        self.splashImageView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 2, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
//            self.backgroundView.backgroundColor = UIColor(red: 35, green: 94, blue: 110, alpha: 1)
            self.splashImageView.alpha = 0
            self.backgroundImageView.alpha = 1
        }, completion: { finished in
            self.splashImageView.isHidden = true
            self.backgroundImageView.isHidden = false
            self.contentView.isHidden = false
//            self.splashImageView.image = #imageLiteral(resourceName: "highlight")
            self.backgroundView.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.9137254902, blue: 0.937254902, alpha: 1)
//            self.backgroundView.backgroundColor = UIColor(red: 228, green: 233, blue: 239, alpha: 255)
        })
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
