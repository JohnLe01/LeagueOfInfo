//
//  ChampionDataSource.swift
//  FinalProject
//
//  Created by John Le on 7/19/17.
//  Copyright © 2017 John Le. All rights reserved.
//

import UIKit

class ChampionDataSource: NSObject, UICollectionViewDataSource {
    var champions = [Champion]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return champions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "ChampionCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ChampionCollectionViewCell
        
        return cell
    }
}
