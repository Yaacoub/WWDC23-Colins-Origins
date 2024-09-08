import SpriteKit

final class Level0Scene: Level {
    
    
    
    // MARK: Level Properties
    
    override var destination: SKScene? { Level1_1Scene(controller: controller, color1: colorColin, color2: colorShay, size: size) }
    override var title: String { "Level 0 : THE FIELD" }
    
    override var dialog: [DialogLine] {[
        DialogLine(speaker: .colin, sentence: "Hey, Shay! Look, we're in a new place!", emotion: .funny),
        DialogLine(speaker: .shay, sentence: "Wow, that's cool! But where's mom? I miss her.", emotion: .sad),
        DialogLine(speaker: .colin, sentence: "Don't worry, Shay. We'll find her.", emotion: .happy),
        DialogLine(speaker: .shay, sentence: "How are we going to do that?", emotion: .curious),
        DialogLine(speaker: .colin, sentence: "Well, we need to mix our colors together to get a clue.", emotion: .funny),
        DialogLine(speaker: .shay, sentence: "Oh, like when we mix blue and yellow to get green?", emotion: .happy),
        DialogLine(speaker: .colin, sentence: "Exactly! We just need to figure out the right mix.", emotion: .happy),
        DialogLine(speaker: .shay, sentence: "Let's get started!", emotion: .funny)
    ]}
    
    
    
    // MARK: - Private Node Properties
    
    private var backgroundNode: BackgroundNode!
    
    
    
    // MARK: - Lifecyle Methods
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupBackgroundNode()
        setupCharacterColin()
        setupCharacterShay()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        backgroundNode.updateBrightness()
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setupBackgroundNode() {
        let background = Asset.propDirtAndSky.image
        let grass = Asset.propGrassDay.image
        let sun = Asset.propSun.image
        backgroundNode = BackgroundNode(background: background, celestialBody: sun, grass: grass, size: size)
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        insertChild(backgroundNode, at: 0)
    }
    
    private func setupCharacterColin() {
        characterColin = CharacterNode(color: colorColin)
        characterColin?.position = CGPoint(x: frame.midX - 200, y: frame.midY)
        guard let characterColin else { return }
        addChild(characterColin)
    }
    
    private func setupCharacterShay() {
        characterShay = CharacterNode(color: colorShay)
        characterShay?.position = CGPoint(x: frame.midX + 200, y: frame.maxY * 2)
        guard let characterShay else { return }
        addChild(characterShay)
    }
    
}
