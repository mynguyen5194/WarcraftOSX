//
//  ViewController.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var splashScreen: NSImageView!
    @IBOutlet weak var tileEX: NSImageView!

    
    let splashURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Splash", ofType:"png"))!)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //splash screen
        let splashData = CGDataProvider(url: splashURL as CFURL)
        let splashCG = CGImage(pngDataProviderSource: splashData!, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)
        let splashOrigin = CGPoint(x: 0, y: (splashCG!.height/2))
        let splashSize = CGSize(width: splashCG!.width, height: (splashCG!.height/2))
        let splashRect = CGRect(origin: splashOrigin, size: splashSize)
        let splashImage = splashCG?.cropping(to: splashRect)
        
        //splash screen: convert to NSImage to display
        splashScreen.image = NSImage(cgImage: splashImage!, size: NSZeroSize)
        
        let map = MapRenderer()
        map.viewDidLoad()
        
        tileEX.image = NSImage(cgImage: map.tileArray[100], size: NSZeroSize)
        //var timerToMenu = Timer(timeInterval: 5.0, target: self, selector: (timerFireMethod: timer), userInfo: nil, repeats: false)
        
        let parseDat = GraphicTileset()
        parseDat.viewDidLoad()
    }

    /*func map(){
        let tower = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/TownHall", ofType:"png"))!)
        splashScreen.image = NSImage(byReferencing: tower)
    }*/
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}
