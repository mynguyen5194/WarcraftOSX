//
//  DataContainer.swift
//  Warcraft
//
//  Created by My Nguyen on 1/24/17.
//  Copyright © 2017 My Nguyen. All rights reserved.
//

import Foundation

protocol CDataContainerIterator {
    func Name() -> String
    func IsContainer() -> Bool
    func IsValid() -> Bool
    func Next()
}

protocol CDataContainer {
    func First() -> CDataContainerIterator
    func DataSource(name:String) -> CDataSource
    func DataSink(name:String) -> CDataSink
    func Container() -> CDataContainer
    func DataContainer(name:String) -> CDataContainer
}
