//
//  ChampionsViewController.swift
//  FinalProject
//
//  Created by John Le on 7/18/17.
//  Copyright © 2017 John Le. All rights reserved.
//

import UIKit

class ChampionsViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView!
    
    var store: ChampionStore!
    let championDataSource = ChampionDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = championDataSource
        collectionView.delegate = self
        
        store.fetchChampions {
            (championsResult) -> Void in
            
            switch championsResult {
            case let .success(champions):
                print("Successfully found \(champions.count) champions.")
                self.championDataSource.champions = champions
            case let .failure(error):
                print("Error fetching champions: \(error)")
                self.championDataSource.champions.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let champion = championDataSource.champions[indexPath.row]
        
        // Download the image data
        store.fetchChampionImage(for: champion) { (result) -> Void in
            
            guard let championIndex = self.championDataSource.champions.index(of: champion),
                case let .success(image) = result else {
                    return
            }
            let championIndexPath = IndexPath(item: championIndex, section: 0)
            
            if let cell = self.collectionView.cellForItem(at: championIndexPath) as? ChampionCollectionViewCell {
                cell.update(with: image)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto"?:
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                
                let champion = championDataSource.champions[selectedIndexPath.row]
                
                let destinationVC = segue.destination as! ChampionInfoViewController
                destinationVC.champion = champion
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}
