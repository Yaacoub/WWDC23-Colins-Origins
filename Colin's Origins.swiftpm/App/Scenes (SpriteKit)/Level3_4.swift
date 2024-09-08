import SpriteKit

final class Level3_4Scene: Level {
    
    
    
    // MARK: - Level Properties
    
    override var destination: SKScene? { Level4_1Scene(controller: controller, color1: colorColin, color2: colorShay, size: size) }
    override var title: String { "Level 3.4 : GRAY-KJAVIK" }
    
    override var dialog: [DialogLine] {[
        DialogLine(speaker: .colin, sentence: "I think we've found the right color!", emotion: .happy),
        DialogLine(speaker: .shay, sentence: "Looks like it! Now let's find candidates with the matching color.", emotion: .happy),
        DialogLine(speaker: .colin, sentence: "That's the easy part!", emotion: .funny)
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
        let background = Asset.propCityDusk.image
        let carSmoke = Asset.propSmokeDusk.image
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
        characterColin?.position = CGPoint(x: 340, y: 200)
        characterColin?.setEmotion(to: Asset.emotionFunny.rawValue)
        guard let characterColin else { return }
        addChild(characterColin)
    }
    
    private func setupCharacterMom() {
        let color1 = HSB(hue: colorColin.hue, saturation: colorColin.saturation, brightness: colorColin.brightness)
        let color2 = HSB(hue: colorShay.hue, saturation: colorShay.saturation, brightness: colorShay.brightness)
        characterMom = CharacterNode(color: color1.adding(to: color2), radius: 60)
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
        let texture = SKTexture(image: Asset.propPictureFrameDusk.image)
        pictureFrame = SKSpriteNode(texture: texture)
        pictureFrame.size = CGSize(width: 500, height: 500)
        pictureFrame.position = CGPoint(x: frame.midX, y: 260)
        addChild(pictureFrame)
    }
    
}
