//
//  RealAssetDayParser.swift
//  MiPlatica
//
//  Created by Konstantin Portnov on 12/20/18.
//  Copyright © 2018 x0000ff. All rights reserved.
//

//############################################################
import Foundation

//############################################################
class RealAssetDayParser {
    
    //--------------------------------------------------------
    static func parse(fromData json:Dictionary<String, Any>) -> RealAssetDay? {
        
        guard let date        = json["date"]         as? String else { return nil }
        guard let price       = json["price"]        as? Double else { return nil }
        guard let fixedFee    = json["fixed_fee"]    as? Double else { return nil }
        guard let variableFee = json["variable_fee"] as? Double else { return nil }
        
        return RealAssetDay(date: date, price: price, fixedFee: fixedFee, variableFee: variableFee)
    }
    
    //--------------------------------------------------------
}

//############################################################
