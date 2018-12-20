//
//  Portfolio.swift
//  MiPlatica
//
//  Created by Konstantin Portnov on 12/20/18.
//  Copyright © 2018 x0000ff. All rights reserved.
//

//############################################################
import Foundation

//############################################################
class Portfolio {
    var assetShares: [AssetShares] = [AssetShares]()
}

//############################################################
struct AssetShares {
    var realAssetId: String
    var shares: Double
}

//############################################################
