//
//  GameViewController.swift
//  WarcraftOSX
//
//  Created by Michelle Lee on 1/28/17.
//  Copyright © 2017 Michelle Lee. All rights reserved.
//

import Cocoa
import AVFoundation

var mainMapOffsetX = 0
var mainMapOffsetY = 0
var clickedXpos = 0
var clickedYpos = 0

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
    
    var game1SoundURL: URL?
    var game1SoundBankURL: URL?
    var game1Sound = AVMIDIPlayer()
    
    private let mapIndex = 0
    var gameModel: GameModel!
    var selectedPeasant: PlayerAsset?
    private var OSXCustomViewMap: OSXCustomView!
    
    @IBOutlet weak var miniView: NSView!
    @IBOutlet weak var mainMapView: NSView!
    @IBOutlet weak var miniMapView: NSView!
    @IBOutlet weak var testXLoc: NSTextField!
    @IBOutlet weak var testYLoc: NSTextField!
    @IBOutlet weak var tileXLoc: NSTextField!
    @IBOutlet weak var tileYLoc: NSTextField!
    @IBOutlet weak var mini: NSView!
    

    private lazy var midiPlayer: AVMIDIPlayer = {
        let gameURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/music/game1", ofType: "mid"))!)
        let soundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/generalsoundfont", ofType: "sf2"))!)
        
        do {
            return try AVMIDIPlayer(contentsOf: gameURL, soundBankURL: soundURL)
        } catch {
            fatalError(error.localizedDescription) // TODO: Handle Error
        }
    }()
    
    private lazy var acknowledgeSound: AVAudioPlayer = {
        do {
            var acknowledgeSound = AVAudioPlayer()
            let acknowledge1URL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/basic/acknowledge1", ofType: "wav"))!)
            try acknowledgeSound = AVAudioPlayer(contentsOf: acknowledge1URL)
            return acknowledgeSound
        } catch {
            let error = NSError.init(domain: "Failed to load Audio Player", code: 0, userInfo: nil)
            fatalError(error.localizedDescription)
        }
        
    }()
    
    private lazy var map: AssetDecoratedMap = {
        do {
            let mapURL = Bundle.main.url(forResource: "/data/map", withExtension: nil)
            let mapsContainer = try FileDataContainer(url: mapURL!)
            AssetDecoratedMap.loadMaps(from: mapsContainer)
            return AssetDecoratedMap.map(at: self.mapIndex)
        } catch {
            fatalError(error.localizedDescription) // TODO: Handle Error
        }
    }()
    
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
            let assetURL = Bundle.main.url(forResource: "/data/res", withExtension: nil)!
            try PlayerAssetType.loadTypes(from: FileDataContainer(url: assetURL))
            let playerData = PlayerData(map: self.map, color: .blue)
            _ = PlayerData(map: self.map, color: .none)
            _ = PlayerData(map: self.map, color: .red)
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
    
    private lazy var fogRenderer: FogRenderer = {
        do {
            let fogTileset = try tileset("Fog")
            return try FogRenderer(tileset: fogTileset, map: self.map.createVisibilityMap())
        } catch {
            fatalError(error.localizedDescription) // TODO: Handle Error
        }
    }()
    
    private lazy var viewportRenderer: ViewportRenderer = {
        return ViewportRenderer(mapRenderer: self.mapRenderer, assetRenderer: self.assetRenderer, fogRenderer: self.fogRenderer)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OSXCustomViewMap = OSXCustomView(frame: CGRect(origin: .zero, size: CGSize(width: mapRenderer.detailedMapWidth, height: mapRenderer.detailedMapHeight)), viewportRenderer: viewportRenderer)
        let OSXCustomMiniMapViewMap = OSXCustomMiniMapView(frame: CGRect(origin: .zero, size: CGSize(width: mapRenderer.mapWidth, height: mapRenderer.mapHeight)), mapRenderer: mapRenderer)
        
        gameModel = GameModel(mapIndex: self.mapIndex, seed: 0x123_4567_89ab_cdef, newColors: PlayerColor.getAllValues())
        
        mainMapView.addSubview(OSXCustomViewMap)
        miniMapView.addSubview(OSXCustomMiniMapViewMap)
        
        let NSGesture = NSClickGestureRecognizer(target: self, action: #selector(gestureRec))
        self.OSXCustomViewMap.addGestureRecognizer(NSGesture)

    }
    
    @IBAction func gestureRec(_ sender: NSClickGestureRecognizer) {
        let target = PlayerAsset(playerAssetType: PlayerAssetType())
        let touchLocation = sender.location(in: self.OSXCustomViewMap)
        let xLocation = (Int(touchLocation.x) - Int(touchLocation.x) % 32) + 16
        // let xTileLocation = xLocation / 32
        let yLocation = (Int(touchLocation.y) - Int(touchLocation.y) % 32) + 16
        // let yTileLocation = yLocation / 32
        target.position = Position(x: xLocation, y: yLocation)
        // let tileTargetPosition = Position(x: xTileLocation, y: yTileLocation)
        print(target.position.x, target.position.y)
        
        if selectedPeasant != nil {
            print("IF PART")
            selectedPeasant!.pushCommand(AssetCommand(action: .walk, capability: .buildPeasant, assetTarget: target, activatedCapability: nil))
            selectedPeasant = nil
            viewDidAppear(animated: true)
        } else {
            for asset in gameModel.actualMap.assets { //self.map.assets {
                if asset.assetType.name == "Peasant" && asset.position.distance(position: target.position) < 64 {
                    selectedPeasant = asset
                    acknowledgeSound.prepareToPlay()
                    acknowledgeSound.play()
                    print("ELSE PART")
                    
                    break
                }
            }
        }
    }
    
    func viewDidAppear(animated: Bool) {
        do {
            try gameModel.timestep()
            OSXCustomViewMap.needsDisplay = true
        } catch {
            fatalError("Error Thrown By Timestep")
        }
    }
    
    
/*    override func mouseDown(with event: NSEvent) {
        let xMouseLoc = event.locationInWindow.x - self.mainMapView.frame.origin.x
        let yMouseLoc = event.locationInWindow.y - self.mainMapView.frame.origin.y
        
        clickedXpos = Int(xMouseLoc + CGFloat(mainMapOffsetX))
        clickedYpos = Int(yMouseLoc + CGFloat(mainMapOffsetY))
        
        let tileXlocation = (clickedXpos - (clickedXpos % 32)) / 32
        let tileYlocation = 64 - (clickedYpos - (clickedYpos % 32)) / 32
        let targetAsset = PlayerAsset(playerAssetType: PlayerAssetType())
        
        targetAsset.position = Position(x: Int(tileXlocation), y: Int(tileYlocation))
        print(targetAsset.position.x, targetAsset.position.y)
        
        if selectedPeasant != nil {
            print("IF PART")
            selectedPeasant!.pushCommand(AssetCommand(action: .walk, capability: .buildPeasant, assetTarget: targetAsset, activatedCapability: nil))
            selectedPeasant = nil
            viewDidAppear(animated: true)
        } else {
            for asset in self.map.assets {
                if asset.assetType.name == "Peasant" && targetAsset.position.x == 10 && targetAsset.position.y == 11 {
                    selectedPeasant = asset
                    print("ELSE PART")
                    break
                }
            }
        }
    
        testXLoc.stringValue = String(describing: tileXlocation)
        testYLoc.stringValue = String(describing: tileYlocation)
        tileXLoc.stringValue = String(describing: clickedXpos)
        tileYLoc.stringValue = String(describing: clickedYpos)
        
    }*/
    
    
    func playBackgroundMusic() {
        game1SoundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/music/game1", ofType: "mid"))!)
        game1SoundBankURL = Bundle.main.url(forResource: "data/snd/generalsoundfont", withExtension: "sf2")
        
        do {
            try game1Sound = AVMIDIPlayer(contentsOf: game1SoundURL!, soundBankURL: game1SoundBankURL)
        }
        catch {
            NSLog("Error: Can't play sound file menu.mid")
        }
//        game1Sound.prepareToPlay()
//        game1Sound.play()
    }

    
}
