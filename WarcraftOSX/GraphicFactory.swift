
//EDIT FOR OSX


import Foundation
import CoreGraphics

// FIXME: MAKE IMAGE GREAT AGAIN
// HACK - START
//import UIKit
// HACK - END

class GraphicFactory {
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

    // FIXME: MAKE TILESET GREAT AGAIN
    // HACK - START
    static func loadTerrainTilesetSurface() -> GraphicSurface {
//        let image = UIImage(named: "Terrain.png")!
//        UIGraphicsBeginImageContext(image.size)
//        let layer = CGLayer(UIGraphicsGetCurrentContext()!, size: image.size, auxiliaryInfo: nil)!
//        layer.context!.draw(image.cgImage!, in: CGRect(origin: .zero, size: image.size))
//        UIGraphicsEndImageContext()
//        return layer
        fatalError("This method is not yet implemented.")
        
    }
    // HACK - END
}
