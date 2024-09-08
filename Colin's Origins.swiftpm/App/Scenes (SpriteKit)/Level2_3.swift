import SpriteKit

final class Level2_3Scene: Level {
    
    
    
    // MARK: - Level Properties
    
    override var destination: SKScene? { Level3_1Scene(controller: controller, color1: colorColin, color2: colorShay, size: size) }
    override var title: String { "Level 2.3 : DARK-ANSAS CITY" }
    
    override var dialog: [DialogLine] {[
        DialogLine(speaker: .shay, sentence: "The color is closer to mom's, but not quite right.", emotion: .sad),
        DialogLine(speaker: .colin, sentence: "True, we still need to adjust the saturation.", emotion: .curious)
    ]}
    
    
    
    // MARK: - Private Node Properties
    
    private var backgroundNode: BackgroundNode!
    private var backgroundWindows: SKSpriteNode!
    private var characterMom: CharacterNode!
    private var pictureFrame: SKSpriteNode!
    
    
    
    // MARK: - Lifecyle Methods
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupBackgroundNode()
        setupBackgroungWindows()
        setupCharacterColin()
        setupCharacterMom()
        setupCharacterShay()
        setupPictureFrame()
        setupTitle()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        backgroundNode.updateBrightness()
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
        characterColin?.position = CGPoint(x: 340, y: 200)
        characterColin?.setEmotion(to: Asset.emotionFunny.rawValue)
        guard let characterColin else { return }
        addChild(characterColin)
    }
    
    private func setupCharacterMom() {
        let color1 = HSB(hue: colorColin.hue, saturation: 1, brightness: colorColin.brightness)
        let color2 = HSB(hue: colorShay.hue, saturation: 1, brightness: colorShay.brightness)
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
        let texture = SKTexture(image: Asset.propPictureFrameNight.image)
        pictureFrame = SKSpriteNode(texture: texture)
        pictureFrame.size = CGSize(width: 500, height: 500)
        pictureFrame.position = CGPoint(x: frame.midX, y: 260)
        addChild(pictureFrame)
    }
    
    private func setupTitle() {
        titleNode.fontColor = .white
    }
    
}
