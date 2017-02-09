import Foundation
import CoreGraphics
import AppKit

class GraphicFactory: NSObject {
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
    
    static func loadSurface(dataSource: DataSource) -> GraphicSurface? {
        fatalError("This method is not yet implemented.")
    }
    
    static func loadPNGTilesetSurface(name: String) -> GraphicSurface {
        let name = String(name.characters.dropFirst(2))
        let image = NSImage.init(named: name)
        let originPoint = CGPoint.init(x: 0, y: 0)
        var imageRect:CGRect = CGRect.init(origin: originPoint, size: image!.size)
        let imageRef = image?.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let width: Int = Int(image!.size.width)
        let height: Int = Int(image!.size.height)
        let currentContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        let layer = CGLayer(currentContext!, size: image!.size, auxiliaryInfo: nil)!
        layer.context!.draw(imageRef!, in: CGRect(origin: .zero, size: image!.size))
        return layer
    }
}
