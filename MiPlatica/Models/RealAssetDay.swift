//
//  RealAssetDay.swift
//  MiPlatica
//
//  Created by Konstantin Portnov on 12/20/18.
//  Copyright © 2018 x0000ff. All rights reserved.
//

//############################################################
import Foundation

//############################################################
struct RealAssetDay: Codable {
    let date: String
    let price: Double
    let fixedFee: Double
    let variableFee: Double
}

//############################################################
