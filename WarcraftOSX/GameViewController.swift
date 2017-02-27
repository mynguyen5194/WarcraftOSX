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
    var selectedPeasant: PlayerAsset?
    //var mapType: SelectMapViewController?
    
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
    
    private lazy var map: AssetDecoratedMap = {
        do {
            let mapDirectoryURL = Bundle.main.url(forResource: "/data/map", withExtension: nil)!
            try AssetDecoratedMap.loadMaps(from: FileDataContainer(url: mapDirectoryURL))
            
            let forResource = "/data/map/" + SelectMapViewController().mapName
            let lowerCase = forResource.lowercased()
            print (lowerCase)
            let mapURL = Bundle.main.url(forResource: lowerCase, withExtension: "map")!

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
        
        do {
            menuSound.stop()
            midiPlayer.prepareToPlay()
            midiPlayer.play()
            let terrainGraphicTilesset = try tileset("Terrain")
            Position.setTileDimensions(width: terrainGraphicTilesset.tileWidth, height: terrainGraphicTilesset.tileHeight)
        } catch {
            let nsError = NSError.init(domain: "Failed to initialize Terrain Graphic Tileset", code: 0, userInfo: nil)
            fatalError(nsError.localizedDescription)
        }

        let OSXCustomViewMap = OSXCustomView(frame: CGRect(origin: .zero, size: CGSize(width: mapRenderer.detailedMapWidth, height: mapRenderer.detailedMapHeight)), viewportRenderer: viewportRenderer)
        let OSXCustomMiniMapViewMap = OSXCustomMiniMapView(frame: CGRect(origin: .zero, size: CGSize(width: mapRenderer.mapWidth, height: mapRenderer.mapHeight)), mapRenderer: mapRenderer)
        
        let clickGestureRecognizer: NSGestureRecognizer = NSGestureRecognizer.init(target: self, action: #selector(mouseClickAction))
        mainMapView.addGestureRecognizer(clickGestureRecognizer)
        OSXCustomViewMap.addGestureRecognizer(clickGestureRecognizer)
        
        mainMapView.addSubview(OSXCustomViewMap)
        miniView.addSubview(OSXCustomMiniMapViewMap)
        
        
        
    }
    
    @IBAction func mouseClickAction(_ sender: NSClickGestureRecognizer) {
        let gameModel = GameModel(mapIndex: 0, seed: 0x0123_4567_89ab_cdef, newColors: PlayerColor.getAllValues())
        let target = PlayerAsset(playerAssetType: PlayerAssetType())
        let touchLocation = sender.location(in: mainMapView)
        let xLocation = (Int(touchLocation.x) - Int(touchLocation.x) % 32) + 16
        let yLocation = (Int(touchLocation.y) - Int(touchLocation.y) % 32) + 16
        target.position = Position(x: xLocation, y: yLocation)
        if selectedPeasant != nil {
            selectedPeasant!.pushCommand(AssetCommand(action: .walk, capability: .buildPeasant, assetTarget: target, activatedCapability: nil))
            selectedPeasant = nil
        } else {
            for asset in gameModel.actualMap.assets {
                if asset.assetType.name == "Peasant" && asset.position.distance(position: target.position) < 64 {
                    selectedPeasant = asset
                }
            }
        }
        printDebug("mouseClickAction Triggered")
    }

    
    override func viewDidAppear() {
      
        //In Progress
        /*
        var loadingPlayerColors: [PlayerColor]
        
        loadingPlayerColors = []
        for pcIndex in 0 ..< PlayerColor.numberOfColors{
            loadingPlayerColors.append(PlayerColor(index: pcIndex)!)
        }
        
        var playerCommands: [PlayerCommandRequest]
        playerCommands = []

        let currentPos = Position(x: Int(clickedXpos), y: Int(clickedYpos))
        let playCap = PlayerCommandRequest(action: .none, actors: self.map.assets, targetColor: .none, targetType: .none, targetLocation: currentPos)
        
        for _ in 0 ..< PlayerColor.numberOfColors{
            playerCommands.append(playCap)
        }
        
        //var canHarvest = true
        
        for asset in self.map.assets{
            if !asset.hasCapability(.mine) {
                canHarvest = false
                break
            }
        }
        var pixelType = PixelType
        
        if canHarvest{
            if(PixelType.AssetTerrainType.tree == PixelType.t){ //fix seeing if clicked on tree
                let tempTilePosition: Position
         
                playerCommands[PlayerColor.numberOfColors].action = .mine
                tempTilePosition.setToTile(currentPos)
            }
        }
        */
    }
    
    // variable that stores the mouse location
    var mouseLocation: NSPoint {
        return NSEvent.mouseLocation()
    }
    
    
    /*
    override func mouseDown(with event: NSEvent) {
        // event.locationInWindow is mouse location inside the window with bottom left of window (0,0)
        // -mainMapView.frame.origin to offset mainMapView relative to the entire window
        let xMouseLoc = event.locationInWindow.x - self.mainMapView.frame.origin.x
        let yMouseLoc = event.locationInWindow.y - self.mainMapView.frame.origin.y
        
        clickedXpos = Int(xMouseLoc + CGFloat(mainMapOffsetX))
        clickedYpos = Int(yMouseLoc + CGFloat(mainMapOffsetY))
        
        let tileXlocation = (clickedXpos - (clickedXpos % 32))
        let tileYlocation = (clickedYpos - (clickedYpos % 32))
        
        let targetAsset = PlayerAsset(playerAssetType: PlayerAssetType())
        targetAsset.position = Position(x: Int(tileXlocation), y: Int(tileYlocation))
        
        if selectedPeasant != nil {
            selectedPeasant!.pushCommand(AssetCommand(action: .walk, capability: .buildPeasant, assetTarget: target, activatedCapability: nil)
            selectedPeasant = nil
        } else {
            for asset in gameModel.actualMap.assets{
     
            }
        }
     
        // store position into the text field for testing purposes
        // change String parameter to NSEvent.mouseLocation() to track x and y position concurrently
        testXLoc.stringValue = String(describing: xMouseLoc)
        testYLoc.stringValue = String(describing: yMouseLoc)
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
        game1Sound.prepareToPlay()
        game1Sound.play()
    }

}
