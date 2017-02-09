import Foundation
import CoreGraphics

//IOS
// FIXME: MAKE IMAGE GREAT AGAIN
// HACK - START
//import UIKit
// HACK - END


class GraphicFactory {
    
    //IOS
    /*
    static func createSurface(width: Int, height: Int, format: GraphicSurfaceFormat) -> GraphicSurface? {
        let size = CGSize(width: width, height: height)
        //UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let layer = CGLayer(context, size: size, auxiliaryInfo: nil)
        UIGraphicsEndImageContext()
        return layer
    }
    static func loadSurface(dataSource: DataSource) -> GraphicSurface? {
        fatalError("This method is not yet implemented.")
    }*/
    
    /*
    // FIXME: MAKE TILESET GREAT AGAIN
    // HACK - START
    static func loadPNGTilesetSurface(name: String) -> GraphicSurface {
        let name = String(name.characters.dropFirst(2))
        let image = UIImage(named: name)!
        UIGraphicsBeginImageContext(image.size)
        let layer = CGLayer(UIGraphicsGetCurrentContext()!, size: image.size, auxiliaryInfo: nil)!
        layer.context!.draw(image.cgImage!, in: CGRect(origin: .zero, size: image.size))
        UIGraphicsEndImageContext()
        return layer
    }
    // HACK - END
    */
    static func createSurface(width: Int, height: Int, format: GraphicSurfaceFormat) -> GraphicSurface? {
        let size = CGSize(width: width, height: height)
        //        UIGraphicsBeginImageContext(size)
        
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        
        //        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let layer = CGLayer(context, size: size, auxiliaryInfo: nil)
        //        UIGraphicsEndImageContext()
        return layer
    }
    
    static func loadPNGTilesetSurface(name: String) -> GraphicSurface {
        let name = String(name.characters.dropFirst(2))
        //        let image = UIImage(named: name)!
        
        let image = NSImage.init?(named: name)
        //        let image = NSImage.cgImage(nsImage)// CGImageForProposedRect(nil, context: nil, hints: nil)
        if let image = image {
            var imageRect:CGRect = CGRectMake(0, 0, image.size.width, image.size.height)
            var imageRef = image.CGImageForProposedRect(&imageRect, context: nil, hints: nil)
        }
        
        
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        var width: Int = Int(image?.size.width)
        var height: Int = Int(image?.size.height)
        
        //        UIGraphicsBeginImageContext(image.size)
        let currentContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        //            CGContext(data: nil, width: image?.size.width, height: image?.size.height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue
        
        let layer = CGLayer(currentContext!, size: image.size, auxiliaryInfo: nil)!
        
        layer.context!.draw(image.cgImage!, in: CGRect(origin: .zero, size: image.size))
        //        UIGraphicsEndImageContext()
        return layer
    }
}
