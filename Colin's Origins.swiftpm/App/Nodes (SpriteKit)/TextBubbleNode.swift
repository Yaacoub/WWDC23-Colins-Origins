import SpriteKit

final class TextBubbleNode: SKNode {
    
    
    
    // MARK: - Properties
    
    let maxWidth: CGFloat
    let text: String
    
    
    
    // MARK: - Private Properties
    
    private let borderColor: SKColor = .black
    private let borderWidth: CGFloat = 4
    private let bubbleColor: SKColor = .white
    private let cornerRadius: CGFloat = 8
    private let fontName: String = "16x8Pxl_Mono"
    private let fontSize: CGFloat = 40
    private let textMargin: CGFloat = 20
    
    private var bubbleWidth: CGFloat { maxWidth * 0.55 + 2 * textMargin }
    private var timer: Timer?
    
    
    
    // MARK: - Private Node Properties
    
    private var labelText: SKLabelNode!
    private var shapeBubble: SKShapeNode!
    
    
    
    // MARK: - Initialization
    
    init(text: String, maxWidth: CGFloat) {
        self.maxWidth = maxWidth
        self.text = text
        super.init()
        setupLabelText()
        setupNode()
        setupShapeBubble()
        animateText()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Lifecycle Methods
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        skipAnimation()
    }
    
    
    
    // MARK: - Private Methods
    
    private func animateText() {
        var index = 0
        labelText.text = ""
        labelText.fontColor = .black
        isUserInteractionEnabled = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
            guard let self, index < self.text.count else {
                self?.skipAnimation()
                return
            }
            let character = String(self.text[self.text.index(self.text.startIndex, offsetBy: index)])
            self.labelText.text?.append(character)
            index += 1
        }
    }
    
    private func skipAnimation() {
        isUserInteractionEnabled = false
        labelText.text = text
        labelText.fontColor = .black
        timer?.invalidate()
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setupLabelText() {
        labelText = SKLabelNode(fontNamed: fontName)
        labelText.text = text
        labelText.fontColor = .black.withAlphaComponent(0)
        labelText.fontSize = fontSize
        labelText.horizontalAlignmentMode = .left
        labelText.verticalAlignmentMode = .top
        labelText.numberOfLines = 0
        labelText.lineBreakMode = .byWordWrapping
        labelText.preferredMaxLayoutWidth = bubbleWidth - 2 * textMargin
        labelText.position = CGPoint(x: -bubbleWidth / 2 + textMargin, y: labelText.frame.height / 2)
    }
    
    private func setupNode() {
        isUserInteractionEnabled = true
    }
    
    private func setupShapeBubble() {
        let textSize = labelText.frame.size
        let bubbleSize = CGSize(width: bubbleWidth, height: textSize.height + 2 * textMargin)
        shapeBubble = SKShapeNode(rectOf: bubbleSize, cornerRadius: cornerRadius)
        shapeBubble.fillColor = bubbleColor
        shapeBubble.lineWidth = borderWidth
        shapeBubble.strokeColor = borderColor
        shapeBubble.addChild(labelText)
        addChild(shapeBubble)
    }
    
}
