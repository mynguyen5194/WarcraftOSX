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

fileprivate func url(_ pathComponents: String...) -> URL {
    return pathComponents.reduce(Bundle.main.url(forResource: "data", withExtension: nil)!, { result, pathComponent in
        return result.appendingPathComponent(pathComponent)
    })
}

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
    
    @IBOutlet weak var mainMapView: NSView!
    @IBOutlet weak var miniMapView: NSView!
    @IBOutlet weak var testXLoc: NSTextField!
    @IBOutlet weak var testYLoc: NSTextField!
    @IBOutlet weak var tileXLoc: NSTextField!
    @IBOutlet weak var tileYLoc: NSTextField!
    @IBOutlet weak var mini: NSView!
    private var selectedPeasant: PlayerAsset?
    private var peasantXLocation: Int?
    private var peasantYLocation: Int?
    private var CustomView: OSXCustomView?
    var gameModel: GameModel!
    private let mapIndex = 0

    
    private lazy var midiPlayer: AVMIDIPlayer = {
        let gameURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/music/intro", ofType: "mid"))!)
        let soundURL = URL(fileURLWithPath: (Bundle.main.path(forResource: "data/snd/generalsoundfont", ofType: "sf2"))!)
        
        do {
            return try AVMIDIPlayer(contentsOf: gameURL, soundBankURL: soundURL)
        } catch {
            fatalError(error.localizedDescription) // TODO: Handle Error
        }
    }()
    
    private func createAssetDecoratedMap() -> AssetDecoratedMap {
        do {
            let mapsContainer = try FileDataContainer(url: url("map"))
            AssetDecoratedMap.loadMaps(from: mapsContainer)
            return AssetDecoratedMap.map(at: self.mapIndex)
        } catch {
            fatalError(error.localizedDescription) // TODO: Handle Error
        }
    }
    
    private var map: AssetDecoratedMap!
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
    private func updateAssets() -> AssetRenderer {
        do {
            print("Updating assets")
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
            let playerData = PlayerData(map: self.map, color: .blue)
            //            _ = PlayerData(map: self.map, color: .blue)
            //            _ = PlayerData(map: self.map, color: .none)
            //            _ = PlayerData(map: self.map, color: .red)
            let assetRenderer = AssetRenderer(
                colors: colors,
                tilesets: tilesets,
                markerTileset: markerTileset,
                corpseTileset: corpseTileset,
                fireTilesets: fireTilesets,
                buildingDeathTileset: buildingDeathTileset,
                arrowTileset: arrowTileset,
                player: gameModel.player(with: .blue),
                map: gameModel.player(with: .blue).playerMap
            )
            return assetRenderer
        } catch {
            fatalError(error.localizedDescription) // TODO: Handle Error
        }
    }

    
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
    private func updateViewport() -> ViewportRenderer{
        return ViewportRenderer(mapRenderer: self.mapRenderer, assetRenderer: updateAssets(), fogRenderer: self.fogRenderer)
    }
    
    private lazy var viewportRenderer: ViewportRenderer = {
        return ViewportRenderer(mapRenderer: self.mapRenderer, assetRenderer: self.assetRenderer, fogRenderer: self.fogRenderer)
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        midiPlayer.prepareToPlay()
        midiPlayer.play()
        map = createAssetDecoratedMap()
        CustomView = OSXCustomView(frame: CGRect(origin: .zero, size: CGSize(width: mapRenderer.detailedMapWidth, height: mapRenderer.detailedMapHeight)), viewportRenderer: viewportRenderer)
        let OSXCustomMiniMapViewMap = OSXCustomMiniMapView(frame: CGRect(origin: .zero, size: CGSize(width: mapRenderer.mapWidth, height: mapRenderer.mapHeight)), mapRenderer: mapRenderer)
        gameModel = GameModel(mapIndex: self.mapIndex, seed: 0x123_4567_89ab_cdef, newColors: PlayerColor.getAllValues())
        
        //self.titleVisibility = NSWindowTitleVisibility.Hidden;
        view.addSubview(CustomView!)
        view.addSubview(OSXCustomMiniMapViewMap)
        print(gameModel)
        triggerAnimation()
 
    

        
    }
    func triggerAnimation() {
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleAnimationUpdates), userInfo: nil, repeats: true)
        
        /*let displayLink = CVDisplayLink(target: self, selector: #selector(handleAnimationUpdates))
        displayLink.frameInterval = 1
        displayLink.add(to: .current, forMode: .defaultRunLoopMode)*/
    }
    
    func handleAnimationUpdates() {
        let start = Date()
        
        do {
            
            try gameModel?.timestep()
            
        } catch {
            fatalError("Error Thrown By Timestep")
        }
        
        CustomView!.needsDisplay = true
        let finish = Date()
        
        let time = finish.timeIntervalSince(start)
        // print(time)
    }

 

    // variable that stores the mouse location
    var mouseLocation: NSPoint {
        return NSEvent.mouseLocation()
    }
    

    override func mouseDown(with event: NSEvent) {
        // event.locationInWindow is mouse location inside the window with bottom left of window (0,0)
        // -mainMapView.frame.origin to offset mainMapView relative to the entire window
        let xMouseLoc = event.locationInWindow.x - self.mainMapView.frame.origin.x
        let yMouseLoc = event.locationInWindow.x - self.mainMapView.frame.origin.y
        let target = PlayerAsset(playerAssetType: PlayerAssetType())
        
        let xTileLoc = xMouseLoc + CGFloat(mainMapOffsetX)
        let yTileLoc = yMouseLoc + CGFloat(mainMapOffsetY)
       // let xLocation = ((Int(xTileLoc) - Int(xTileLoc) % 32) + 16)
       // let xTileLocation = xLocation / 32
       // let yLocation = ((Int(xTileLoc) - Int(xTileLoc) % 32) + 16)
      //  let yTileLocation = yLocation / 32

        
        // store position into the text field for testing purposes
        // change String parameter to NSEvent.mouseLocation() to track x and y position concurrently
        testXLoc.stringValue = String(describing: xMouseLoc)
        testYLoc.stringValue = String(describing: yMouseLoc)
        tileXLoc.stringValue = String(describing: xTileLoc)
        tileYLoc.stringValue = String(describing: yTileLoc)
        target.position = Position(x: Int(xTileLoc), y: Int(yTileLoc))
   
       if selectedPeasant != nil {
        
            print("peasant already selected, attempting to move peasant")
            selectedPeasant!.pushCommand(AssetCommand(action: .walk, capability: .buildPeasant, assetTarget: target, activatedCapability: nil))
            selectedPeasant = nil
            print("Pushed peasant move command")
        } else {
            print("peasant not selected")
            for asset in gameModel.actualMap.assets {
                if asset.assetType.name == "Peasant"{
                print("Click Position is", xTileLoc, yTileLoc)
                print("Peasant position is",asset.position.x ,asset.position.y)
                print("Distance is", asset.position.distance(position: target.position))
                }
                if asset.assetType.name == "Peasant"  {
                    print("selected peasant")
                    selectedPeasant = asset
                }
            }
        }
        /*if selectedPeasant != nil {
            print("moving peasant")
            selectedPeasant!.pushCommand(AssetCommand(action: .walk, capability: .buildPeasant, assetTarget: target, activatedCapability: nil))
            print("pushed move command")
            selectedPeasant = nil
            CustomView = OSXCustomView(frame: CustomView!.frame, viewportRenderer: updateViewport())
            view.addSubview(CustomView!)

        } else {

            /*if (map.findNearestAsset(at: tileTargetPosition,color: PlayerColor.blue, type: AssetType.peasant).assetType.name  == "Peasant"){
                selectedPeasant = map.findNearestAsset(at: target.position,color: PlayerColor.blue, type: AssetType.peasant)
                peasantXLocation = Int(xTileLoc)
                peasantYLocation = Int(yTileLoc)
                print("peasant clicked")
            }*/
            for asset in map.assets {
                if asset.assetType.name == "Peasant"  {
                    print("selected peasant")
                    selectedPeasant = asset
                    
                }
            }
        }*/
        

    }
    
    /*var titleVisibility: NSWindowTitleVisibility{
        return NSWindowTitleVisibility.hidden
    }*/
    
}
