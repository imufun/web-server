//
//  DogAPI.swift
//  Random
//
//  Created by sinbad on 3/14/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint: String {
        case randomCollectionDogsCollections = "https://dog.ceo/api/breeds/image/random"
        var url : URL {
            return URL(string: self.rawValue)!
        }
    }
    
    
    class func requestImageFile(url : URL, complitionHandler: @escaping(UIImage?, Error?)-> Void){
        let task =   URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                return
            } else {
                print(error?.localizedDescription as Any)
            }
            guard let data = data else {
                 complitionHandler(nil, error)
                return
            }
            
            let downloadImage = UIImage(data: data)
            complitionHandler(downloadImage, nil)
        })
        task.resume()
    }
}
