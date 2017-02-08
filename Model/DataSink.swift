//
//  DataSink.swift
//  Warcraft
//
//  Created by My Nguyen on 1/24/17.
//  Copyright © 2017 My Nguyen. All rights reserved.
//

import Foundation
//import Model.DataContainer

protocol CDataSink {
    func Write(data:Any.Type, length:Int) -> Int
    func Container() -> AnyClass        //FIXME: CDataContainer
    
}
