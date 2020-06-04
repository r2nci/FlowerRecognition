//
//  ViewController.swift
//  FlowerRecognition
//
//  Created by Ramazan ikinci on 14.04.2020.
//  Copyright © 2020 Ramazan ikinci. All rights reserved.
//

import UIKit
import CoreML
import Vision


class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    
    // MARK: VAR   AND LET
    var detailVC = FlowersDetailViewController()
    var network = Network()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var flowerNameLabel: UILabel!
    var pickedImage : UIImage?
    var flowerName = ""
    let imagePicker = UIImagePickerController()
    var acıklama = ""
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        detect(flowerImage: CIImage(image: imageView.image!)!)
        print(network.wikipediRequest())
        acıklama = network.wikipediRequest()
    
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert image to CIImage.")
            }
            
            pickedImage = userPickedImage
            imageView.image = pickedImage
            
            detect(flowerImage: ciImage)
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func photoGalleryButtonAction(_ sender: UIButton) {
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func detect(flowerImage: CIImage) {
        
        
        guard let model = try? VNCoreMLModel(for: cicekMlModel7().model) else {
            fatalError("Can't load model")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let result = request.results?.first as? VNClassificationObservation else {
                fatalError("Could not complete classfication")
            }
            
            self.flowerNameLabel.text = result.identifier.capitalized
            self.flowerName = result.identifier.capitalized
            
        }
        
        
        
        let handler = VNImageRequestHandler(ciImage: flowerImage)
        
        do {
            try handler.perform([request])
            
        }
        catch {
            print(error)
        }
        
        
        
    }
    
    
    @IBAction func detailPageButton(_ sender: UIButton) {
        
        
        let sb = (storyboard?.instantiateViewController(identifier: "detailPage"))! as FlowersDetailViewController
        sb.flowerName = flowerName
        network.flowerName=flowerName
//        sb.acıklama = acıklama
        present(sb, animated: true, completion: nil)
    }
    
    
    
}
