//
//  TextFormatter.swift
//  Warcraft
//
//  Created by My Nguyen on 1/29/17.
//  Copyright © 2017 Kristoffer Solomon. All rights reserved.
//

import Foundation

class textFormatter{
    
    func integerToPrettyString(val: Int) -> String{
        var simpleString: String = String(val)
        var returnString: String = ""
        var charUntilComma = simpleString.characters.count % 3
        var charactersLeft = simpleString.characters.count
        
        if charUntilComma == 0{
            charUntilComma = 3
        }
        
        for char in simpleString.characters{
            returnString.append(char)
            charUntilComma -= 1
            charactersLeft -= 1
            if(charUntilComma == 0){
                charUntilComma = 3
                if charactersLeft != 0{
                    returnString.append(",")
                }
            }
            
        }
        
        return returnString
    }
}
