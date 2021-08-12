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
        setPreference()
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
        let prefs = parameters.description
        print(prefs)
        //        let response = Transfer().callHeroku(
        //            session: session,
        //            address: "https://csui-bot-1.herokuapp.com/api/v1/login/",
        //            contentType: "x-www-form-urlencoded",
        //            parameters: parameters
        //        )
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
