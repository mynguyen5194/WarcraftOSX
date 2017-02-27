struct PlayerCommandRequest {
    var action: AssetCapabilityType
    var actors: [PlayerAsset]
    var targetColor: PlayerColor
    var targetType: AssetType
    var targetLocation: Position

    
    init(action: AssetCapabilityType, actors: [PlayerAsset], targetColor: PlayerColor, targetType: AssetType, targetLocation: Position) {
        self.action = action
        self.actors = actors
        self.targetColor = targetColor
        self.targetType = targetType
        self.targetLocation = targetLocation
    }

}
