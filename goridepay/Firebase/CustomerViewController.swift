//
//  CustomerViewController.swift
//  goridepay
//
//  Created by Bryanza on 12/08/21.
//  Copyright © 2021 Apple Developer Academy. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController {

    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var fashionImageView: UIImageView!
    @IBOutlet weak var lifestyleImageView: UIImageView!
    @IBOutlet weak var propertyImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        checkPreference()
        setPreference()
    }
    
    func checkPreference() {
//        let uuid = UIDevice.current.identifierForVendor!.uuidString
        var uuid = UUID().uuidString
        if (uuid != "8DBB1431-7503-4406-B1AD-D00408250727") {
            print("CANNOT USE UUID")
            uuid = "8DBB1431-7503-4406-B1AD-D00408250727"
        }
        let session = URLSession.shared
        Transfer().callHeroku(
            session: session,
            address: "https://product-goridepay.herokuapp.com/customers?id=" + uuid,
            contentType: "json",
            parameters: [:],
            requestMethod: "GET"
        ) {
            (responseArray, responseObject, responseString) in
                // parse array here
            if let prefs = responseArray[0]["prefs"] as? String {
                for i in 0..<prefs.split(separator: ",").count {
                    switch (prefs.split(separator: ",")[i]) {
                    case "1":
                        self.foodImageView.alpha = 0.5
                    case "2":
                        self.fashionImageView.alpha = 0.5
                    case "3":
                        self.lifestyleImageView.alpha = 0.5
                    case "4":
                        self.propertyImageView.alpha = 0.5
                    default:
                        continue
                    }
                }
            }
        }
    }
    
    func setPreference() {
        let foodGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(selectFood(tapGestureRecognizer:)))
        foodImageView.isUserInteractionEnabled = true
        foodImageView.addGestureRecognizer(foodGestureRecognizer)
        let fashionGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(selectFashion(tapGestureRecognizer:)))
        fashionImageView.isUserInteractionEnabled = true
        fashionImageView.addGestureRecognizer(fashionGestureRecognizer)
        let lifestyleGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(selectLifestyle(tapGestureRecognizer:)))
        lifestyleImageView.isUserInteractionEnabled = true
        lifestyleImageView.addGestureRecognizer(lifestyleGestureRecognizer)
        let propertyGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(selectProperty(tapGestureRecognizer:)))
        propertyImageView.isUserInteractionEnabled = true
        propertyImageView.addGestureRecognizer(propertyGestureRecognizer)
    }
    
    @objc func selectFood(tapGestureRecognizer: UITapGestureRecognizer) {
        if (foodImageView.alpha == 1) {
            foodImageView.alpha = 0.5
        }else {
            foodImageView.alpha = 1
        }
    }
    
    @objc func selectFashion(tapGestureRecognizer: UITapGestureRecognizer) {
        if (fashionImageView.alpha == 1) {
            fashionImageView.alpha = 0.5
        }else {
            fashionImageView.alpha = 1
        }
    }
    
    @objc func selectLifestyle(tapGestureRecognizer: UITapGestureRecognizer) {
        if (lifestyleImageView.alpha == 1) {
            lifestyleImageView.alpha = 0.5
        }else {
            lifestyleImageView.alpha = 1
        }
    }
    
    @objc func selectProperty(tapGestureRecognizer: UITapGestureRecognizer) {
        if (propertyImageView.alpha == 1) {
            propertyImageView.alpha = 0.5
        }else {
            propertyImageView.alpha = 1
        }
    }

    @IBAction func safePreferences(_ sender: UIButton) {
        var parameters: [String] = []
        if (foodImageView.alpha == 0.5) {
            parameters.append("1")
        }
        if (fashionImageView.alpha == 0.5) {
            parameters.append("2")
        }
        if (lifestyleImageView.alpha == 0.5) {
            parameters.append("3")
        }
        if (propertyImageView.alpha == 0.5) {
            parameters.append("4")
        }
//        let prefs = parameters.description
        let prefs = parameters.joined(separator: ",")
//        print(prefs)
        let session = URLSession.shared
        let requests: [String: String] = [
            "prefs": prefs
        ]
//        let uuid = UIDevice.current.identifierForVendor!.uuidString
        var uuid = UUID().uuidString
        if (uuid != "8DBB1431-7503-4406-B1AD-D00408250727") {
            print("CANNOT USE UUID")
            uuid = "8DBB1431-7503-4406-B1AD-D00408250727"
        }
        Transfer().callHeroku(
            session: session,
            address: "https://product-goridepay.herokuapp.com/customers/" + uuid,
//            contentType: "x-www-form-urlencoded",
            contentType: "json",
            parameters: requests,
            requestMethod: "PUT"
        ) {
            (responseArray, responseObject, responseString) in
            if (responseString.split(separator: " ").count > 1 &&
                responseString.split(separator: " ")[0] != "error") {
                DispatchQueue.main.async {
                    self.navigationController!.pushViewController(BroadcastTableViewController(nibName: "BroadcastTableViewController", bundle: nil), animated: true)
                }
            }
        }
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
