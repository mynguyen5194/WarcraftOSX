//
//  SplashScreenViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/12/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

class SplashScreenViewController: NSViewController {

    @IBOutlet weak var splashScreen: NSImageView!
    
    
    var splashScreenSoundURL: URL?
    var splashScreenSoundBankURL: URL?
    var splashScreenSound = AVMIDIPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSplashScreen()
        playMidi()
        
        // Display splash screen for 3 seconds
        perform(#selector(SplashScreenViewController.showMenu), with: nil, afterDelay: 3)
        
    }
    
    func showMenu() {
        performSegue(withIdentifier: "showMenuSegue", sender: self)
        splashScreenSound.stop()
        print("Stop splashScreenSound")
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
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
    
    
    // Play midi file
    func playMidi() {
        //splashScreen sound midi
        splashScreenSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/music/load", ofType: "mid"))!)
        splashScreenSoundBankURL = Bundle.main.url(forResource: "data/snd/generalsoundfont", withExtension: "sf2")
        
        do {
            try splashScreenSound = AVMIDIPlayer(contentsOf: splashScreenSoundURL!, soundBankURL: splashScreenSoundBankURL)
        }
        catch {
            NSLog("Error: Can't play sound file menu.mid")
        }
        splashScreenSound.prepareToPlay()
        splashScreenSound.play()
        print("Play splashScreenSound")
    }
    
}
