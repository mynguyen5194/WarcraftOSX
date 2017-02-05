//
//  DataSource.swift
//  Warcraft
//
//  Created by My Nguyen on 1/25/17.
//  Copyright © 2017 My Nguyen. All rights reserved.
//

import Foundation

protocol CDataSource {
    func Read(data:Any.Type, length:Int) -> Int
    func Container() -> AnyClass    //FIXME: CDataContainer
}
