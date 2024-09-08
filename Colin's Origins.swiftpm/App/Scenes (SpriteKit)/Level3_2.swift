import SpriteKit

final class Level3_2Scene: Level {
    
    
    
    // MARK: - Level Properties
    
    override var canSkip: Bool { false }
    override var destination: SKScene? { Level3_3Scene(controller: controller, color1: colorColin, color2: colorShay, size: size) }
    override var title: String { "Level 3.2 : THE MUSEUM" }
    
    override var dialog: [DialogLine] {[
        DialogLine(speaker: .colin, sentence: "Let's move the sliders all the way to the left to get the right mix.", emotion: .happy),
    ]}
    
    
    
    // MARK: - Private Properties
    
    private var lastMoved: SKShapeNode?
    
    
    
    // MARK: - Private Node Properties
    
    private var backgroundLeft: SKShapeNode!
    private var backgroundRight: SKShapeNode!
    private var circleLeft: SKShapeNode!
    private var circleRight: SKShapeNode!
    private var slider1: UISlider!
    private var slider2: UISlider!
    
    
    
    // MARK: - Lifecyle Methods
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupBackground()
        setupCharacterColin()
        setupCharacterShay()
        setupCircle()
        setupSlider()
        setupTextBubble()
    }
    
    
    
    // MARK: - Private Methods
    
    @objc private func adjustCircleLeftAlpha(_ slider: UISlider) {
        let a = (colorColin.brightness - 1) / (colorColin.saturation - 1)
        let b = -a + 1
        let brigthness = a * CGFloat(slider.value) + b
        backgroundLeft.fillColor = UIColor(hue: 0, saturation: 0, brightness: brigthness, alpha: 1)
        circleLeft.alpha = CGFloat(slider.value)
        checkSlider()
    }
    
    @objc private func adjustCircleRightAlpha(_ slider: UISlider) {
        let a = (colorShay.brightness - 1) / (colorShay.saturation - 1)
        let b = -a + 1
        let brigthness = a * CGFloat(slider.value) + b
        backgroundRight.fillColor = UIColor(hue: 0, saturation: 0, brightness: brigthness, alpha: 1)
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
    
    private func setupBackground() {
        backgroundLeft = SKShapeNode(rectOf: CGSize(width: frame.width / 2, height: frame.height))
        backgroundRight = SKShapeNode(rectOf: CGSize(width: frame.width / 2, height: frame.height))
        backgroundLeft.fillColor = .white
        backgroundRight.fillColor = .white
        backgroundLeft.lineWidth = 0
        backgroundRight.lineWidth = 0
        backgroundLeft.position = CGPoint(x: frame.maxX / 4, y: frame.midY)
        backgroundRight.position = CGPoint(x: frame.maxX / 4 * 3, y: frame.midY)
        insertChild(backgroundLeft, at: 1)
        insertChild(backgroundRight, at: 1)
    }
    
    private func setupCharacterColin() {
        characterColin = CharacterNode(color: colorColin)
        characterColin?.position = CGPoint(x: -frame.midX + 200, y: frame.maxY * 2)
        characterColin?.setEmotion(to: Asset.emotionFunny.rawValue)
        guard let characterColin else { return }
        addChild(characterColin)
        characterColin.physicsBody?.applyAngularImpulse(-40)
    }
    
    private func setupCharacterShay() {
        characterShay = CharacterNode(color: colorShay)
        characterShay?.position = CGPoint(x: -frame.midX + 400, y: frame.maxY * 2)
        characterShay?.setEmotion(to: Asset.emotionFunny.rawValue)
        guard let characterShay else { return }
        addChild(characterShay)
        characterShay.physicsBody?.applyAngularImpulse(-40)
    }
    
    private func setupCircle() {
        circleLeft = SKShapeNode(circleOfRadius: 180)
        circleRight = SKShapeNode(circleOfRadius: 180)
        circleLeft.fillColor = UIColor(hue: colorColin.hue, saturation: 1, brightness: colorColin.brightness, alpha: 1)
        circleRight.fillColor = UIColor(hue: colorShay.hue, saturation: 1, brightness: colorShay.brightness, alpha: 1)
        circleLeft.lineWidth = 0
        circleRight.lineWidth = 0
        circleLeft.position = CGPoint(x: frame.maxX / 4, y: frame.maxY - 400)
        circleRight.position = CGPoint(x: frame.maxX / 4 * 3, y: frame.maxY - 400)
        addChild(circleRight)
        addChild(circleLeft)
    }
    
    private func setupSlider() {
        slider1 = UISlider()
        slider2 = UISlider()
        slider1.maximumTrackTintColor = UIColor(hue: colorColin.hue, saturation: colorColin.saturation, brightness: colorColin.brightness, alpha: 1)
        slider1.minimumTrackTintColor = UIColor(hue: colorColin.hue, saturation: 1, brightness: 1, alpha: 1)
        slider2.maximumTrackTintColor = UIColor(hue: colorShay.hue, saturation: colorShay.saturation, brightness: colorShay.brightness, alpha: 1)
        slider2.minimumTrackTintColor = UIColor(hue: colorShay.hue, saturation: 1, brightness: 1, alpha: 1)
        slider1.maximumValue = 1
        slider1.minimumValue = Float(colorColin.saturation)
        slider2.maximumValue = 1
        slider2.minimumValue = Float(colorShay.saturation)
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
    
}
