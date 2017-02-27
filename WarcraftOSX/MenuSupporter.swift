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

    var menuSoundURL: URL?
    var menuSoundBankURL: URL?
    var thunkSound = AVAudioPlayer()
    var menuSound = AVMIDIPlayer()
    let pstyle = NSMutableParagraphStyle()
    
//    func playMenuMidi() {
//        menuSoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/music/menu", ofType: "mid"))!)
//        menuSoundBankURL = Bundle.main.url(forResource: "data/snd/generalsoundfont", withExtension: "sf2")
//        
//        do {
//            try menuSound = AVMIDIPlayer(contentsOf: menuSoundURL!, soundBankURL: menuSoundBankURL)
//        }
//        catch {
//            NSLog("Error: Can't play sound file menu.mid")
//        }
//        menuSound.prepareToPlay()
//        menuSound.play()
//    }
    
//    func playThunkSound() -> AVAudioPlayer{
//        var thunkSound = AVAudioPlayer()
//        let thunkURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/misc/thunk", ofType: "wav"))!)
//        
//        do {
//            try thunkSound = AVAudioPlayer(contentsOf: thunkURL)
//        } catch {
//            NSLog("Error: Can't play sound file thunk.wav")
//        }
//        
//        return thunkSound
//    }
    
    func formatButtonTitle(sender: NSButton, color: NSColor, title: String, fontSize: CGFloat) {
        pstyle.alignment = .center
        var attributes = [String: AnyObject]()
        
        attributes[NSFontAttributeName] = NSFont(name: "Apple Chancery", size: fontSize)
        attributes[NSForegroundColorAttributeName] = color
        attributes[NSParagraphStyleAttributeName] = pstyle
        
        sender.attributedTitle = NSAttributedString(string: sender.title, attributes: attributes )
        
    }
    
}
