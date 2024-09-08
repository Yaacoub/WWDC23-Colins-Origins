import SpriteKit

final class Level3_1Scene: Level {
    
    
    
    // MARK: - Level Properties
    
    override var destination: SKScene? { Level3_2Scene(controller: controller, color1: colorColin, color2: colorShay, size: size) }
    override var title: String { "Level 3.1 : THE CITY (DUSK)" }
    
    override var dialog: [DialogLine] {[
        DialogLine(speaker: .colin, sentence: "Okay, let's talk about saturation.", emotion: .happy),
        DialogLine(speaker: .shay, sentence: "What's that?", emotion: .curious),
        DialogLine(speaker: .colin, sentence: "It's how intense a color is…", emotion: .funny),
        DialogLine(speaker: .colin, sentence: "…We can find it by mixing our hue and brightness with a gray also based on the color's brightness.", emotion: .funny),
        DialogLine(speaker: .shay, sentence: "This is getting complicated.", emotion: .sad),
        DialogLine(speaker: .colin, sentence: "It's okay, we're almost there. You'll see that it's not that hard!", emotion: .happy)
    ]}
    
    override var learnMore: [MarkdownSection] {[
        MarkdownSection(title: "Saturation", body: """
Saturation is how intense or vibrant a color appears relative to its brightness. That's why we determine it before saturation in Level 2.

To desaturate a color, we can mix it with a gray that has the same brightness level as the color. If the color is at maximum brightness, the gray will be white, and black at minimum brightness. The mixing process involves decreasing the color's opacity on the gray background. The final saturation value will be equal to the color's opacity.
""", image: .learnMoreSaturation)
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
    
    
    
    // MARK: - Level Methods
    
    override func advanceLevel() {
        characterColin?.physicsBody?.applyAngularImpulse(-80)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            super.advanceLevel()
        }
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setupBackgroundNode() {
        let background = Asset.propCityDusk.image
        let carSmoke = Asset.propSmokeDay.image
        let cars = Asset.propCarsDusk.image
        let grass = Asset.propGrassDay.image
        let sun = Asset.propSun.image
        backgroundNode = BackgroundNode(background: background, carSmoke: carSmoke, cars: cars, celestialBody: sun, grass: grass, size: size)
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundNode.backgroundBody.run(.move(by: CGVector(dx: frame.width / 2, dy: 0), duration: 0))
        insertChild(backgroundNode, at: 0)
    }
    
    private func setupCharacterColin() {
        characterColin = CharacterNode(color: colorColin)
        characterColin?.position = CGPoint(x: frame.midX - 200, y: frame.maxY)
        guard let characterColin else { return }
        addChild(characterColin)
    }
    
    private func setupCharacterShay() {
        characterShay = CharacterNode(color: colorShay)
        characterShay?.position = CGPoint(x: frame.midX + 200, y: frame.maxY)
        guard let characterShay else { return }
        addChild(characterShay)
    }
    
}
