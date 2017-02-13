import Foundation
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
    
    static func loadSurface(dataSource: DataSource) -> GraphicSurface? {
        fatalError("This method is not yet implemented.")
    }
    
    static func loadPNGTilesetSurface(name: String) -> GraphicSurface {
      //  let name = String(name.characters.dropFirst(2))
    
        
        //HACK
        let terrainURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Terrain", ofType:"png"))!)
        let terrainData = CGDataProvider(url: terrainURL as CFURL)
        let terrainCG = CGImage(pngDataProviderSource: terrainData!, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)
        let terrainCGImageSize = CGSize.init(width: (terrainCG?.width)!, height: (terrainCG?.height)!)
        
        //NOTE: New Implementation
        //let image = NSImage.init(named: name)
        //var imageRect: CGRect = CGRect.init(x: 0, y: 0, width: image!.size.width, height: image!.size.height)
        //let imageRef = image?.cgImage(forProposedRect: nil, context: nil, hints: nil)
        
        UIGraphicsBeginImageContext(size: terrainCGImageSize)
        let layer = CGLayer(UIGraphicsGetCurrentContext()!, size: terrainCGImageSize, auxiliaryInfo: nil)
        layer?.context!.draw(terrainCG!, in: CGRect(origin: .zero, size: terrainCGImageSize))
        UIGraphicsEndImageContext()
        return layer!
        
    }
}
