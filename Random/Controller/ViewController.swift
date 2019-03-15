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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loader.isHidden = false 
        DogAPI.requestRandomImage (completionHandler:  handleRequest(imageData:error:))
        
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

