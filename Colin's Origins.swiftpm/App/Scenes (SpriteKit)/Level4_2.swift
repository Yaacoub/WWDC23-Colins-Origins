import SpriteKit

final class Level4_2Scene: Level {
    
    
    
    // MARK: Level Properties
    
    override var title: String { "Level 4.2 : THE END" }
    
    override var dialog: [DialogLine] {[
        DialogLine(speaker: .shay, sentence: "We did it! We found mom!", emotion: .happy),
        DialogLine(speaker: .colin, sentence: "We really missed you, mom!", emotion: .happy),
        DialogLine(speaker: .shay, sentence: "Time for a well-deserved rest now.", emotion: .funny)
    ]}
    
    
    
    // MARK: - Private Node Properties
    
    private var backgroundNode: BackgroundNode!
    private var characterMom: CharacterNode!
    
    
    
    // MARK: - Lifecyle Methods
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupBackgroundNode()
        setupCharacterColin()
        setupCharacterMom()
        setupCharacterShay()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        backgroundNode.updateBrightness()
    }
    
    
    
    // MARK: - Level Methods
    
    override func advanceLevel() {
        AudioManager.playOnce(.sfxSuccess)
        controller?.navigationController?.popViewController(animated: true)
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
        characterColin?.position = CGPoint(x: frame.maxX / 4 * 1, y: frame.maxY * 2)
        guard let characterColin else { return }
        addChild(characterColin)
    }
    
    private func setupCharacterMom() {
        characterMom = CharacterNode(color: colorColin.adding(to: colorShay))
        characterMom.position = CGPoint(x: frame.maxX / 4 * 2, y: frame.midY)
        addChild(characterMom)
    }
    
    private func setupCharacterShay() {
        characterShay = CharacterNode(color: colorShay)
        characterShay?.position = CGPoint(x: frame.maxX / 4 * 3, y: frame.maxY * 2)
        guard let characterShay else { return }
        addChild(characterShay)
    }
    
}
