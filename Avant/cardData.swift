//
//  cardData.swift
//  Avant
//
//  Created by Shuailin Lyu on 3/5/18.
//  Copyright © 2018 Shuailin Lyu. All rights reserved.
//

import Foundation


struct cardData{
    var cardName: String
    var APR : Double
    var creditLimit : Double
    var balance : Double
    var accruedInterest: Double
    //var Transaction : [Transaction]
   // var Transaction: [[Double]]
    
    var Transaction  : [Int: [Double]]
    
    
    
}
