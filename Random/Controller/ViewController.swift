//
//  ViewController.swift
//  Random
//
//  Created by sinbad on 3/14/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var breeds : [String] = ["A", "B"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.loader.isHidden = false 
        
        
    }
    
    
    func handleRequest(imageData: DogImage? , error: Error?){
        guard let imageURL = URL(string: imageData!.message) else {
            return
        }
        DogAPI.requestImageFile(url: imageURL, complitionHandler: self.handleRequest(image:error:))
        
    }
    
    
    func handleRequest(image: UIImage?, error: Error?)  {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage (completionHandler:  handleRequest(imageData:error:))
    }
    
    
}

