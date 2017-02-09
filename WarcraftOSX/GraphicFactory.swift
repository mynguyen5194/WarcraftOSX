import Foundation
import CoreGraphics
import AppKit

class GraphicFactory {
    static func createSurface(width: Int, height: Int, format: GraphicSurfaceFormat) -> GraphicSurface? {
        let size = CGSize(width: width, height: height)
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        let layer = CGLayer(context, size: size, auxiliaryInfo: nil)
        return layer
    }
    
    static func loadPNGTilesetSurface(name: String) -> GraphicSurface {
        let name = String(name.characters.dropFirst(2))
        let image = NSImage.init(named: name)
        let originPoint = CGPoint.init(x: 0, y: 0)
        
        let imageRect:CGRect = CGRect.init(origin: originPoint, size: image!.size)
        //let imageRef = image?.cgImage(forProposedRect: imageRect, context: nil, hints: nil) to convert to cgimage
        
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        var width: Int = Int(image!.size.width)
        var height: Int = Int(image!.size.height)
        
        let currentContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        let layer = CGLayer(currentContext!, size: image!.size, auxiliaryInfo: nil)!
        
        layer.context!.draw(CGIMAGEPLACEHOLDER, in: CGRect(origin: .zero, size: image!.size))
        
        return layer
    }
}
