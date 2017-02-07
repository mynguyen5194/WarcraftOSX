//
//  GameViewController.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation
import SceneKit
import SpriteKit

class GameViewController: NSViewController {

    @IBOutlet var mainGameView: NSView!
    @IBOutlet weak var gameSceneView: SKView!
    @IBOutlet weak var gameSideBarView: NSView!
    @IBOutlet weak var resourceBarView: NSView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let scene = GameScene(fileNamed: "GameScene") {
            // Configure the view.
            let skView: SKView = gameSceneView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .fill
            
            skView.presentScene(scene)
        }
        self.view = mainGameView

        /*
        do{
            
            //Loading Rendering Configuration about line 406 in ApplicationData.cpp
            let mapRenderingURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/MapRendering", ofType: "dat"))!)
            let mapDataSource = try FileDataSource(url: mapRenderingURL)
            
            //Loading Terrain about line 415 in ApplicationData.cpp
            let terrainTileset = GraphicTileset()
            let terrainURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/img/Terrain", ofType: "dat"))!)
            let terrainDataSource = try FileDataSource(url: terrainURL)
            try terrainTileset.loadTileset(from: terrainDataSource)
            
            //Loading Map about line 671 in ApplicationData.cpp
            let map2PlayerURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/map/2player", ofType: "map"))!)
            let map2PlayerAssetDec = AssetDecoratedMap()
            let map2PlayerDataSource = try FileDataSource(url: map2PlayerURL)
            try map2PlayerAssetDec.loadMap(source: map2PlayerDataSource)
            
            let map = try MapRenderer(configuration: mapDataSource, tileset: terrainTileset, map: map2PlayerAssetDec)
            
            
        } catch{
            print(error)
        }*/

        
    }
    
}
