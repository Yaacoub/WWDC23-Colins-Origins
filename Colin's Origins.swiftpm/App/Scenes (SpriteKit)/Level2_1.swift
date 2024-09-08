import SpriteKit

final class Level2_1Scene: Level {
    
    
    
    // MARK: - Level Properties
    
    override var destination: SKScene? { Level2_2Scene(controller: controller, color1: colorColin, color2: colorShay, size: size) }
    override var title: String { "Level 2.1 : THE CITY (NIGHT)" }
    
    override var dialog: [DialogLine] {[
        DialogLine(speaker: .colin, sentence: "We've got the right hue. Now we need to work on brightness.", emotion: .happy),
        DialogLine(speaker: .shay, sentence: "What's brightness again?", emotion: .funny),
        DialogLine(speaker: .colin, sentence: "Simply, it's how light or dark a color is.", emotion: .funny),
        DialogLine(speaker: .shay, sentence: "Oh, how do we change the color's brightness?", emotion: .curious),
        DialogLine(speaker: .colin, sentence: "We mix in some black with our hue to make it darker. That'll give us the right brightness.", emotion: .happy),
        DialogLine(speaker: .shay, sentence: "Let's give it a try!", emotion: .funny)
    ]}
    
    override var learnMore: [MarkdownSection] {[
        MarkdownSection(title: "Brightness", body: """
Brightness is how light or dark a color appears to the human eye, while luminance is the quantity of light that the color reflects or emits. The difference between these two relies on how we perceive light.

One easy way of adjusting a color's brightness is by blending it with either pure white or black. Since we want to reduce the brightness of the color, we can mix it with black. We do so by decreasing the color's opacity on a black background. The final brightness value will correspond to the opacity value.
""", image: .learnMoreBrightness)
    ]}
    
    
    
    // MARK: - Private Node Properties
    
    private var backgroundNode: BackgroundNode!
    private var backgroundWindows: SKSpriteNode!

    
    
    
    // MARK: - Lifecyle Methods
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupBackgroundNode()
        setupBackgroungWindows()
        setupCharacterColin()
        setupCharacterShay()
        setupTitle()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        backgroundNode.updateBrightness()
    }
    
    
    
    // MARK: - Level Methods
    
    override func advanceLevel() {
        characterColin?.physicsBody?.applyAngularImpulse(-40)
        characterShay?.physicsBody?.applyAngularImpulse(-40)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            super.advanceLevel()
        }
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setupBackgroundNode() {
        let background = Asset.propCityNight.image
        let grass = Asset.propGrassNight.image
        let moon = Asset.propMoon.image
        backgroundNode = BackgroundNode(background: background, celestialBody: moon, grass: grass, size: size)
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        insertChild(backgroundNode, at: 0)
    }
    
    private func setupBackgroungWindows() {
        let sequence = SKAction.repeatForever(.sequence([
            .run { [weak self] in self?.backgroundWindows.texture = SKTexture(image: Asset.propWindows1.image) },
            .wait(forDuration: 6),
            .run { [weak self] in self?.backgroundWindows.texture = SKTexture(image: Asset.propWindows2.image) },
            .wait(forDuration: 6),
            .run { [weak self] in self?.backgroundWindows.texture = SKTexture(image: Asset.propWindows3.image) },
            .wait(forDuration: 6),
        ]))
        let texture = SKTexture(image: Asset.propWindows1.image)
        backgroundWindows = SKSpriteNode(texture: texture)
        backgroundWindows.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundWindows.aspectFill(size: size)
        backgroundWindows.run(sequence)
        insertChild(backgroundWindows, at: 1)
    }
    
    private func setupCharacterColin() {
        characterColin = CharacterNode(color: colorColin)
        characterColin?.position = CGPoint(x: frame.midX - 200, y: frame.maxY * 2)
        guard let characterColin else { return }
        addChild(characterColin)
    }
    
    private func setupCharacterShay() {
        characterShay = CharacterNode(color: colorShay)
        characterShay?.position = CGPoint(x: frame.midX + 200, y: frame.midY)
        guard let characterShay else { return }
        addChild(characterShay)
    }
    
    private func setupTitle() {
        titleNode.fontColor = .white
    }
    
}
