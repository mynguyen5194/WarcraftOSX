//
//  MapRender.swift
//  Warcraft
//
//  Created by My Nguyen on 1/27/17.
//  Copyright © 2017 My Nguyen. All rights reserved.
//

import Foundation

class CMapRenderer {
    private var DTileset: CGraphicTileset
//    private var DMap: CTerrainMap                 // NEED to add CTerrainMap
    private var DGrassIndices = [Int]()
    private var DTreeIndices = [Int]()
    private var DDirtIndices = [Int]()
    private var DWaterIndices = [Int]()
    private var DRockIndices = [Int]()
    private var DWallIndices = [Int]()
    private var DWallDamagedIndices = [Int]()
    private var DPixelIndices = [Int]()
    
    private var DTreeUnknown = [Int : Int]()
    private var DWaterUnknown = [Int : Int]()
    private var DDirtUnknown = [Int : Int]()
    private var DRockUnknown = [Int : Int]()
    
    
    init() {
        DTileset = CGraphicTileset()
        DGrassIndices = []
        DTreeIndices = []
        DDirtIndices = []
        DWaterIndices = []
        DRockIndices = []
        DWallIndices = []
        DWallDamagedIndices = []
        DPixelIndices = []
        
        DTreeUnknown = [:]
        DWaterUnknown = [:]
        DDirtUnknown = [:]
        DRockUnknown = [:]
    }
    
    
    func DrawMap(surface: CGraphicSurface, typesurface: CGraphicSurface, rect:SRectangle, level: Int) {
        var tileWidth: Int, tileHeight: Int
        var UnknownTree = [Bool]()
        var UnknownWater = [Bool]()
        var UnknownDirt = [Bool]()
        var UnknownRock = [Bool]()
        
        var UnknownUnknownTree = [Int : Bool]()
        var UnknownUnknownWater = [Int : Bool]()
        var UnknownUnknownDirt = [Int : Bool]()
        var UnknownUnknownRock = [Int : Bool]()
        
        if UnknownTree.isEmpty {
            UnknownTree.reserveCapacity(0x100)
            UnknownWater.reserveCapacity(0x100)
            UnknownDirt.reserveCapacity(0x100)
            UnknownRock.reserveCapacity(0x100)
        }
        tileWidth = DTileset.TileWidth()
        tileHeight = DTileset.TileHeight()
        
        if level == 0 {
            typesurface.Clear(xpos: 0, ypos: 0, width: -1, height: -1)
            
            var yIndex = rect.DYPosition / tileHeight
            var yPox = -(rect.DYPosition % tileHeight)
            
            // for(int YIndex = rect.DYPosition / TileHeight, YPos ...
            while yPox < rect.DHeight {
                var xIndex = rect.DXPosition / tileWidth
                var xPos = -(rect.DXPosition % tileWidth)
                
                // for(int XIndex = rect.DXPosition / TileWidth, XPos ...
                while xPos < rect.DWidth {
// NEED TO IMPLEMENT
//                    CPixelType PixelType(DMap->TileType(XIndex, YIndex));
//                    CTerrainMap::ETileType ThisTileType = DMap->TileType(XIndex, YIndex);
//                    if(CTerrainMap::ETileType::ttTree == ThisTileType){
                    var treeIndex = 0, treeMask = 0x1, unknownMask = 0, displayIndex = -1
                    for xOff in -1..<2 {
                        
//                        CTerrainMap::ETileType Tile = DMap->TileType(XIndex + XOff, YIndex + YOff);
//                        if(CTerrainMap::ETileType::ttTree == Tile){
//                            TreeIndex |= TreeMask;
//                        }
//                        else if(CTerrainMap::ETileType::ttNone == Tile){
//                            UnknownMask |= TreeMask;
//                        }
//                        TreeMask <<= 1;
                    }
                    
                    if DTreeIndices[treeIndex] != -1 {
                        if UnknownTree[treeIndex] != false && unknownMask != 0 {
                            print("Unknown tree \(treeIndex) @ ( \(xIndex), \(yIndex)")
                            UnknownTree[treeIndex] = true
                        }
                        
//                        displayIndex = FindUnknown(CTerrainMap::ETileType::ttTree, TreeIndex, UnknownMask);
                        if displayIndex == -1 {
                            if let n = UnknownUnknownTree[treeIndex<<8] {
                                UnknownUnknownTree[(TreeIndex<<8) | UnknownMask] = true
                                print("Unknown tree \(treeIndex) / \(unknownMask) @ ( \(xIndex), \(yIndex)")
                            }
                        }
                    } else {
                        displayIndex = DTreeIndices[treeIndex]
                    }
                    
                    if displayIndex == -1 {
                        DTileset
                    }
                    
                    
                    
                    xIndex = rect.DXPosition / tileWidth
                    xPos = -(rect.DXPosition % tileWidth)
                    xIndex += 1
                    xPos += tileWidth
                }
                
                
                
                
                yIndex = rect.DYPosition / tileHeight
                yPox = -(rect.DYPosition % tileHeight)
                yIndex += 1
                yPox += tileHeight
            }
            
        }
    }
}

