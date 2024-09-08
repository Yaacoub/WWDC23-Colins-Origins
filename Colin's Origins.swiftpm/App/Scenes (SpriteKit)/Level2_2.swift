import SpriteKit

final class Level2_2Scene: Level {
    
    
    
    // MARK: - Level Properties
    
    override var canSkip: Bool { false }
    override var destination: SKScene? { Level2_3Scene(controller: controller, color1: colorColin, color2: colorShay, size: size) }
    override var title: String { "Level 2.2 : THE MUSEUM" }
    
    override var dialog: [DialogLine] {[
        DialogLine(speaker: .colin, sentence: "Let's move the sliders all the way to the left to get the brightness.", emotion: .happy),
    ]}
    
    
    
    // MARK: - Private Properties
    
    private var lastMoved: SKShapeNode?
    
    
    
    // MARK: - Private Node Properties
    
    private var circleLeft: SKShapeNode!
    private var circleRight: SKShapeNode!
    private var slider1: UISlider!
    private var slider2: UISlider!
    
    
    
    // MARK: - Lifecyle Methods
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupCharacterColin()
        setupCharacterShay()
        setupCircle()
        setupSlider()
        setupTextBubble()
        setupTitle()
    }
    
    
    
    // MARK: - Private Methods
    
    @objc private func adjustCircleLeftAlpha(_ slider: UISlider) {
        circleLeft.alpha = CGFloat(slider.value)
        checkSlider()
    }
    
    @objc private func adjustCircleRightAlpha(_ slider: UISlider) {
        circleRight.alpha = CGFloat(slider.value)
        checkSlider()
    }
    
    private func checkSlider() {
        guard slider1.value == Float(slider1.minimumValue), slider2.value == Float(slider2.minimumValue) else { return }
        AudioManager.playOnce(.sfxCorrect)
        slider1.removeFromSuperview()
        slider2.removeFromSuperview()
        textBubble.removeFromParent()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.advanceLevel()
        }
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setupCharacterColin() {
        characterColin = CharacterNode(color: colorColin)
        characterColin?.position = CGPoint(x: -frame.midX + 200, y: frame.maxY)
        characterColin?.setEmotion(to: Asset.emotionFunny.rawValue)
        guard let characterColin else { return }
        addChild(characterColin)
        characterColin.physicsBody?.applyAngularImpulse(-40)
    }
    
    private func setupCharacterShay() {
        characterShay = CharacterNode(color: colorShay)
        characterShay?.position = CGPoint(x: -frame.midX + 400, y: frame.maxY)
        characterShay?.setEmotion(to: Asset.emotionFunny.rawValue)
        guard let characterShay else { return }
        addChild(characterShay)
        characterShay.physicsBody?.applyAngularImpulse(-40)
    }
    
    private func setupCircle() {
        circleLeft = SKShapeNode(circleOfRadius: 180)
        circleRight = SKShapeNode(circleOfRadius: 180)
        circleLeft.blendMode = .add
        circleLeft.fillColor = UIColor(hue: colorColin.hue, saturation: 1, brightness: 1, alpha: 1)
        circleRight.fillColor = UIColor(hue: colorShay.hue, saturation: 1, brightness: 1, alpha: 1)
        circleLeft.lineWidth = 0
        circleRight.lineWidth = 0
        circleLeft.position = CGPoint(x: frame.midX - 80, y: frame.maxY - 500)
        circleRight.position = CGPoint(x: frame.midX + 80, y: frame.maxY - 500)
        addChild(circleRight)
        addChild(circleLeft)
    }
    
    private func setupSlider() {
        slider1 = UISlider()
        slider2 = UISlider()
        slider1.maximumTrackTintColor = UIColor(hue: colorColin.hue, saturation: 1, brightness: colorColin.brightness, alpha: 1)
        slider1.minimumTrackTintColor = UIColor(hue: colorColin.hue, saturation: 1, brightness: 1, alpha: 1)
        slider2.maximumTrackTintColor = UIColor(hue: colorShay.hue, saturation: 1, brightness: colorShay.brightness, alpha: 1)
        slider2.minimumTrackTintColor = UIColor(hue: colorShay.hue, saturation: 1, brightness: 1, alpha: 1)
        slider1.maximumValue = 1
        slider1.minimumValue = Float(colorColin.brightness)
        slider2.maximumValue = 1
        slider2.minimumValue = Float(colorShay.brightness)
        slider1.addTarget(self, action: #selector(adjustCircleLeftAlpha), for: .valueChanged)
        slider2.addTarget(self, action: #selector(adjustCircleRightAlpha), for: .valueChanged)
        slider1.setValue(1, animated: false)
        slider2.setValue(1, animated: false)
        guard let view else { return }
        slider1.layout(in: view, [
            slider1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20 + 60 * view.frame.height / size.height),
            slider1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            slider1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)

        ])
        slider2.layout(in: view, [
            slider2.topAnchor.constraint(equalTo: view.topAnchor, constant: 20 + 60 * view.frame.height / size.height),
            slider2.leadingAnchor.constraint(greaterThanOrEqualTo: slider1.trailingAnchor, constant: 20),
            slider2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            slider2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)
        ])
    }
    
    private func setupTextBubble() {
        textBubble.position = CGPoint(x: frame.midX, y: 200)
    }
    
    private func setupTitle() {
        titleNode.fontColor = .white
    }
    
}
