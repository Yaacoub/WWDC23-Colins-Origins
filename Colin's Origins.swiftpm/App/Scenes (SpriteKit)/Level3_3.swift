import AVFoundation
import SpriteKit

final class Level3_3Scene: Level {
    
    
    
    // MARK: - Level Properties
    
    override var canSkip: Bool { false }
    override var destination: SKScene? { Level3_4Scene(controller: controller, color1: colorColin, color2: colorShay, size: size) }
    override var title: String { "Level 3.2 : THE MUSEUM" }
    
    override var dialog: [DialogLine] {[
        DialogLine(speaker: .shay, sentence: "And now we put the right circle with my color on the other circle!", emotion: .happy),
    ]}
    
    
    
    // MARK: - Private Properties
    
    private var lastMoved: SKShapeNode?
    
    
    
    // MARK: - Private Node Properties
    
    private var circleLeft: SKShapeNode!
    private var circleRight: SKShapeNode!
    
    
    
    // MARK: - Lifecyle Methods
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupCharacterColin()
        setupCharacterShay()
        setupCircle()
        setupTextBubble()
        setupTitle()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if circleLeft.contains(location), (lastMoved ?? circleLeft) == circleLeft {
            circleLeft.position = location
            lastMoved = circleLeft
        } else if circleRight.contains(location), (lastMoved ?? circleRight) == circleRight {
            circleRight.position = location
            lastMoved = circleRight
        } else {
            lastMoved = nil
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        checkBlend()
    }
    
    
    
    // MARK: - Private Methods
    
    private func checkBlend() {
        guard circleLeft.intersects(circleRight) else { return }
        AudioManager.playOnce(.sfxCorrect)
        textBubble.removeFromParent()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.advanceLevel()
        }
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setupCharacterColin() {
        characterColin = CharacterNode(color: colorColin)
        characterColin?.position = CGPoint(x: frame.maxX + frame.midX - 200, y: frame.maxY)
        characterColin?.setEmotion(to: Asset.emotionFunny.rawValue)
        guard let characterColin else { return }
        addChild(characterColin)
        characterColin.physicsBody?.applyAngularImpulse(40)
    }
    
    private func setupCharacterShay() {
        characterShay = CharacterNode(color: colorShay)
        characterShay?.position = CGPoint(x: frame.maxX + frame.midX - 400, y: frame.maxY)
        characterShay?.setEmotion(to: Asset.emotionFunny.rawValue)
        guard let characterShay else { return }
        addChild(characterShay)
        characterShay.physicsBody?.applyAngularImpulse(40)
    }
    
    private func setupCircle() {
        circleLeft = SKShapeNode(circleOfRadius: 180)
        circleRight = SKShapeNode(circleOfRadius: 180)
        circleLeft.blendMode = .add
        circleLeft.fillColor = UIColor(hue: colorColin.hue, saturation: colorColin.saturation, brightness: colorColin.brightness, alpha: 1)
        circleRight.fillColor = UIColor(hue: colorShay.hue, saturation: colorShay.saturation, brightness: colorShay.brightness, alpha: 1)
        circleLeft.lineWidth = 0
        circleRight.lineWidth = 0
        circleLeft.position = CGPoint(x: frame.maxX / 4, y: frame.maxY - 400)
        circleRight.position = CGPoint(x: frame.maxX / 4 * 3, y: frame.maxY - 400)
        addChild(circleRight)
        addChild(circleLeft)
    }
    
    private func setupTextBubble() {
        textBubble.position = CGPoint(x: frame.midX, y: 200)
    }
    
    private func setupTitle() {
        titleNode.fontColor = .white
    }
    
}
