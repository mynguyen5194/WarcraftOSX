//
//  OSXObjects.swift
//  WarcraftOSX
//
//  Created by Alan Wei on 2/12/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

class StatObjects: NSViewController {
    
    var objectDictArray = [String: [CGImage]]()
    var objectNames = [String]()
    
    override func viewDidLoad() {
        
        objectNames.append("Peasant")
        objectNames.append("Footman")
        objectNames.append("Archer")
        objectNames.append("Ranger")
        objectNames.append("GoldMine")
        objectNames.append("Castle")
        objectNames.append("CannonTower")
        objectNames.append("GuardTower")
        objectNames.append("Keep")
        objectNames.append("Barracks")
        objectNames.append("Blacksmith")
        objectNames.append("Farm")
        objectNames.append("LumberMill")
        objectNames.append("ScoutTower")
        objectNames.append("TownHall")
        
        for i in 0 ..< objectNames.count {
            
            var objectRef = [String]()
            let objectDat = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/" + objectNames[i], ofType: "dat"))!)
            
            do {
                let objectString = try String(contentsOf: objectDat)
                objectRef = objectString.components(separatedBy: .newlines)
            } catch {
                print(error)
            }
            
            let objectURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/" + objectNames[i], ofType:"png"))!)
            let objectData = CGDataProvider(url: objectURL as CFURL)
            let objectCG = CGImage(pngDataProviderSource: objectData!, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)
            let objectWidth = objectCG!.width
            let objectHeight = (objectCG!.height / Int(objectRef[1])!)
            let objectSize = CGSize(width: objectWidth, height: objectHeight)
            var objectArray = [CGImage]()
            var objectCutter = 0
            
            for _ in 0 ..< Int(objectRef[1])! {
                let objectOrigin = CGPoint(x: 0, y: objectCutter)
                let objectRect = CGRect(origin: objectOrigin, size: objectSize)
                let object = objectCG?.cropping(to: objectRect)
                objectArray.append(object!.copy()!)
                objectCutter += objectHeight
            }
            
            objectDictArray[objectNames[i]] = objectArray
            
        }
    }
    
}
