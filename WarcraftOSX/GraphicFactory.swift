import CoreGraphics
import AppKit

class GraphicFactory {
    
    static func createSurface(width: Int, height: Int, format: GraphicSurfaceFormat) -> GraphicSurface? {
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size: size)
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        let layer = CGLayer(context, size: size, auxiliaryInfo: nil)
        UIGraphicsEndImageContext()
        return layer
    }
        
    static func loadSurface(from url: URL) -> GraphicSurface? {
        let image = NSImage(contentsOfFile: url.path)!
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)
        UIGraphicsBeginImageContext(size: image.size)
        let layer = CGLayer(UIGraphicsGetCurrentContext()!, size: image.size, auxiliaryInfo: nil)!
        layer.context!.draw(cgImage!, in: CGRect(origin: .zero, size: image.size))
        UIGraphicsEndImageContext()
        return layer
    }

}
