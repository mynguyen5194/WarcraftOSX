//
//  ViewController.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

var menuSound = AVAudioPlayer()

class LaunchViewController: NSViewController {
    var menuSoundURL: URL?
    var menuSoundBankURL: URL?
    
    @IBOutlet var viewOfViewController: NSView!
    @IBOutlet weak var splashScreen: NSImageView!
    
    var splashScreenSoundURL: URL?
    var splashScreenSoundBankURL: URL?
    var splashScreenSound = AVMIDIPlayer()
    
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
    

    func playLoadMusic() {
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
    }
    
    func playMenuMusic() {
        menuSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/music/menu", ofType: "wav"))!)
        
        do {
            try menuSound = AVAudioPlayer(contentsOf: menuSoundURL!)
        } catch {
            NSLog("Error: Can't play sound file thunk.wav")
        }
        
        menuSound.prepareToPlay()
        menuSound.play()
    }
    
    
    func showMenu() {
        performSegue(withIdentifier: "showMenuSegue", sender: self)
        splashScreenSound.stop()
        
        playMenuMusic()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set splash screen
        splashScreen.image = visualElement
        
        //Play Intro
        playLoadMusic()
        
        // Display splash screen for 3 seconds
        perform(#selector(LaunchViewController.showMenu), with: nil, afterDelay: 1)
        
        
        
        
        
    }
    
}

