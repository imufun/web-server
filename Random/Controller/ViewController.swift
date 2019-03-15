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
        var radomImageEndpoint = DogAPI.Endpoint.randomCollectionDogsCollections.url
        
        let task = URLSession.shared.dataTask(with: radomImageEndpoint) { (data, response, error) in
            
            self.loader.isHidden = true
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            
            guard let imageURL = URL(string: imageData.message) else {
                return
            }
            DogAPI.requestImageFile(url: imageURL, complitionHandler: { (image, error) in
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            })
            print(data)
        }
        task.resume()
        
    }
    
    
}

