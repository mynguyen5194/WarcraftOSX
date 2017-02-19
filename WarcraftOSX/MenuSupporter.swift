//
//  MenuSupporter.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/18/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

class MenuSupporter {
    var menu:NSImage?
    var menuSoundURL: URL?
    var menuSoundBankURL: URL?
    var thunkSound = AVAudioPlayer()

    func getMenuImage() -> NSImage {
        let menuURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Texture", ofType:"png"))!)
        let menuData = CGDataProvider(url: menuURL as CFURL)
        let menuCG = CGImage(pngDataProviderSource: menuData!, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)
        let menuOrigin = CGPoint(x: 0, y: 0)
        let menuSize = CGSize(width: menuCG!.width, height: menuCG!.height)
        let menuRect = CGRect(origin: menuOrigin, size: menuSize)
        let menuImage = menuCG?.cropping(to: menuRect)
        menu = NSImage(cgImage: menuImage!, size: NSZeroSize)
        
        return self.menu!
    }
    
    func playMenuMidi() {
        menuSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/music/menu", ofType: "mid"))!)
        menuSoundBankURL = Bundle.main.url(forResource: "data/snd/generalsoundfont", withExtension: "sf2")
        
        do {
            try menuSound = AVMIDIPlayer(contentsOf: menuSoundURL!, soundBankURL: menuSoundBankURL)
        }
        catch {
            NSLog("Error: Can't play sound file menu.mid")
        }
        menuSound.prepareToPlay()
        menuSound.play()
    }
    
    func playThunkSound() -> AVAudioPlayer {
        let thunkURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/misc/thunk", ofType: "wav"))!)
        
        do {
            try thunkSound = AVAudioPlayer(contentsOf: thunkURL)
        } catch {
            NSLog("Error: Can't play sound file thunk.wav")
        }
        
        thunkSound.prepareToPlay()
        print("play thunk")
        return thunkSound
    }
}
