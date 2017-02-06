
//EDIT FOR OSX

import Cocoa
import Foundation
import CoreGraphics

// FIXME: MAKE IMAGE GREAT AGAIN
// HACK - START
//import UIKit
// HACK - END

class GraphicFactory: NSView {
    static func createSurface(width: Int, height: Int, format: GraphicSurfaceFormat) -> GraphicSurface? {
        guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
            return nil
        }
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0) else {
            return nil
        }
        return CGLayer(context, size: CGSize(width: width, height: height), auxiliaryInfo: nil)
    }

    static func loadSurface(dataSource: DataSource) -> GraphicSurface? {
        fatalError("This method is not yet implemented.")
    }

    static func loadTerrainTilesetSurface() -> GraphicSurface {
//        let image = UIImage(named: "Terrain.png")!
//        UIGraphicsBeginImageContext(image.size)
//        let layer = CGLayer(UIGraphicsGetCurrentContext()!, size: image.size, auxiliaryInfo: nil)!
//        layer.context!.draw(image.cgImage!, in: CGRect(origin: .zero, size: image.size))
//        UIGraphicsEndImageContext()
        
        //terrain png to CGImage
        let terrainURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Terrain", ofType:"png"))!)
        let terrainData = CGDataProvider(url: terrainURL as CFURL)
        let terrainCG = CGImage(pngDataProviderSource: terrainData!, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)
        let terrainSize = CGSize(width: terrainCG!.width, height: terrainCG!.height)
        
        
        let mapContext = NSGraphicsContext.current()?.cgContext
        
        //create initial layer
        let mapSize = CGSize(width: 32, height: 32)
        let mapLayer = CGLayer(mapContext!, size: terrainSize, auxiliaryInfo: nil)
        var mapLayerContext = mapLayer?.context
        let mapOrigin = CGPoint(x: 0, y: 0)
        let mapRect = CGRect(origin: mapOrigin, size: mapSize)
        mapLayerContext?.draw(terrainCG!, in: mapRect)
        //mapLayerContext?.draw(terrainCG!, in: CGRect(origin: mapOrigin, size: terrainSize))
        
        return mapLayer!
        fatalError("This method is not yet implemented.")
        
    }
}
