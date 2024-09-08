import SpriteKit

final class CharacterNode: SKShapeNode {
    
    
    
    // MARK: - Properties
    
    let color: HSB
    let radius: CGFloat
    
    
    
    // MARK: - Initialization
    
    init(color: HSB, radius: CGFloat = 180) {
        self.color = color
        self.radius = radius
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Methods
    
    func setEmotion(to assetName: String) {
        let emotion = SKSpriteNode(imageNamed: assetName)
        emotion.size = CGSize(width: radius * 2, height: radius * 2)
        removeAllChildren()
        addChild(emotion)
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setup() {
        path = CGPath(ellipseIn: CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2), transform: nil)
        lineWidth = 0
        fillColor = UIColor(hue: color.hue, saturation: color.saturation, brightness: color.brightness, alpha: 1)
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        physicsBody?.angularVelocity = [CGFloat(-0.2), -0.1, 0.1, 0.2].randomElement()!
        physicsBody?.restitution = 0.5
        setEmotion(to: Asset.emotionHappy.rawValue)
    }
    
}
