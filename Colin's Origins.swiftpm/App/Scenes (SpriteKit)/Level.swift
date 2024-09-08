import SpriteKit
import SwiftUI

class Level: SKScene {
    
    
    
    // MARK: - Properties
    
    let colorColin: HSB
    let colorShay: HSB
    
    weak var controller: UIViewController?
    private(set) var canSkip: Bool = true
    private(set) var destination: SKScene?
    private(set) var dialog: [DialogLine] = []
    private(set) var learnMore: [MarkdownSection] = []
    private(set) var title: String = ""
    
    
    
    // MARK: - Node Properties
    
    var characterColin: CharacterNode?
    var characterShay: CharacterNode?
    
    private(set) var buttonExit: SKSpriteNode!
    private(set) var buttonLearnMore: SKSpriteNode!
    private(set) var buttonSkip: SKSpriteNode!
    private(set) var textBubble: TextBubbleNode!
    private(set) var titleNode: SKLabelNode!
    
    
    
    // MARK: - Private Properties
    
    private var dialogIndex: Int = 0
    private var isSkipping = false
    
    
    
    // MARK: - Initialization
    
    init(controller: UIViewController?, color1: HSB, color2: HSB, size: CGSize?) {
        self.controller = controller
        self.colorColin = color1
        self.colorShay = color2
        super.init(size: size ?? .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Lifecyle Methods
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupButtonExit()
        setupButtonLearnMore()
        setupButtonSkip()
        setupScene()
        setupTextBubble()
        setupTitle()
        updateDialog()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch in touches {
            let location = touch.location(in: self)
            if buttonExit.contains(location) {
                AudioManager.playOnce(.sfxExit)
                controller?.navigationController?.popViewController(animated: true)
            } else if buttonLearnMore.contains(location) && !learnMore.isEmpty {
                let viewController = UIHostingController(rootView: LearnMore(sections: learnMore))
                AudioManager.playOnce(.sfxButtonTap)
                controller?.present(viewController, animated: true)
            } else if buttonSkip.contains(location) && canSkip {
                AudioManager.playOnce(.sfxButtonTap)
                advanceLevel(forcefully: true)
            } else if textBubble.contains(location) && textBubble.text.contains(">") {
                advanceLevel(forcefully: false)
                updateDialog()
            }
        }
    }
    
    
    
    // MARK: - Methods
    
    func advanceLevel() {
        guard let view, let destination else {
            isSkipping = false
            return
        }
        view.presentScene(destination)
    }
    
    
    
    // MARK: - Private Methods
    
    private func advanceLevel(forcefully: Bool) {
        guard (dialogIndex >= dialog.count || forcefully) && !isSkipping && canSkip else { return }
        isSkipping = true
        advanceLevel()
    }
    
    private func updateDialog() {
        guard dialogIndex < dialog.count else { return }
        var character: CharacterNode?
        let anchorPoint = textBubble.scene?.anchorPoint
        let line = dialog[dialogIndex]
        let position = textBubble.position
        let text = "\(line.speaker.rawValue.uppercased()):\n\(line.sentence) >"
        dialogIndex += 1
        textBubble.removeFromParent()
        textBubble = TextBubbleNode(text: text, maxWidth: frame.width)
        textBubble.scene?.anchorPoint = anchorPoint ?? CGPoint(x: 0.5, y: 0.5)
        textBubble.position = position
        switch line.speaker {
        case .colin: character = characterColin
        case .shay: character = characterShay
        }
        character?.setEmotion(to: line.emotion.rawValue)
        addChild(textBubble)
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setupButtonExit() {
        let texture = SKTexture(image: Asset.buttonExit.image)
        buttonExit = SKSpriteNode(texture: texture, size: CGSize(width: 50, height: 50))
        buttonExit.anchorPoint = CGPoint(x: 0, y: 1)
        buttonExit.position = CGPoint(x: 20, y: frame.maxY - 20)
        buttonExit.zPosition = 1000
        addChild(buttonExit)
    }
    
    private func setupButtonLearnMore() {
        let texture = SKTexture(image: Asset.buttonLearnMore.image)
        buttonLearnMore = SKSpriteNode(texture: texture, size: CGSize(width: 200, height: 50))
        buttonLearnMore.anchorPoint = CGPoint(x: 1, y: 1)
        buttonLearnMore.position = CGPoint(x: frame.maxX - 90, y: frame.maxY - 20)
        buttonLearnMore.zPosition = 1000
        guard !learnMore.isEmpty else { return }
        addChild(buttonLearnMore)
    }
    
    private func setupButtonSkip() {
        let texture = SKTexture(image: Asset.buttonSkip.image)
        buttonSkip = SKSpriteNode(texture: texture, size: CGSize(width: 50, height: 50))
        buttonSkip.anchorPoint = CGPoint(x: 1, y: 1)
        buttonSkip.position = CGPoint(x: frame.maxX - 20, y: frame.maxY - 20)
        buttonSkip.zPosition = 1000
        guard canSkip else { return }
        addChild(buttonSkip)
    }
    
    private func setupScene() {
        backgroundColor = .black
        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: -frame.maxX, y: 40, width: frame.width * 3, height: frame.height * 2))
        scaleMode = .aspectFit
    }
    
    private func setupTextBubble() {
        textBubble = TextBubbleNode(text: "", maxWidth: frame.width)
        textBubble.position = CGPoint(x: frame.midX, y: frame.midY)
        textBubble.zPosition = 1000
        addChild(textBubble)
    }
    
    private func setupTitle() {
        let action = SKAction.fadeOut(withDuration: 6)
        titleNode = SKLabelNode(fontNamed: "16x8Pxl_Mono")
        titleNode.numberOfLines = 0
        titleNode.fontColor = .black
        titleNode.fontSize = 60
        titleNode.position = CGPoint(x: frame.midX, y: frame.maxY - 280)
        titleNode.text = title
        titleNode.zPosition = 1000
        titleNode.run(action)
        addChild(titleNode)
    }
    
}
