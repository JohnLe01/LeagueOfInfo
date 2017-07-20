//
//  ChampionInfoViewController.swift
//  FinalProject
//
//  Created by John Le on 7/19/17.
//  Copyright © 2017 John Le. All rights reserved.
//

import UIKit

class ChampionInfoViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var healthRegenLabel: UILabel!
    @IBOutlet var manaLabel: UILabel!
    @IBOutlet var manaRegenLabel: UILabel!
    @IBOutlet var rangeLabel: UILabel!
    @IBOutlet var attackLabel: UILabel!
    @IBOutlet var attackSpeedLabel: UILabel!
    @IBOutlet var armorLabel: UILabel!
    @IBOutlet var magicResistLabel: UILabel!
    @IBOutlet var moveSpeedLabel: UILabel!
    @IBOutlet var hpLabel: UILabel!

    
    var champion: Champion! {
        didSet {
            navigationItem.title = champion.name
        }
    }
    var store: ChampionStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchChampionImage(for: champion) { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
        
        hpLabel.text = "\(String(champion.hp)) (+\(String(champion.hpperlevel)) / level)"
        healthRegenLabel.text = "\(String(champion.hpregen)) (+\(String(champion.hpregenperlevel)) / level)"
        manaLabel.text = "\(String(champion.mp)) (+\(String(champion.mpperlevel)) / level)"
        manaRegenLabel.text = "\(String(champion.mpregen)) (+\(String(champion.mpregenperlevel)) / level)"
        rangeLabel.text = String(champion.attackrange)
        attackLabel.text = "\(String(champion.attackdamage)) (+\(String(champion.attackdamageperlevel)) / level)"
        attackSpeedLabel.text = "\(String(0.625 + champion.attackspeedoffset)) (+\(String(champion.attackspeedperlevel)) / level)"
        armorLabel.text = "\(String(champion.armor)) (+\(String(champion.armorperlevel)) / level)"
        magicResistLabel.text = "\(String(champion.spellblock)) (+\(String(champion.spellblockperlevel)) / level)"
        moveSpeedLabel.text = String(champion.movespeed)
        nameLabel.text = champion.name
        nameLabel.sizeToFit()
        titleLabel.text = champion.title
        titleLabel.sizeToFit()
    }
}
