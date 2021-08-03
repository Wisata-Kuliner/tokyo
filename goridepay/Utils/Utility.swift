//
//  Utility.swift
//  goridepay
//
//  Created by Bryanza on 02/08/21.
//  Copyright © 2021 Apple Developer Academy. All rights reserved.
//

import UIKit

class Utility: UIViewController, UINavigationControllerDelegate {

    var imageTake: UIImageView!
    var imagePicker: UIImagePickerController!
    
    enum ImageSource {
       case photoLibrary
       case camera
    }

    override func viewDidLoad() {
       super.viewDidLoad()
    }
    
    //MARK: - Take image
    @IBAction func takePhoto(_ sender: UIButton) {
       guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
           selectImageFrom(.photoLibrary)
           return
       }
       selectImageFrom(.camera)
    }
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        switch source {
        case .camera:
           imagePicker.sourceType = .camera
        case .photoLibrary:
           imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }

    //MARK: - Saving Image here
    @IBAction func save(_ sender: AnyObject) {
       guard let selectedImage = imageTake.image else {
           print("Image not found!")
           return
       }
       UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
       if let error = error {
           // we got back an error!
           showAlertWith(title: "Save error", message: error.localizedDescription)
       } else {
           showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
       }
    }

    func showAlertWith(title: String, message: String){
       let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
       ac.addAction(UIAlertAction(title: "OK", style: .default))
       present(ac, animated: true)
    }
}

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension Utility: UIImagePickerControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        imageTake.image = selectedImage
    }
}
