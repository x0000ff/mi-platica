//
//  RealAsset.swift
//  MiPlatica
//
//  Created by Konstantin Portnov on 12/20/18.
//  Copyright © 2018 x0000ff. All rights reserved.
//

//############################################################
import Foundation

//############################################################
struct RealAsset {
    let id: String
    let name: String
    let symbol: String
    let serie: String
    let days: [RealAssetDay]
}

//############################################################
extension RealAsset: Hashable {
    public var hashValue: Int { return id.hashValue }
}

//############################################################
extension RealAsset: Equatable {
    
}

//############################################################
func == (lhs: RealAsset, rhs: RealAsset) -> Bool {
    
    if lhs.id     != rhs.id     { return false }
    if lhs.name   != rhs.name   { return false }
    if lhs.symbol != rhs.symbol { return false }
    if lhs.serie  != rhs.serie  { return false }
    
    // if lhs.days   != rhs.days   { return false }
    
    return true
}

//############################################################
