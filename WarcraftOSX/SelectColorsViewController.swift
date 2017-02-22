//
//  ColorsViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/19/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa

class SelectColorsViewController: NSViewController {
    var menuSupporter = MenuSupporter()
    let pstyle = NSMutableParagraphStyle()
    
    var youColorButtons = [NSButton]()
    var firstRowPre = NSButton()
    
    var player2ColorButtons = [NSButton]()
    var secondRowPre = NSButton()
    
    @IBOutlet weak var difficulty: NSButton!
    @IBAction func difficultyButton(_ sender: NSButton) {
        let attribute = getAttribute()
        
        if sender.title == "AI Easy"{
            sender.attributedTitle = NSAttributedString(string: "AI Medium", attributes: attribute)
        } else if sender.title == "AI Medium" {
            sender.attributedTitle = NSAttributedString(string: "AI Hard", attributes: attribute)
        } else {
            sender.attributedTitle = NSAttributedString(string: "AI Easy", attributes: attribute)
        }
    }
    
    @IBOutlet weak var youColorButton1: NSButton!
    @IBOutlet weak var youColorButton2: NSButton!
    @IBOutlet weak var youColorButton3: NSButton!
    @IBOutlet weak var youColorButton4: NSButton!
    @IBOutlet weak var youColorButton5: NSButton!
    @IBOutlet weak var youColorButton6: NSButton!
    @IBOutlet weak var youColorButton7: NSButton!
    @IBOutlet weak var youColorButton8: NSButton!
    
    @IBAction func youColorButton1(_ sender: NSButton) {
        modifyButton(sender, firstRow: true)
    }
    @IBAction func youColorButton2(_ sender: NSButton) {
        modifyButton(sender, firstRow: true)
    }
    @IBAction func youColorButton3(_ sender: NSButton) {
        modifyButton(sender, firstRow: true)
    }
    @IBAction func youColorButton4(_ sender: NSButton) {
        modifyButton(sender, firstRow: true)
    }
    @IBAction func youColorButton5(_ sender: NSButton) {
        modifyButton(sender, firstRow: true)
    }
    @IBAction func youColorButton6(_ sender: NSButton) {
        modifyButton(sender, firstRow: true)
    }
    @IBAction func youColorButton7(_ sender: NSButton) {
        modifyButton(sender, firstRow: true)
    }
    @IBAction func youColorButton8(_ sender: NSButton) {
        modifyButton(sender, firstRow: true)
    }
    
    
    @IBOutlet weak var player2ColorButton1: NSButton!
    @IBOutlet weak var player2ColorButton2: NSButton!
    @IBOutlet weak var player2ColorButton3: NSButton!
    @IBOutlet weak var player2ColorButton4: NSButton!
    @IBOutlet weak var player2ColorButton5: NSButton!
    @IBOutlet weak var player2ColorButton6: NSButton!
    @IBOutlet weak var player2ColorButton7: NSButton!
    @IBOutlet weak var player2ColorButton8: NSButton!
    
    @IBAction func player2ColorButton1(_ sender: NSButton) {
        modifyButton(sender, firstRow: false)
    }
    @IBAction func player2ColorButton2(_ sender: NSButton) {
        modifyButton(sender, firstRow: false)
    }
    @IBAction func player2ColorButton3(_ sender: NSButton) {
        modifyButton(sender, firstRow: false)
    }
    @IBAction func player2ColorButton4(_ sender: NSButton) {
        modifyButton(sender, firstRow: false)
    }
    @IBAction func player2ColorButton5(_ sender: NSButton) {
        modifyButton(sender, firstRow: false)
    }
    @IBAction func player2ColorButton6(_ sender: NSButton) {
        modifyButton(sender, firstRow: false)
    }
    @IBAction func player2ColorButton7(_ sender: NSButton) {
        modifyButton(sender, firstRow: false)
    }
    @IBAction func player2ColorButton8(_ sender: NSButton) {
        modifyButton(sender, firstRow: false)
    }
    
    
    @IBOutlet weak var playGameButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!
    
    @IBAction func playGameButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "playGameSegue", sender: sender)
    }
    @IBAction func cancelButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "cancelSelectColorsSegue", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youColorButtons = [youColorButton1, youColorButton2, youColorButton3, youColorButton4, youColorButton5, youColorButton6, youColorButton7, youColorButton8]
        firstRowPre = youColorButton1
    
        player2ColorButtons = [player2ColorButton1, player2ColorButton2, player2ColorButton3, player2ColorButton4, player2ColorButton5, player2ColorButton6, player2ColorButton7, player2ColorButton8]
        secondRowPre = player2ColorButton1
        
        let attribute = getAttribute()
       
        difficulty.attributedTitle = NSAttributedString(string: "AI Easy", attributes: attribute)
        youColorButton1.attributedTitle = NSAttributedString(string: "X", attributes: attribute)
        player2ColorButton2.attributedTitle = NSAttributedString(string: "X", attributes: attribute)
        playGameButton.attributedTitle = NSAttributedString(string: playGameButton.title, attributes: attribute)
        cancelButton.attributedTitle = NSAttributedString(string: cancelButton.title, attributes: attribute)
        

    }
    
    func playGame() {
        performSegue(withIdentifier: "playGameSegue", sender: self)
        menuSound.stop()
    }
    
    func getAttribute() -> [String: AnyObject] {
        pstyle.alignment = .center
        var attributes = [String: AnyObject]()
        
        attributes[NSFontAttributeName] = NSFont(name: "Apple Chancery", size: 18)
        attributes[NSForegroundColorAttributeName] = NSColor.yellow
        attributes[NSParagraphStyleAttributeName] = pstyle
        
        return attributes
    }
    
    func modifyButton(_ sender: NSButton, firstRow: Bool) {
        pstyle.alignment = .center
        sender.attributedTitle = NSAttributedString(string: "X", attributes: [ NSForegroundColorAttributeName: NSColor.yellow, NSParagraphStyleAttributeName: pstyle])
        clearOtherButtons(sender, firstRow: firstRow)
    }
    
    
    func clearOtherButtons(_ sender: NSButton, firstRow: Bool) {
        var currentRow = [NSButton]()
        var otherRow = [NSButton]()
        var currentPre = firstRowPre
        var otherPre = firstRowPre
        var preIndex = youColorButtons.startIndex
        
        if firstRow {
            currentRow = youColorButtons
            otherRow = player2ColorButtons
            currentPre = firstRowPre
            otherPre = secondRowPre
        }else {
            currentRow = player2ColorButtons
            otherRow = youColorButtons
            currentPre = secondRowPre
            otherPre = firstRowPre
        }
        
        //clear X in current row
        for button in currentRow {
            if button != sender && button.title == "X" {
                button.title = ""
            }
        }
        
        //get sender's index
        let senderIndex = currentRow.index(of: sender)
        
        
        //check second row for overlap
        if otherRow[senderIndex!].title == "X" {
            //clear
            otherRow[senderIndex!].title = ""
            
            //get the preIndex
            preIndex = currentRow.index(of: currentPre)!
            
            //set to currentPre
            pstyle.alignment = .center
            otherRow[preIndex].attributedTitle = NSAttributedString(string: "X", attributes: [ NSForegroundColorAttributeName: NSColor.yellow, NSParagraphStyleAttributeName: pstyle])
            
            currentPre = sender
            otherPre = otherRow[preIndex]
        }
        
        if firstRow {
            firstRowPre = currentPre
            secondRowPre = otherPre
        } else {
            firstRowPre = otherPre
            secondRowPre = currentPre
            
        }
    }
    
}


