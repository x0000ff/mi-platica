//
//  Error.swift
//  MiPlatica
//
//  Created by Konstantin Portnov on 12/20/18.
//  Copyright © 2018 x0000ff. All rights reserved.
//

//############################################################
import Foundation

//############################################################
extension NSError {
    
    //--------------------------------------------------------
    static func create(withMessage message: String? = "", code: Int = 0) -> Error {
        
        let domain = "MiPLatica"
        var userInfo = [String:Any]()
        
        if let message = message {
            userInfo[NSLocalizedDescriptionKey] = message
        }
        
        let error = NSError(domain: domain,
                            code: code,
                            userInfo: userInfo) as Error
        return error
    }
    
    //--------------------------------------------------------
}

//############################################################
