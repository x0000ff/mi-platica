//
//  RealAssetParser.swift
//  MiPlatica
//
//  Created by Konstantin Portnov on 12/20/18.
//  Copyright © 2018 x0000ff. All rights reserved.
//

//############################################################
import Foundation

//############################################################
class RealAssetParser {
    
    //--------------------------------------------------------
    static func parse(fromData json:Dictionary<String, Any>) -> RealAsset? {
        
        guard let data = json["data"] as? Dictionary<String, Any> else { return nil }
        guard let id   = data["id"]   as? String                  else { return nil }
        
        guard let attributes = data["attributes"]   as? [String:Any] else { return nil }
        
        guard let name       = attributes["name"]   as? String else { return nil }
        guard let symbol     = attributes["symbol"] as? String else { return nil }
        guard let serie      = attributes["serie"]  as? String else { return nil }
        
        var days = [RealAssetDay]()
        
        if let lastDayJSON = attributes["last_day"] as? [String:Any],
            let lastDay = RealAssetDayParser.parse(fromData: lastDayJSON){
            days.append(lastDay)
        }
        
        return RealAsset(id: id, name: name, symbol: symbol, serie: serie, days: days)
    }
    
    //--------------------------------------------------------
}

//############################################################
