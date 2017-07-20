//
//  RiotAPI.swift
//  FinalProject
//
//  Created by John Le on 7/19/17.
//  Copyright © 2017 John Le. All rights reserved.
//

import Foundation

enum RiotError: Error {
    case invalidJSONData
}

enum Locale: String {
    case enUs = "en_US"
}

struct RiotAPI {
    private static let baseURLString = "https://na1.api.riotgames.com/lol/static-data/v3/champions"
    private static let baseImageURLString = "https://ddragon.leagueoflegends.com/cdn/7.14.1/img/champion/"
    private static let apiKey = "YOUR API KEY HERE"
    
    static var championsURL: URL {
        return riotURL(locale: .enUs, tags: ["image", "stats"])
    }
    
    private static func champion(fromJSON json: [String : Any]) -> Champion? {
        guard
            let name = json["name"] as? String,
            let title = json["title"] as? String,
            let championID = json["id"] as? Int,
        
            let image = json["image"] as? [String: Any],
            let imageFull = image["full"] as? String,
            let photo = baseImageURLString + imageFull as String?,
            let photoURL = URL(string: photo),
        
            let stats = json["stats"] as? [String: Any],
            let armorperlevel = stats["armorperlevel"] as? Double,
            let attackdamage = stats["attackdamage"] as? Double,
            let mpperlevel = stats["mpperlevel"] as? Double,
            let attackspeedoffset = stats["attackspeedoffset"] as? Double,
            let mp = stats["mp"] as? Double,
            let armor = stats["armor"] as? Double,
            let hp = stats["hp"] as? Double,
            let hpregenperlevel = stats["hpregenperlevel"] as? Double,
            let attackspeedperlevel = stats["attackspeedperlevel"] as? Double,
            let attackrange = stats["attackrange"] as? Double,
            let movespeed = stats["movespeed"] as? Double,
            let attackdamageperlevel = stats["attackdamageperlevel"] as? Double,
            let mpregenperlevel = stats["mpregenperlevel"] as? Double,
            let critperlevel = stats["critperlevel"] as? Double,
            let spellblockperlevel = stats["spellblockperlevel"] as? Double,
            let crit = stats["crit"] as? Double,
            let mpregen = stats["mpregen"] as? Double,
            let spellblock = stats["spellblock"] as? Double,
            let hpregen = stats["hpregen"] as? Double,
            let hpperlevel = stats["hpperlevel"] as? Double else {
                
                // Don't have enough information to construct a champion
                return nil
        }
        
        return Champion(name: name, title: title, championID: championID, photoURL: photoURL,
                        armorperlevel: armorperlevel, attackdamage: attackdamage,
                        mpperlevel: mpperlevel, attackspeedoffset: attackspeedoffset,
                        mp: mp, armor: armor, hp: hp, hpregenperlevel: hpregenperlevel,
                        attackspeedperlevel: attackspeedperlevel, attackrange: attackrange,
                        movespeed: movespeed, attackdamageperlevel: attackdamageperlevel,
                        mpregenperlevel: mpregenperlevel, critperlevel: critperlevel,
                        spellblockperlevel: spellblockperlevel, crit: crit,
                        mpregen: mpregen, spellblock: spellblock, hpregen: hpregen,
                        hpperlevel: hpperlevel)
    }
    
    static func champions(fromJSON data: Data) -> ChampionsResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            print(jsonObject)
            guard
                let jsonDictionary = jsonObject as? [AnyHashable:Any],
                let champions = jsonDictionary["data"] as? [String:[String:Any]] else {
    
                    // JSON structure does not meet our expectations
                    return .failure(RiotError.invalidJSONData)
            }
            
            var championsList = [Champion]()
            for (_, championJSON) in champions {
                if let champion = champion(fromJSON: championJSON) {
                    championsList.append(champion)
                }
            }
            
            if championsList.isEmpty && !champions.isEmpty {
                // Was not able to parse any of the champions
                return .failure(RiotError.invalidJSONData)
            }
            
            championsList.sort { $0.name < $1.name }
            
            return .success(championsList)
        } catch let error {
            return .failure(error)
        }
    }
    
    private static func riotURL(locale: Locale,
                                tags: Set<String>?) -> URL {
        var components = URLComponents(string: baseURLString)!
        
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "locale": locale.rawValue,
            "dataById": "false",
            "api_key": apiKey
        ]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalTags = tags {
            for tag in additionalTags {
                let item = URLQueryItem(name: "tags", value: tag)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        
        return components.url!
    }
}
