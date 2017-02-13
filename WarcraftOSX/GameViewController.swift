//
//  GameViewController.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
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

fileprivate func multicolorTileset(_ name: String) throws -> GraphicMulticolorTileset {
    guard let tilesetURL = Bundle.main.url(forResource: "/data/img/\(name)", withExtension: "dat") else {
        throw GraphicTileset.GameError.failedToGetPath
    }
    let tilesetSource = try FileDataSource(url: tilesetURL)
    let tileset = GraphicMulticolorTileset()
    try tileset.loadTileset(from: tilesetSource)
    return tileset
}

class GameViewController: NSViewController {    
    
    let object = StatObjects()
    var peasantView = NSImageView()
    var peasant = NSImage()
    
    private lazy var midiPlayer: AVMIDIPlayer = {
        do {
            let soundFont = Bundle.main.url(forResource: "/data/snd/generalsoundfont", withExtension: "sf2")!
            let midiFile = Bundle.main.url(forResource: "/data/snd/music/intro", withExtension: "mid")!
            return try AVMIDIPlayer(contentsOf: midiFile, soundBankURL: soundFont)
        } catch {
            fatalError(error.localizedDescription) // TODO: Handle Error
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
    
    private lazy var mapRenderer: MapRenderer = {
        do {
            let configurationURL = Bundle.main.url(forResource: "/data/img/MapRendering", withExtension: "dat")!
            let configuration = try FileDataSource(url: configurationURL)
            let terrainTileset = try tileset("Terrain")
            return try MapRenderer(configuration: configuration, tileset: terrainTileset, map: self.map)
        } catch {
            let error = NSError.init(domain: "MapRenderer Error", code: 0, userInfo: nil)
            fatalError(error.localizedDescription)
        }
    }()
    
    private lazy var assetRenderer: AssetRenderer = {
        do {
            let colors = GraphicRecolorMap()
            var tilesets: [GraphicMulticolorTileset] = Array(repeating: GraphicMulticolorTileset(), count: AssetType.max.rawValue)
            tilesets[AssetType.peasant.rawValue] = try multicolorTileset("Peasant")
            tilesets[AssetType.footman.rawValue] = try multicolorTileset("Footman")
            tilesets[AssetType.archer.rawValue] = try multicolorTileset("Archer")
            tilesets[AssetType.ranger.rawValue] = try multicolorTileset("Ranger")
            tilesets[AssetType.goldMine.rawValue] = try multicolorTileset("GoldMine")
            tilesets[AssetType.townHall.rawValue] = try multicolorTileset("TownHall")
            tilesets[AssetType.keep.rawValue] = try multicolorTileset("Keep")
            tilesets[AssetType.castle.rawValue] = try multicolorTileset("Castle")
            tilesets[AssetType.farm.rawValue] = try multicolorTileset("Farm")
            tilesets[AssetType.barracks.rawValue] = try multicolorTileset("Barracks")
            tilesets[AssetType.lumberMill.rawValue] = try multicolorTileset("LumberMill")
            tilesets[AssetType.blacksmith.rawValue] = try multicolorTileset("Blacksmith")
            tilesets[AssetType.scoutTower.rawValue] = try multicolorTileset("ScoutTower")
            tilesets[AssetType.guardTower.rawValue] = try multicolorTileset("GuardTower")
            tilesets[AssetType.cannonTower.rawValue] = try multicolorTileset("CannonTower")
            let markerTileset = try tileset("Marker")
            let corpseTileset = try tileset("Corpse")
            let fireTilesets = [try tileset("FireSmall"), try tileset("FireLarge")]
            let buildingDeathTileset = try tileset("BuildingDeath")
            let arrowTileset = try tileset("Arrow")
            // let playerData = PlayerData(map: self.map, color: .blue)
            let assetRenderer = AssetRenderer(
                colors: colors,
                tilesets: tilesets,
                markerTileset: markerTileset,
                corpseTileset: corpseTileset,
                fireTilesets: fireTilesets,
                buildingDeathTileset: buildingDeathTileset,
                arrowTileset: arrowTileset,
                player: nil,
                map: self.map
            )
            return assetRenderer
        } catch {
            fatalError(error.localizedDescription) // TODO: Handle Error
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        midiPlayer.prepareToPlay()
        midiPlayer.play()
        
        let mapView = OSXCustomView(frame: CGRect(origin: .zero, size: CGSize(width: mapRenderer.detailedMapWidth, height: mapRenderer.detailedMapHeight)), mapRenderer: mapRenderer, assetRenderer: assetRenderer)
        let miniMapView = MiniMapView(frame: CGRect(origin: .zero, size: CGSize(width: mapRenderer.mapWidth, height: mapRenderer.mapHeight)), mapRenderer: mapRenderer)
        view.addSubview(mapView)
        view.addSubview(miniMapView)
        
//
        object.viewDidLoad()
        
        peasantView = NSImageView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
        peasant = NSImage(cgImage: (object.objectDictArray["Peasant"]![0]), size: NSZeroSize)
        peasantView.image = peasant
        view.addSubview(peasantView)
        
        var xPos = 100
        var yPos = 0
        
        for i in 1 ..< 4 {
            let imageView = NSImageView(frame: NSRect(x: xPos, y: yPos, width: 100, height: 100))
            let images = NSImage(cgImage: (object.objectDictArray[object.objectNames[i]]![0]), size: NSZeroSize)
            imageView.image = images
            view.addSubview(imageView)
            xPos += 100
        }
        
        xPos = 50
        yPos = 150
        
        for i in 4 ..< 9 {
            let imageView = NSImageView(frame: NSRect(x: xPos, y: yPos, width: 100, height: 100))
            let images = NSImage(cgImage: (object.objectDictArray[object.objectNames[i]]![0]), size: NSZeroSize)
            imageView.image = images
            view.addSubview(imageView)
            xPos += 100
        }
        
        xPos = 0
        yPos = 250
        
        for i in 9 ..< object.objectDictArray.count {
            let imageView = NSImageView(frame: NSRect(x: xPos, y: yPos, width: 100, height: 100))
            let images = NSImage(cgImage: (object.objectDictArray[object.objectNames[i]]![2]), size: NSZeroSize)
            imageView.image = images
            view.addSubview(imageView)
            xPos += 100
        }
        
        let mouseTrackingArea = NSTrackingArea(rect: peasantView.bounds, options: [NSTrackingAreaOptions.mouseEnteredAndExited, NSTrackingAreaOptions.mouseMoved,NSTrackingAreaOptions.activeInActiveApp], owner: self, userInfo: nil)
        
        peasantView.addTrackingArea(mouseTrackingArea)
        
    }
    
    
    override func mouseDown(with event: NSEvent) {
        
        var npeasantView = NSImageView()
        var npeasant = NSImage()
        
        if (Int(NSEvent.mouseLocation().y) > 250 && Int(NSEvent.mouseLocation().x) < 425) {
            npeasantView = NSImageView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
            npeasant = NSImage(cgImage: (object.objectDictArray["Peasant"]![0]), size: NSZeroSize)
            npeasantView.image = npeasant
            view.replaceSubview(peasantView, with: npeasantView)
            peasantView = npeasantView
        }
        else if (Int(NSEvent.mouseLocation().x) > 415 && Int(NSEvent.mouseLocation().y) > 275) {
            npeasantView = NSImageView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
            npeasant = NSImage(cgImage: (object.objectDictArray["Peasant"]![5]), size: NSZeroSize)
            npeasantView.image = npeasant
            view.replaceSubview(peasantView, with: npeasantView)
            peasantView = npeasantView
        }
        else if (Int(NSEvent.mouseLocation().y) < 350 && Int(NSEvent.mouseLocation().x) > 425) {
            npeasantView = NSImageView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
            npeasant = NSImage(cgImage: (object.objectDictArray["Peasant"]![10]), size: NSZeroSize)
            npeasantView.image = npeasant
            view.replaceSubview(peasantView, with: npeasantView)
            peasantView = npeasantView
        }
//
        
    }
    
}
