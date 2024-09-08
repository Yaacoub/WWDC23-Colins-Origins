import SpriteKit

final class Level1_3Scene: Level {
    
    
    
    // MARK: - Level Properties
    
    override var destination: SKScene? { Level2_1Scene(controller: controller, color1: colorColin, color2: colorShay, size: size) }
    override var title: String { "Level 1.3 : HUE-STON" }
    
    override var dialog: [DialogLine] {[
        DialogLine(speaker: .colin, sentence: "Look, this is what our mom could look like!", emotion: .happy),
        DialogLine(speaker: .shay, sentence: "Hmm, the color looks strange to me.", emotion: .curious),
        DialogLine(speaker: .colin, sentence: "Good point, we haven't adjusted brightness and saturation yet.", emotion: .sad),
        DialogLine(speaker: .shay, sentence: "Let's keep experimenting!", emotion: .happy)
    ]}
    
    
    
    // MARK: - Private Node Properties
    
    private var backgroundNode: BackgroundNode!
    private var characterMom: CharacterNode!
    private var pictureFrame: SKSpriteNode!
    
    
    
    // MARK: - Lifecyle Methods
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupBackgroundNode()
        setupCharacterColin()
        setupCharacterMom()
        setupCharacterShay()
        setupPictureFrame()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        backgroundNode.updateBrightness()
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setupBackgroundNode() {
        let background = Asset.propCityDay.image
        let carSmoke = Asset.propSmokeDay.image
        let cars = Asset.propCarsDay.image
        let grass = Asset.propGrassDay.image
        let sun = Asset.propSun.image
        backgroundNode = BackgroundNode(background: background, carSmoke: carSmoke, cars: cars, celestialBody: sun, grass: grass, size: size)
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        insertChild(backgroundNode, at: 0)
    }
    
    private func setupCharacterColin() {
        characterColin = CharacterNode(color: colorColin)
        characterColin?.position = CGPoint(x: 340, y: 200)
        characterColin?.setEmotion(to: Asset.emotionFunny.rawValue)
        guard let characterColin else { return }
        addChild(characterColin)
    }
    
    private func setupCharacterMom() {
        let color = HSB(hue: colorColin.hue, saturation: 1, brightness: 1).adding(to: HSB(hue: colorShay.hue, saturation: 1, brightness: 1))
        characterMom = CharacterNode(color: color, radius: 60)
        characterMom?.alpha = 0
        characterMom?.physicsBody = nil
        characterMom?.position = CGPoint(x: frame.midX, y: 260)
        guard let characterMom else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.addChild(characterMom)
            self?.characterMom.run(SKAction.fadeIn(withDuration: 1))
        }
    }
    
    private func setupCharacterShay() {
        characterShay = CharacterNode(color: colorShay)
        characterShay?.position = CGPoint(x: characterColin!.position.x + 200, y: 200)
        characterShay?.setEmotion(to: Asset.emotionFunny.rawValue)
        guard let characterShay else { return }
        addChild(characterShay)
    }
    
    private func setupPictureFrame() {
        let texture = SKTexture(image: Asset.propPictureFrameDay.image)
        pictureFrame = SKSpriteNode(texture: texture)
        pictureFrame.size = CGSize(width: 500, height: 500)
        pictureFrame.position = CGPoint(x: frame.midX, y: 260)
        addChild(pictureFrame)
    }
    
}
