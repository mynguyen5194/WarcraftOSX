//
//  singlePlayer.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import Foundation

class OSXMapRenderer {
    
    var tileArray = [CGImage]()
    var tileDimensions:CGSize
    var tileSize:CGSize
    let terrainURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Terrain", ofType:"png"))!)
    
    init() {
        //terrain png to CGimage
        let terrainData = CGDataProvider(url: terrainURL as CFURL)
        let terrainCG = CGImage(pngDataProviderSource: terrainData!, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)
        
        //initalize tile specifications
        let tileHeight = (terrainCG!.height / 293)
            tileSize = CGSize(width: terrainCG!.width, height: tileHeight)
        var tileOrigin = CGPoint()
        var tileRect = CGRect()
        var tileYCoord = 0
        
        //storing each individual tile in tileArray
        for _ in 0..<293 {
            tileOrigin = CGPoint(x: 0, y: tileYCoord)
            tileRect = CGRect(origin: tileOrigin, size: tileSize)
            let tile = terrainCG?.cropping(to: tileRect)
            tileArray.append(tile!.copy()!)
            tileYCoord += tileHeight
        }
        tileDimensions = tileSize
    }
    
    func getTile(tilePosition: Int) -> CGImage {
        let location = tileArray[tilePosition]
        return location
    }
    
    func getTileWidthAndHeight() -> CGSize {
        let sizeOfLayer = tileSize
        return sizeOfLayer
    }
    
    func drawMap(surface: GraphicSurface, typeSurface: GraphicSurface, rect: Rectangle, level: Int) throws {
        //let tileWidth = tileset.tileWidth
        //let tileHeight = tileset.tileHeight
        let tileWidth = 32
        let tileHeight = 32
        var unknownTree: [Bool] = []
        var unknownWater: [Bool] = []
        var unknownDirt: [Bool] = []
        var unknownRock: [Bool] = []
        var unknownUnknownTree: [Int: Bool] = [:]
        var unknownUnknownWater: [Int: Bool] = [:]
        var unknownUnknownDirt: [Int: Bool] = [:]
        var unknownUnknownRock: [Int: Bool] = [:]
        
        if unknownTree.isEmpty {
            unknownTree = Array(repeating: false, count: 0x100)
            unknownWater = Array(repeating: false, count: 0x100)
            unknownDirt = Array(repeating: false, count: 0x100)
            unknownRock = Array(repeating: false, count: 0x100)
        }
        
        if level == 0 {
            try typeSurface.clear(x: 0, y: 0, width: typeSurface.width, height: typeSurface.height)
            
            var yIndex = rect.yPosition / tileHeight
            for yPos in stride(from: -(rect.yPosition % tileHeight), to: rect.height, by: tileHeight) {
                var xIndex = rect.xPosition / tileWidth
                for xPos in stride(from: -(rect.xPosition % tileWidth), to: rect.width, by: tileWidth) {
                    let pixelType = PixelType(tileType: map.tileTypeAt(x: xIndex, y: yIndex))
                    let thisTileType = map.tileTypeAt(x: xIndex, y: yIndex)
                    
                    if thisTileType == .tree {
                        var treeIndex = 0, treeMask = 0x1, unknownMask = 0, displayIndex = -1
                        for yOff in 0 ..< 2 {
                            for xOff in -1 ..< 2 {
                                let tile = map.tileTypeAt(x: xIndex + xOff, y: yIndex + yOff)
                                if tile == .tree {
                                    treeIndex |= treeMask
                                } else if tile == .none {
                                    unknownMask |= treeMask
                                }
                                treeMask <<= 1
                            }
                        }
                        
//                        if treeIndices[treeIndex] == -1 {
//                            if !unknownTree[treeIndex] && unknownMask == 0 {
//                                printError("Unknown tree \(treeIndex) @ (\(xIndex), \(yIndex))")
//                                unknownTree[treeIndex] = true
//                            }
//                            displayIndex = findUnknown(type: .tree, known: treeIndex, unknown: unknownMask)
//                            if displayIndex == -1 {
//                                if unknownUnknownTree[(treeIndex << 8) | unknownMask] == nil {
//                                    unknownUnknownTree[(treeIndex << 8) | unknownMask] = true
//                                    printError("Unknown tree \(treeIndex)/\(unknownMask) @ (\(xIndex), \(yIndex))")
//                                }
//                            }
//                        } else {
                            displayIndex = treeIndices[treeIndex]
//                        }
                        
                        if displayIndex != -1 {
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: displayIndex)
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: displayIndex, rgb: pixelType.pixelColor)
                        }
                    } else if thisTileType == .water {
                        var waterIndex = 0, waterMask = 0x1, unknownMask = 0, displayIndex = -1
                        for yOff in -1 ..< 2 {
                            for xOff in -1 ..< 2 {
                                if xOff != 0 || yOff != 0 {
                                    let tile = map.tileTypeAt(x: xIndex + xOff, y: yIndex + yOff)
                                    if tile == .water {
                                        waterIndex |= waterMask
                                    } else if tile == .none {
                                        unknownMask |= waterMask
                                    }
                                    waterMask <<= 1
                                }
                            }
                        }
                        
//                        if waterIndices[waterIndex] == -1 {
//                            if !unknownWater[waterIndex] && unknownMask == 0 {
//                                printError("Unknown water \(waterIndex) @ (\(xIndex), \(yIndex))")
//                                unknownWater[waterIndex] = true
//                            }
//                            displayIndex = findUnknown(type: .water, known: waterIndex, unknown: unknownMask)
//                            if displayIndex == -1 {
//                                if unknownUnknownWater[(waterIndex << 8) | unknownMask] == nil {
//                                    unknownUnknownWater[(waterIndex << 8) | unknownMask] = true
//                                    printError("Unknown water \(waterIndex)/\(unknownMask) @ (\(xIndex), \(yIndex))")
//                                }
//                            }
//                        } else {
                            displayIndex = waterIndices[waterIndex]
//                        }
                        
                        if displayIndex != -1 {
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: displayIndex)
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: displayIndex, rgb: pixelType.pixelColor)
                        }
                    } else if thisTileType == .grass {
                        var otherIndex = 0, otherMask = 0x1, unknownMask = 0, displayIndex = -1
                        for yOff in -1 ..< 2 {
                            for xOff in -1 ..< 2 {
                                if xOff != 0 || yOff != 0 {
                                    let tile = map.tileTypeAt(x: xIndex + xOff, y: yIndex + yOff)
                                    if tile == .water || tile == .dirt || tile == .rock {
                                        otherIndex |= otherMask
                                    } else if tile == .none {
                                        unknownMask |= otherMask
                                    }
                                    otherMask <<= 1
                                }
                            }
                        }
                        
                        if otherIndex != 0 {
//                            if dirtIndices[otherIndex] == -1 {
//                                if !unknownDirt[otherIndex] && unknownMask == 0 {
//                                    printError("Unknown dirt \(otherIndex) @ (\(xIndex), \(yIndex))")
//                                    unknownDirt[otherIndex] = true
//                                }
//                                displayIndex = findUnknown(type: .dirt, known: otherIndex, unknown: unknownMask)
//                                if displayIndex == -1 {
//                                    if unknownUnknownDirt[(otherIndex << 8) | unknownMask] == nil {
//                                        unknownUnknownDirt[(otherIndex << 8) | unknownMask] = true
//                                        printError("Unknown dirt \(otherIndex)/\(unknownMask) @ (\(xIndex), \(yIndex))")
//                                    }
//                                }
//                            } else {
                                    displayIndex = dirtIndices[otherIndex]
//                            }
                            
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: displayIndex)
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: displayIndex, rgb: pixelType.pixelColor)
                        } else {
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: grassIndices[0x00])
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: grassIndices[0x00], rgb: pixelType.pixelColor)
                        }
                    } else if thisTileType == .rock {
                        var rockIndex = 0, rockMask = 0x1, unknownMask = 0, displayIndex = -1
                        for yOff in -1 ..< 2 {
                            for xOff in -1 ..< 2 {
                                if xOff != 0 || yOff != 0 {
                                    let tile = map.tileTypeAt(x: xIndex + xOff, y: yIndex + yOff)
                                    if tile == .rock {
                                        rockIndex |= rockMask
                                    } else if tile == .none {
                                        unknownMask |= rockMask
                                    }
                                    rockMask <<= 1
                                }
                            }
                        }
                        
//                        if rockIndices[rockIndex] == -1 {
//                            if !unknownRock[rockIndex] && unknownMask == 0 {
//                                printError("Unknown rock \(rockIndex) @ (\(xIndex), \(yIndex))")
//                                unknownRock[rockIndex] = true
//                            }
//                            displayIndex = findUnknown(type: .rock, known: rockIndex, unknown: unknownMask)
//                            if displayIndex == -1 {
//                                if unknownUnknownRock[(rockIndex << 8) | unknownMask] == nil {
//                                    unknownUnknownRock[(rockIndex << 8) | unknownMask] = true
//                                    printError("Unknown rock \(rockIndex)/\(unknownMask) @ (\(xIndex), \(yIndex))")
//                                }
//                            }
//                        } else {
                                displayIndex = rockIndices[rockIndex]
//                        }
                        
                        if displayIndex != -1 {
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: displayIndex)
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: displayIndex, rgb: pixelType.pixelColor)
                        }
                    } else if thisTileType == .wall || thisTileType == .wallDamaged {
                        var wallIndex = 0, wallMask = 0x1, displayIndex = -1
                        var xOffsets = [0, 1, 0, -1]
                        var yOffsets = [ -1, 0, 1, 0]
                        for index in 0 ..< xOffsets.count {
                            let tile = map.tileTypeAt(x: xIndex + xOffsets[index], y: yIndex + yOffsets[index])
                            if tile == .wall || tile == .wallDamaged || tile == .rubble {
                                wallIndex |= wallMask
                            }
                            wallMask <<= 1
                        }
                        displayIndex = .wall == thisTileType ? wallIndices[wallIndex] : wallDamagedIndices[wallIndex]
                        if displayIndex != -1 {
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: displayIndex)
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: displayIndex, rgb: pixelType.pixelColor)
                        }
                    } else {
                        switch map.tileTypeAt(x: xIndex, y: yIndex) {
                        case .grass:
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: grassIndices[0x00])
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: grassIndices[0x00], rgb: pixelType.pixelColor)
                            break
                        case .dirt:
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: dirtIndices[0xff])
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: dirtIndices[0xff], rgb: pixelType.pixelColor)
                            break
                        case .rock:
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: rockIndices[0x00])
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: rockIndices[0x00], rgb: pixelType.pixelColor)
                            break
                        case .tree:
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: treeIndices[0x00])
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: treeIndices[0x00], rgb: pixelType.pixelColor)
                            break
                        case .stump:
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: treeIndices[0x00])
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: treeIndices[0x00], rgb: pixelType.pixelColor)
                            break
                        case .water:
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: waterIndices[0x00])
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: waterIndices[0x00], rgb: pixelType.pixelColor)
                            break
                        case .wall:
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: wallIndices[0x00])
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: wallIndices[0x00], rgb: pixelType.pixelColor)
                            break
                        case .wallDamaged:
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: wallDamagedIndices[0x00])
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: wallDamagedIndices[0x00], rgb: pixelType.pixelColor)
                            break
                        case .rubble:
                            try tileset.drawTile(on: surface, x: xPos, y: yPos, index: wallIndices[0x00])
                            try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: wallIndices[0x00], rgb: pixelType.pixelColor)
                            break
                        default:
                            break
                        }
                    }
                    xIndex += 1
                }
                yIndex += 1
            }
        } else {
            var yIndex = rect.yPosition / tileHeight
            for yPos in stride(from: -(rect.yPosition % tileHeight), to: rect.height, by: tileHeight) {
                var xIndex = rect.xPosition / tileWidth
                for xPos in stride(from: -(rect.xPosition % tileWidth), to: rect.width, by: tileWidth) {
                    if (map.tileTypeAt(x: xIndex, y: yIndex + 1) == .tree) && (map.tileTypeAt(x: xIndex, y: yIndex) != .tree) {
                        let pixelType = PixelType(tileType: .tree)
                        var treeIndex = 0, treeMask = 0x1
                        
                        for yOff in 0 ..< 2 {
                            for xOff in -1 ..< 2 {
                                if map.tileTypeAt(x: xIndex + xOff, y: yIndex + yOff) == .tree {
                                    treeIndex |= treeMask
                                }
                                treeMask <<= 1
                            }
                        }
                        
                        try tileset.drawTile(on: surface, x: xPos, y: yPos, index: treeIndices[treeIndex])
                        try tileset.drawClippedTile(on: typeSurface, x: xPos, y: yPos, index: treeIndices[treeIndex], rgb: pixelType.pixelColor)
                    }
                    xIndex += 1
                }
                yIndex += 1
            }
        }
    }
}
