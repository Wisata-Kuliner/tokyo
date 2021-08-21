//
//  LandingViewController.swift
//  goridepay
//
//  Created by Bryanza on 01/08/21.
//  Copyright © 2021 Apple Developer Academy. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var reminderImageView: UIImageView!
    @IBOutlet weak var assitiveImageView: UIImageView!
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var cloudImageView: UIImageView!
    @IBOutlet weak var compassImageView: UIImageView!
    @IBOutlet weak var findImageView: UIImageView!
    @IBOutlet weak var assitiveView: UIView!
    @IBOutlet var dragView: UIView!
    @IBOutlet weak var safeView: UIImageView!
    @IBOutlet weak var lockImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        assitiveButton()
        cameraApp()
        messageApp()
        photoApp()
        cloudApp()
        exploreApp()
        gpsApp()
    }
    
    func gpsApp() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(friendsTapped(tapGestureRecognizer:)))
        findImageView.isUserInteractionEnabled = true
        findImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func friendsTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.navigationController!.pushViewController(PositionViewController(nibName: "PositionViewController", bundle: nil), animated: true)
    }
    
    func exploreApp() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(compassTapped(tapGestureRecognizer:)))
        compassImageView.isUserInteractionEnabled = true
        compassImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func compassTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.navigationController!.pushViewController(BrowserViewController(nibName: "BrowserViewController", bundle: nil), animated: true)
    }
    
    func cloudApp() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(cloudTapped(tapGestureRecognizer:)))
        cloudImageView.isUserInteractionEnabled = true
        cloudImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func cloudTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.navigationController!.pushViewController(MerchantViewController(nibName: "MerchantViewController", bundle: nil), animated: true)
    }
    
    func photoApp() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(libraryTapped(tapGestureRecognizer:)))
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func libraryTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func messageApp() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chatTapped(tapGestureRecognizer:)))
        messageImageView.isUserInteractionEnabled = true
        messageImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func chatTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.navigationController!.pushViewController(ChatViewController(nibName: "ChatViewController", bundle: nil), animated: true)
    }
    
    func cameraApp() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cameraImageView.isUserInteractionEnabled = true
        cameraImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alertController = UIAlertController(title: nil, message: "Device has no camera.", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Alright", style: .default, handler: { (alert: UIAlertAction!) in
            })

            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func assitiveButton() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(assitiveDrag(gestureRecognizer:)))
        assitiveImageView.addGestureRecognizer(gesture)
        assitiveImageView.isUserInteractionEnabled = true
        gesture.delegate = self as? UIGestureRecognizerDelegate
        
        let secondGesture = UITapGestureRecognizer(target: self, action: #selector(showAssitive(gestureRecognizer:)))
        assitiveImageView.addGestureRecognizer(secondGesture)
        secondGesture.delegate = self as? UIGestureRecognizerDelegate
        
        let resetGesture = UITapGestureRecognizer(target: self, action: #selector(hideAssitive(gestureRecognizer:)))
        dragView.addGestureRecognizer(resetGesture)
        dragView.isUserInteractionEnabled = true
        resetGesture.delegate = self as? UIGestureRecognizerDelegate
        
        let lockGesture = UITapGestureRecognizer(target: self, action: #selector(lockScreen(gestureRecognizer:)))
        lockImageView.addGestureRecognizer(lockGesture)
        lockImageView.isUserInteractionEnabled = true
        lockGesture.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc func lockScreen(gestureRecognizer: UITapGestureRecognizer) {
        self.navigationController!.pushViewController(EntranceViewController(nibName: "EntranceViewController", bundle: nil), animated: true)
    }
    
    @objc func showAssitive(gestureRecognizer: UITapGestureRecognizer) {
        if (assitiveView.isHidden) {
            assitiveView.isHidden = false
            assitiveImageView.isHidden = true
        }
    }
    
    @objc func hideAssitive(gestureRecognizer: UITapGestureRecognizer) {
        if (assitiveView.isHidden == false) {
            assitiveView.isHidden = true
            assitiveImageView.isHidden = false
        }
    }
    
    @objc func assitiveDrag(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
            let translation = gestureRecognizer.translation(in: self.view)
//            print(gestureRecognizer.view!.center.x, gestureRecognizer.view!.center.y)
            if (gestureRecognizer.view!.center.y > 65 && gestureRecognizer.view!.center.y < 835) {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            }
            gestureRecognizer.setTranslation(CGPoint(x: 0,y: 0), in: self.view)
        } else if (gestureRecognizer.state == UIGestureRecognizer.State.ended) {
            if (390 - gestureRecognizer.view!.center.x < gestureRecognizer.view!.center.x) {
                gestureRecognizer.view!.center = CGPoint(x: 390, y: gestureRecognizer.view!.center.y)
            }else {
                if (gestureRecognizer.view!.center.y - 65 < 30) {
                    gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: 75)
                } else if (835 - gestureRecognizer.view!.center.y < 30) {
                    gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: 830)
                } else if (390 - gestureRecognizer.view!.center.x >= gestureRecognizer.view!.center.x) {
                    gestureRecognizer.view!.center = CGPoint(x: 30, y: gestureRecognizer.view!.center.y)
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
