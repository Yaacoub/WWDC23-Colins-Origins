import SpriteKit

final class Level4_1Scene: Level {
    
    
    
    // MARK: Level Properties
    
    override var canSkip: Bool { false }
    override var destination: SKScene? { Level4_2Scene(controller: controller, color1: colorColin, color2: colorShay, size: size) }
    override var title: String { "Level 4.1 : THE FIELD" }
    
    override var dialog: [DialogLine] {[
        DialogLine(speaker: .colin, sentence: "Okay, we've found three candidates. Let's see if we recognize our mom!", emotion: .happy),
        DialogLine(speaker: .shay, sentence: "Let's tap on mom to let her know that we found her!", emotion: .happy)
    ]}
    
    
    
    // MARK: - Private Node Properties
    
    private var backgroundNode: BackgroundNode!
    private var character1: CharacterNode!
    private var character2: CharacterNode!
    private var character3: CharacterNode!
    private var characterMom: CharacterNode!
    private var pictureFrame: SKSpriteNode!
    
    
    
    // MARK: - Lifecyle Methods
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupBackgroundNode()
        setupCharacter()
        setupCharacterMom()
        setupPictureFrame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch in touches {
            let location = touch.location(in: self)
            if character1.contains(location) {
                AudioManager.playOnce(.sfxIncorrect)
            } else if character2.contains(location) {
                AudioManager.playOnce(.sfxIncorrect)
            } else if character3.contains(location) {
                AudioManager.playOnce(.sfxCorrect)
                advanceLevel()
            }
        }
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
    
    private func setupCharacter() {
        let color = colorColin.adding(to: colorShay)
        character1 = CharacterNode(color: HSB(hue: color.hue, saturation: 1, brightness: color.brightness))
        character2 = CharacterNode(color: HSB(hue: color.hue, saturation: color.saturation, brightness: color.brightness > 0.8 ? 0.5 : 1))
        character3 = CharacterNode(color: HSB(hue: color.hue, saturation: color.saturation, brightness: color.brightness))
        character1.position = CGPoint(x: frame.maxX / 4 * 1, y: frame.maxY)
        character2.position = CGPoint(x: frame.maxX / 4 * 2, y: frame.maxY)
        character3.position = CGPoint(x: frame.maxX / 4 * 3, y: frame.maxY)
        addChild(character1)
        addChild(character2)
        addChild(character3)
    }
    
    private func setupCharacterMom() {
        let color1 = HSB(hue: colorColin.hue, saturation: colorColin.saturation, brightness: colorColin.brightness)
        let color2 = HSB(hue: colorShay.hue, saturation: colorShay.saturation, brightness: colorShay.brightness)
        characterMom = CharacterNode(color: color1.adding(to: color2), radius: 60)
        characterMom?.alpha = 0
        characterMom?.physicsBody = nil
        characterMom?.position = CGPoint(x: frame.midX, y: frame.maxY - 260)
        guard let characterMom else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.addChild(characterMom)
            self?.characterMom.run(SKAction.fadeIn(withDuration: 1))
        }
    }
    
    private func setupPictureFrame() {
        let texture = SKTexture(image: Asset.propPictureFrameDusk.image)
        pictureFrame = SKSpriteNode(texture: texture)
        pictureFrame.size = CGSize(width: 500, height: 500)
        pictureFrame.position = CGPoint(x: frame.midX, y: frame.maxY - 260)
        addChild(pictureFrame)
    }
    
}
