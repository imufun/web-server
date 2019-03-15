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
    enum Endpoint {
        
        case randomCollectionDogsCollections
        case randomIMageForBreed (String)
        case listAllBreeds
        
        var url : URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue : String {
            switch self{
            case .randomCollectionDogsCollections:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomIMageForBreed (let breeds):
                return "https://dog.ceo/api/breed/\(breeds)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    // LIST ALL BRANDS
    class func listALlBreeds(completionHandler: @escaping ([String], Error?)-> Void){
        
        let task = URLSession.shared.dataTask(with: DogAPI.Endpoint.listAllBreeds.url) { (data, response, error) in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            
            let decoder = JSONDecoder()
            
            let breedsResoinse = try! decoder.decode(DogList.self, from: data)
            let breeds = breedsResoinse.message.keys.map({ $0 })
            completionHandler(breeds,nil)
            
        }
        task.resume()
    }
    
    
    class func requestRandomImage(breeds: String, completionHandler: @escaping(DogImage?, Error?)-> Void){
        
        let radomImageEndpoint = DogAPI.Endpoint.randomIMageForBreed(breeds).url
        
        let task = URLSession.shared.dataTask(with: radomImageEndpoint) { (data, response, error) in
            
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(imageData, nil)
           
        }
        task.resume()
        
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
