//
//  PortfolioStorage.swift
//  MiPlatica
//
//  Created by Konstantin Portnov on 12/20/18.
//  Copyright © 2018 x0000ff. All rights reserved.
//

//############################################################
import Foundation

//############################################################
class PortfolioStorage {

    //--------------------------------------------------------
    // This method should load saved portfolio from secure storage.
    //
    // For now we just return some `hardcoded` data
    // TODO: Implement real storage
    //--------------------------------------------------------
    func load() -> Portfolio? {
        
        let portfolio = Portfolio()
        portfolio.assetShares = [
            AssetShares(realAssetId: "186", shares: 51.8675),
            AssetShares(realAssetId: "187", shares: 493.9358),
            AssetShares(realAssetId: "2072", shares: 1655.6884),
            AssetShares(realAssetId: "282", shares: 205.4709),
            AssetShares(realAssetId: "3285", shares: 418.8769),
        ]
        
        return portfolio
    }
    
    //--------------------------------------------------------
}

//############################################################
