//
//  Result.swift
//  MiPlatica
//
//  Created by Konstantin Portnov on 12/19/18.
//  Copyright © 2018 x0000ff. All rights reserved.
//

//############################################################
import Foundation

//############################################################
enum Result<Value> {
    case success(Value)
    case failure(Error)
}

//############################################################
