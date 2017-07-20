//
//  ChampionStore.swift
//  FinalProject
//
//  Created by John Le on 7/19/17.
//  Copyright © 2017 John Le. All rights reserved.
//

import UIKit

enum ChampionImageResult {
    case success(UIImage)
    case failure(Error)
}

enum ChampionError: Error {
    case championImageCreationError
}

enum ChampionsResult {
    case success([Champion])
    case failure(Error)
}

class ChampionStore {
    
    let imageStore = ImageStore()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private func processChampionImageRequest(data: Data?, error: Error?) -> ChampionImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                
                // Couldn't create an image
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(ChampionError.championImageCreationError)
                }
        }
        
        return .success(image)
    }
    
    func fetchChampionImage(for champion: Champion, completion: @escaping (ChampionImageResult) -> Void) {
        
        let photoKey = String(champion.championID)
        if let image = imageStore.image(forKey: photoKey) {
            OperationQueue.main.addOperation {
                completion(.success(image))
            }
            return
        }
        
        let photoURL = champion.photoURL
        let request = URLRequest(url: photoURL)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            let result = self.processChampionImageRequest(data: data, error: error)
            
            if case let .success(image) = result {
                self.imageStore.setImage(image, forKey: photoKey)
            }
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processChampionsRequest(data: Data?, error: Error?) -> ChampionsResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return RiotAPI.champions(fromJSON: jsonData)
    }
    
    func fetchChampions(completion: @escaping (ChampionsResult) -> Void) {
        let url = RiotAPI.championsURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
//            if let jsonData = data {
//                do {
//                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
//                    let jsonDictionary = jsonObject as? [AnyHashable:Any]
//                    let champions = jsonDictionary?["data"] as? [String:[String:Any]]
//                    for (_, championJSON) in champions! {
//                        let image = championJSON["image"] as? [String: Any]
//                        let full = image?["full"] as? String
//                        let stats = championJSON["stats"] as? [String: Any]
//                        let string = "http://ddragon.leagueoflegends.com/cdn/7.14.1/img/champion/" + full!
//                        print(championJSON)
//                        
//                    }
//                } catch let error {
//                    print("Error creating JSON object: \(error)")
//                }
//            } else if let requestError = error {
//                print("Error fetching champions: \(requestError)")
//            } else {
//                print("Unexpected error with the request")
//            }
            let result = self.processChampionsRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
}
