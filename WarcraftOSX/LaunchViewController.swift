//
//  ViewController.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation



class LaunchViewController: NSViewController {
    
    @IBOutlet var viewOfViewController: NSView!
    @IBOutlet weak var splashScreen: NSImageView!
    @IBOutlet weak var loadMapButton: NSButton!
    
    private lazy var visualElement: NSImage = {
            let splashURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Splash", ofType:"png"))!)
            let splashData = CGDataProvider(url: splashURL as CFURL)
            let splashCG = CGImage(pngDataProviderSource: splashData!, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)
            let splashOrigin = CGPoint(x: 0, y: (splashCG!.height/2))
            let splashSize = CGSize(width: splashCG!.width, height: (splashCG!.height/2))
            let splashRect = CGRect(origin: splashOrigin, size: splashSize)
            let splashImage = splashCG?.cropping(to: splashRect)
            let splash = NSImage(cgImage: splashImage!, size: NSZeroSize)
            return splash
    }()
    
    private lazy var acknowledgeSound: AVAudioPlayer = {
        do {
            var acknowledgeSound = AVAudioPlayer()
            let acknowledge1URL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/basic/acknowledge1", ofType: "wav"))!)
            try acknowledgeSound = AVAudioPlayer(contentsOf: acknowledge1URL)
            return acknowledgeSound
        } catch {
            let error = NSError.init(domain: "Failed to load Audio Player", code: 0, userInfo: nil)
            fatalError(error.localizedDescription)
        }
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set splash screen
        splashScreen.image = visualElement
        
        //Button Elements
        loadMapButton.title = "Load Map"
        
    }
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        
        acknowledgeSound.prepareToPlay()
        acknowledgeSound.play()
    }
    
}

