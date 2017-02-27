//
//  VisualElements.swift
//  WarcraftOSX
//
//  Created by Kristoffer Solomon on 1/30/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

class OSXVisualElements {
    
    var splash:NSImage
    
    init(){
        let splashURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Splash", ofType:"png"))!)
        let splashData = CGDataProvider(url: splashURL as CFURL)
        let splashCG = CGImage(pngDataProviderSource: splashData!, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)
        let splashOrigin = CGPoint(x: 0, y: (splashCG!.height/2))
        let splashSize = CGSize(width: splashCG!.width, height: (splashCG!.height/2))
        let splashRect = CGRect(origin: splashOrigin, size: splashSize)
        let splashImage = splashCG?.cropping(to: splashRect)
        splash = NSImage(cgImage: splashImage!, size: NSZeroSize)
    }
 
    func getSplashImage() -> NSImage {
        return self.splash
    }
    
}
