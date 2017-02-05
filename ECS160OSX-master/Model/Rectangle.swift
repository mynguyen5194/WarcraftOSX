//
//  Rectangle.swift
//  Warcraft
//
//  Created by My Nguyen on 1/29/17.
//  Copyright © 2017 My Nguyen. All rights reserved.
//

import Foundation

struct SRectangle {
    var DXPosition: Int
    var DYPosition: Int
    var DWidth: Int
    var DHeight: Int
    
    func PointInside(x: Int, y: Int) -> Bool {
        return (x >= DXPosition) && (x < DXPosition + DWidth) && (y >= DYPosition) && (y < DYPosition + DHeight)
    }
}
