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
    let tilesetURL = Bundle.main.url(forResource: "/data/img/\(name)", withExtension: "dat")!
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
        midiPlayer.prepareToPlay()
        midiPlayer.play()
        
        let mapView = OSXCustomView(frame: CGRect(origin: .zero, size: CGSize(width: mapRenderer.detailedMapWidth, height: mapRenderer.detailedMapHeight)), mapRenderer: mapRenderer, assetRenderer: assetRenderer)
        //let miniMapView = MiniMapView(frame: CGRect(origin: .zero, size: CGSize(width: mapRenderer.mapWidth, height: mapRenderer.mapHeight)), mapRenderer: mapRenderer)
        view.addSubview(mapView)
        //view.addSubview(miniMapView)
        
    }
    
}
