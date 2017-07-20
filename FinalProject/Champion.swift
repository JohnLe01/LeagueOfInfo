//
//  Champion.swift
//  FinalProject
//
//  Created by John Le on 7/19/17.
//  Copyright © 2017 John Le. All rights reserved.
//

import Foundation

class Champion {
    let name: String
    let title: String
    let championID: Int
    let photoURL: URL
    let armorperlevel: Double
    let attackdamage: Double
    let mpperlevel: Double
    let attackspeedoffset: Double
    let mp: Double
    let armor: Double
    let hp: Double
    let hpregenperlevel: Double
    let attackspeedperlevel: Double
    let attackrange: Double
    let movespeed: Double
    let attackdamageperlevel: Double
    let mpregenperlevel: Double
    let critperlevel: Double
    let spellblockperlevel: Double
    let crit: Double
    let mpregen: Double
    let spellblock: Double
    let hpregen: Double
    let hpperlevel: Double
    
    init(name: String, title: String, championID: Int, photoURL: URL,
         armorperlevel: Double, attackdamage: Double,
         mpperlevel: Double, attackspeedoffset: Double,
         mp: Double, armor: Double,
         hp: Double, hpregenperlevel: Double,
         attackspeedperlevel: Double, attackrange: Double,
         movespeed: Double, attackdamageperlevel: Double,
         mpregenperlevel: Double, critperlevel: Double,
         spellblockperlevel: Double, crit: Double,
         mpregen: Double, spellblock: Double,
         hpregen: Double, hpperlevel: Double) {
        
        self.name = name
        self.title = title
        self.championID = championID
        self.photoURL = photoURL
        self.armorperlevel = armorperlevel
        self.attackdamage = attackdamage
        self.mpperlevel = mpperlevel
        self.attackspeedoffset = attackspeedoffset
        self.mp = mp
        self.armor = armor
        self.hp = hp
        self.hpregenperlevel = hpregenperlevel
        self.attackspeedperlevel = attackspeedperlevel
        self.attackrange = attackrange
        self.movespeed = movespeed
        self.attackdamageperlevel = attackdamageperlevel
        self.mpregenperlevel = mpregenperlevel
        self.critperlevel = critperlevel
        self.spellblockperlevel = spellblockperlevel
        self.crit = crit
        self.mpregen = mpregen
        self.spellblock = spellblock
        self.hpregen = hpregen
        self.hpperlevel = hpperlevel
    }
}

extension Champion: Equatable {
    static func == (lhs: Champion, rhs: Champion) -> Bool {
        return lhs.championID == rhs.championID
    }
}
