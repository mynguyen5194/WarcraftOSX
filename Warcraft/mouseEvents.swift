//
//  mouseEvents.swift
//  Warcraft
//
//  Created by Kristoffer Solomon on 1/17/17.
//  Copyright © 2017 Kristoffer Solomon. All rights reserved.
//

import Foundation
import Cocoa

class mouseEvents: NSResponder {

    override func mouseDown(with event: NSEvent) {
        print("Left Mouse Down")
    }
    override func rightMouseDown(with event: NSEvent) {
        print("Right Mouse Down")
    }
}
