//
//  GameViewController.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation


fileprivate func tileset(with name: String) throws -> GraphicMulticolorTileset {
    let tilesetURL = Bundle.main.url(forResource: name, withExtension: "dat")!
    let tilesetSource = try FileDataSource(url: tilesetURL)
    let tileset = GraphicMulticolorTileset()
    try tileset.loadTileset(from: tilesetSource)
    return tileset
}

class GameViewController: NSViewController {

    @IBOutlet var mainGameView: NSView!
    @IBOutlet weak var gameSideBarView: NSView!
     @IBOutlet weak var mainMapView: OSXCustomView!
    @IBOutlet weak var resourceBarView: NSView!
    
    
    private lazy var midiPlayer: AVMIDIPlayer = {
        do {
            let soundFont = Bundle.main.url(forResource: "generalsoundfont", withExtension: "sf2")!
            let midiFile = Bundle.main.url(forResource: "intro", withExtension: "mid")!
            return try AVMIDIPlayer(contentsOf: midiFile, soundBankURL: soundFont)
        } catch {
            fatalError(error.localizedDescription) // TODO: Handle Error
        }
        
    }()
    
    private lazy var map: AssetDecoratedMap = {
        do {
            let mapURL = Bundle.main.url(forResource: "maze", withExtension: "map")!
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
            let configurationURL = Bundle.main.url(forResource: "MapRendering", withExtension: "dat")!
            let configuration = try FileDataSource(url: configurationURL)
            let terrainTileset = try tileset(with: "Terrain")
            return try MapRenderer(configuration: configuration, tileset: terrainTileset, map: self.map)
        } catch {
            fatalError(error.localizedDescription) // TODO: Handle Error
        }
    }()
    
    private lazy var assetRenderer: AssetRenderer = {
        do {
            let colors = GraphicRecolorMap()
            var tilesets: [GraphicMulticolorTileset] = Array(repeating: GraphicMulticolorTileset(), count: AssetType.max.rawValue)
            tilesets[AssetType.peasant.rawValue] = try tileset(with: "Peasant")
            tilesets[AssetType.footman.rawValue] = try tileset(with: "Footman")
            tilesets[AssetType.archer.rawValue] = try tileset(with: "Archer")
            tilesets[AssetType.ranger.rawValue] = try tileset(with: "Ranger")
            tilesets[AssetType.goldMine.rawValue] = try tileset(with: "GoldMine")
            tilesets[AssetType.townHall.rawValue] = try tileset(with: "TownHall")
            tilesets[AssetType.keep.rawValue] = try tileset(with: "Keep")
            tilesets[AssetType.castle.rawValue] = try tileset(with: "Castle")
            tilesets[AssetType.farm.rawValue] = try tileset(with: "Farm")
            tilesets[AssetType.barracks.rawValue] = try tileset(with: "Barracks")
            tilesets[AssetType.lumberMill.rawValue] = try tileset(with: "LumberMill")
            tilesets[AssetType.blacksmith.rawValue] = try tileset(with: "Blacksmith")
            tilesets[AssetType.scoutTower.rawValue] = try tileset(with: "ScoutTower")
            tilesets[AssetType.guardTower.rawValue] = try tileset(with: "GuardTower")
            tilesets[AssetType.cannonTower.rawValue] = try tileset(with: "CannonTower")
            let markerTileset = try tileset(with: "Marker")
            let corpseTileset = try tileset(with: "Corpse")
            let fireTilesets = [try tileset(with: "FireSmall"), try tileset(with: "FireLarge")]
            let buildingDeathTileset = try tileset(with: "BuildingDeath")
            let arrowTileset = try tileset(with: "Arrow")
            let playerData: PlayerData? = nil
            let assetRenderer = AssetRenderer(
                colors: colors,
                tilesets: tilesets,
                markerTileset: markerTileset,
                corpseTileset: corpseTileset,
                fireTilesets: fireTilesets,
                buildingDeathTileset: buildingDeathTileset,
                arrowTileset: arrowTileset,
                player: playerData,
                map: self.map
            )
            return assetRenderer
        } catch {
            fatalError(error.localizedDescription) // TODO: Handle Error
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
