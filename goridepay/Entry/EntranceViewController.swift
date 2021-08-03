//
//  EntranceViewController.swift
//  goridepay
//
//  Created by Bryanza on 01/08/21.
//  Copyright © 2021 Apple Developer Academy. All rights reserved.
//

import UIKit

class EntranceViewController: UIViewController {

    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var slideLabel: UILabel!
    @IBOutlet weak var slideView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // swift
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        getTimestamp()
        cameraButton()
        animate()
        slideButton()
    }
    
    func animate() {
//        let x = 10
//        let y = 20

        var finalColor: UIColor!

//        if x > y {
//            finalColor = UIColor.blue
//        } else {
            finalColor = UIColor.white
//        }

        let changeColor = CATransition()
        changeColor.type = CATransitionType.fade
        changeColor.duration = 1.0
//        changeColor.autoreverses = true
//        changeColor.repeatCount = Float.greatestFiniteMagnitude

        CATransaction.begin()

        CATransaction.setCompletionBlock {
            self.slideLabel.textColor = UIColor.gray
            self.slideLabel.layer.add(changeColor, forKey: nil)
        }
        slideLabel.textColor = finalColor
        slideLabel.layer.add(changeColor, forKey: nil)

        CATransaction.commit()
    }
    
    func guideLabel() {
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector(("slideToUnlock")), userInfo: nil, repeats: true)
        slideToUnlock()
    }
    
    func slideToUnlock() {
        let colors = [
            UIColor(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
            UIColor(red: 1, green: 1, blue: 1, alpha: 1),
        ]
        let randomColor = Int(arc4random_uniform(UInt32 (colors.count)))
        slideLabel.textColor = colors[randomColor]
    }
    
    func slideButton() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(gestureRecognizer:)))
        slideImageView.addGestureRecognizer(gesture)
        slideImageView.isUserInteractionEnabled = true
        gesture.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
            let translation = gestureRecognizer.translation(in: self.view)
//            print(gestureRecognizer.view!.center.x)
            if (gestureRecognizer.view!.center.x >= 270) {
                self.navigationController!.pushViewController(LandingViewController(nibName: "LandingViewController", bundle: nil), animated: true)
            } else if (gestureRecognizer.view!.center.x < slideView.center.x * 2) {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x +  translation.x, y: gestureRecognizer.view!.center.y)
            }else {
                gestureRecognizer.view!.center = CGPoint(x: 23.5, y: gestureRecognizer.view!.center.y)
            }

            gestureRecognizer.setTranslation(CGPoint(x: 0,y: 0), in: self.view)
        }else if (gestureRecognizer.state == UIGestureRecognizer.State.ended) {
            if (gestureRecognizer.view!.center.x < 270) {
                gestureRecognizer.view!.center = CGPoint(x: 23.5, y: gestureRecognizer.view!.center.y)
            }else {
                self.navigationController!.pushViewController(LandingViewController(nibName: "LandingViewController", bundle: nil), animated: true)
            }
        }
    }
    
    func cameraButton() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cameraImageView.isUserInteractionEnabled = true
        cameraImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alertController = UIAlertController(title: nil, message: "Device has no camera.", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Alright", style: .default, handler: { (alert: UIAlertAction!) in
            })

            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            // Other action
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
        // Your action
    }
    
    func getTimestamp() {
        let now = Date()

        let formatter = DateFormatter()

        formatter.timeZone = TimeZone.current

        formatter.dateFormat = "HH:mm"

        var dateString = formatter.string(from: now)
        clockLabel.text = dateString
        
        formatter.dateFormat = "EEEE, MMMM dd"
        dateString = formatter.string(from: now)
        dateLabel.text = dateString
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
