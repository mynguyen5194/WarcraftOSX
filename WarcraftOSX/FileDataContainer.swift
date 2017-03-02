//
//  FileDataContainer.swift
//  WarcraftOSX
//
//  Created by Alan Wei on 2/18/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Foundation

class FileDataContainer: DataContainer {
    private(set) var url: URL
    
    init(url: URL) throws {
        self.url = url
    }
    
    var contentURLs: [URL] {
        return (try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)) ?? []
    }
}
