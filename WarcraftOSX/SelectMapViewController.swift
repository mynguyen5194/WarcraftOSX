//
//  SinglePlayerViewController.swift
//  WarcraftOSX
//
//  Created by My Nguyen on 2/14/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

fileprivate func tileset(_ name: String) throws -> GraphicTileset {
    guard let tilesetURL = Bundle.main.url(forResource: "/data/img/\(name)", withExtension: "dat") else {
        throw GraphicTileset.GameError.failedToGetPath
    }
    let tilesetSource = try FileDataSource(url: tilesetURL)
    let tileset = GraphicTileset()
    try tileset.loadTileset(from: tilesetSource)
    return tileset
}

class SelectMapViewController: NSViewController {
    var menuSupporter = MenuSupporter()
    
    @IBOutlet weak var miniMapView: NSView!
    
    @IBOutlet weak var selectButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!
    @IBOutlet weak var northSouthDivideText: NSTextField!
    @IBOutlet weak var mazeText: NSTextField!

    @IBAction func northSouthDivide(_ sender: NSTextField) {
        print("North-South Divide Clicked")
        
//        mazeText.textColor = NSColor.white
//        northSouthDivideText.textColor = NSColor.yellow
    }
    
    @IBAction func maze(_ sender: NSTextField) {
        print("Maze Clicked")
        
//        northSouthDivideText.textColor = NSColor.white
//        mazeText.textColor = NSColor.yellow
    }
    
    
    @IBAction func selectButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "selectSegue", sender: sender)
    }
    @IBAction func cancelButton(_ sender: NSButton) {
        thunkSound.play()
        self.performSegue(withIdentifier: "cancelSelectMapSegue", sender: sender)
    }
    
    private lazy var mapRenderer: MapRenderer = {
        do {
            let configurationURL = Bundle.main.url(forResource: "/data/img/MapRendering", withExtension: "dat")!
            let configuration = try FileDataSource(url: configurationURL)
            let terrainTileset = try tileset("Terrain")
            Position.setTileDimensions(width: terrainTileset.tileWidth, height: terrainTileset.tileHeight)
            return try MapRenderer(configuration: configuration, tileset: terrainTileset, map: self.map)
        } catch {
            let error = NSError.init(domain: "MapRenderer Error", code: 0, userInfo: nil)
            fatalError(error.localizedDescription)
        }
    }()
    
    private lazy var map: AssetDecoratedMap = {
        do {
            let mapURL = Bundle.main.url(forResource: "/data/map/maze", withExtension: "map")!
            let mapSource = try FileDataSource(url: mapURL)
            let map = AssetDecoratedMap()
            try map.loadMap(source: mapSource)
            return map
        } catch {
            fatalError(error.localizedDescription) // TODO: Handle Error
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSupporter.formatButtonTitle(sender: selectButton, color: NSColor.yellow, title: selectButton.title, fontSize: 18)
        menuSupporter.formatButtonTitle(sender: cancelButton, color: NSColor.yellow, title: cancelButton.title, fontSize: 18)
        
        let OSXCustomMiniMapViewMap = OSXCustomMiniMapView(frame: CGRect(origin: .zero, size: CGSize(width: mapRenderer.mapWidth, height: mapRenderer.mapHeight)), mapRenderer: mapRenderer)
        
        //self.titleVisibility = NSWindowTitleVisibility.Hidden;
        miniMapView.addSubview(OSXCustomMiniMapViewMap)
        
    }
    
    
    
}
