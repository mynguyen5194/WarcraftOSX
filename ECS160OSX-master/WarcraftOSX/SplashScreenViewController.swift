//
//  ShowSplashScreen.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/4/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

class ShowSplashScreen: NSViewController {
    @IBOutlet weak var splashScreen: NSImageView!
    
    let menuSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/music/load", ofType: "mid"))!)
    let menuSoundBankURL = Bundle.main.url(forResource: "data/snd/generalsoundfont", withExtension: "sf2")
    var menuSound = AVMIDIPlayer()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSplashScreen()
        playMidi()
        
        // Display the splash screen with 3 seconds delay
        perform(#selector(ShowSplashScreen.showWindowViewController), with: nil, afterDelay: 3)
        
//        stopMidi()
        
//        let delay = AVAudioUnitDelay()
//        delay.delayTime = 3
//        menuSound.stop()
        
    }
    
    func showWindowViewController() {
        
        performSegue(withIdentifier: "showSplashScreen", sender: self)
    }
    
    func showSplashScreen() {
        let splashURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Splash", ofType:"png"))!)
        
        //splash screen
        let splashData = CGDataProvider(url: splashURL as CFURL)
        let splashCG = CGImage(pngDataProviderSource: splashData!, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)
        let splashOrigin = CGPoint(x: 0, y: (splashCG!.height/2))
        let splashSize = CGSize(width: splashCG!.width, height: (splashCG!.height/2))
        let splashRect = CGRect(origin: splashOrigin, size: splashSize)
        let splashImage = splashCG?.cropping(to: splashRect)
        
        //splash screen: convert to NSImage to display
        splashScreen.image = NSImage(cgImage: splashImage!, size: NSZeroSize)
    }
    
    func playMidi() {
        
        
        do {
            try menuSound = AVMIDIPlayer(contentsOf: menuSoundURL, soundBankURL: menuSoundBankURL)
        }
        catch {
            NSLog("Error: Can't play sound file menu.mid")
        }
        menuSound.prepareToPlay()
        menuSound.play()
    }
}
