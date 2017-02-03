//
//  singlePlayer.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import Foundation

class MapRenderer {

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
    
   /* FROM NITTA'S MAPRENDERER.CPP DRAWMAP FUNCTION
    void CMapRenderer::DrawMap(std::shared_ptr<CGraphicSurface> surface, std::shared_ptr<CGraphicSurface> typesurface, const SRectangle &rect, int level){
    for(int YIndex = rect.DYPosition / TileHeight, YPos = -(rect.DYPosition % TileHeight); YPos < rect.DHeight; YIndex++, YPos += TileHeight){
        for(int XIndex = rect.DXPosition / TileWidth, XPos = -(rect.DXPosition % TileWidth); XPos < rect.DWidth; XIndex++, XPos += TileWidth){
            CPixelType PixelType(DMap->TileType(XIndex, YIndex));
            CTerrainMap::ETileType ThisTileType = DMap->TileType(XIndex, YIndex);
            if(CTerrainMap::ETileType::ttTree == ThisTileType){
                int TreeIndex = 0, TreeMask = 0x1, UnknownMask = 0, DisplayIndex = -1;
                for(int YOff = 0; YOff < 2; YOff++){
                    for(int XOff = -1; XOff < 2; XOff++){
                        CTerrainMap::ETileType Tile = DMap->TileType(XIndex + XOff, YIndex + YOff);
                        if(CTerrainMap::ETileType::ttTree == Tile){
                            TreeIndex |= TreeMask;
                        }
                        else if(CTerrainMap::ETileType::ttNone == Tile){
                            UnknownMask |= TreeMask;
                        }
                        TreeMask <<= 1;
                    }
                }
                if(-1 == DTreeIndices[TreeIndex]){
                    if(!UnknownTree[TreeIndex] && !UnknownMask){
                        PrintError("Unknown tree 0x%02X @ (%d, %d)\n",TreeIndex, XIndex, YIndex);
                        UnknownTree[TreeIndex] = true;
                    }
                    DisplayIndex = FindUnknown(CTerrainMap::ETileType::ttTree, TreeIndex, UnknownMask);
                    if(-1 == DisplayIndex){
                        if(UnknownUnknownTree.end() == UnknownUnknownTree.find((TreeIndex<<8) | UnknownMask)){
                            UnknownUnknownTree[(TreeIndex<<8) | UnknownMask] = true;
                            PrintError("Unknown tree 0x%02X/%02X @ (%d, %d)\n",TreeIndex, UnknownMask, XIndex, YIndex);
                        }
                    }
                }
                else{
                    DisplayIndex = DTreeIndices[TreeIndex];
                }
                if(-1 != DisplayIndex){
                    DTileset->DrawTile(surface, XPos, YPos, DisplayIndex);
                    DTileset->DrawClipped(typesurface, XPos, YPos, DisplayIndex, PixelType.ToPixelColor());
                }
            }
 */
    
    func drawMap(layer: CGLayer){
        
    }
    
}
