//
//  RealAssetService.swift
//  MiPlatica
//
//  Created by Konstantin Portnov on 12/20/18.
//  Copyright © 2018 x0000ff. All rights reserved.
//

//############################################################
import Foundation
import Alamofire

//############################################################
class RealAssetService {
    
    //--------------------------------------------------------
    func load(withRealAssetId realAssetId: String, completion: ((Result<RealAsset>) -> Void)?) {
        
        let baseURL = "https://fintual.cl/api/real_assets/"
        let url = baseURL + realAssetId
        
        Alamofire.request(url).responseJSON { response in
            
            guard let json = response.result.value as? Dictionary<String, Any>,
                let realAsset = RealAssetParser.parse(fromData: json) else {
                    
                    let error = NSError.create(withMessage: response.error?.localizedDescription,
                                               code: response.response?.statusCode ?? 0)
                    completion?(.failure(error))
                    return
            }
            
            completion?(Result.success(realAsset))
        }
        
    }
    
    //--------------------------------------------------------

}
//############################################################
