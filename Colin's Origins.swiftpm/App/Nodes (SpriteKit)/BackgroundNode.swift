import SpriteKit

final class BackgroundNode: SKSpriteNode {
    
    
    
    // MARK: - Private Properties
    
    private let background: UIImage
    private let carSmoke: UIImage?
    private let cars: UIImage?
    private let celestialBody: UIImage
    private let grass: UIImage
    
    private var isUpdatingBrightness = false
    
    
    
    // MARK: - Private Node Properties
    
    private(set) var backgroundNode: SKSpriteNode!
    private(set) var backgroundCarSmoke1: SKSpriteNode!
    private(set) var backgroundCarSmoke2: SKSpriteNode!
    private(set) var backgroundCars1: SKSpriteNode!
    private(set) var backgroundCars2: SKSpriteNode!
    private(set) var backgroundCloud1: SKSpriteNode!
    private(set) var backgroundCloud2: SKSpriteNode!
    private(set) var backgroundCloud3: SKSpriteNode!
    private(set) var backgroundGrass: SKSpriteNode!
    private(set) var backgroundBody: SKSpriteNode!
    
    
    
    // MARK: - Initialization
    
    init(background: UIImage, carSmoke: UIImage? = nil, cars: UIImage? = nil, celestialBody: UIImage, grass: UIImage, size: CGSize) {
        self.background = background
        self.cars = cars
        self.celestialBody = celestialBody
        self.grass = grass
        self.carSmoke = carSmoke
        super.init(texture: nil, color: .white, size: size)
        setupBackground()
        setupBackgroundBody()
        setupBackgroungCarSmoke()
        setupBackgroundCars()
        setupBackgroundClouds()
        setupBackgroundGrass()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Methods
    
    func updateBrightness() {
        if backgroundBody.intersects(backgroundCloud1) || backgroundBody.intersects(backgroundCloud2) || backgroundBody.intersects(backgroundCloud3) {
            guard !isUpdatingBrightness else { return }
            let action = SKAction.colorize(withColorBlendFactor: 0.1, duration: 0.5)
            isUpdatingBrightness = true
            backgroundNode.run(action)
        } else {
            guard isUpdatingBrightness else { return }
            let action = SKAction.colorize(withColorBlendFactor: 0, duration: 0.5)
            isUpdatingBrightness = false
            backgroundNode.run(action)
        }
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setupBackground() {
        let texture = SKTexture(image: background)
        backgroundNode = SKSpriteNode(texture: texture)
        backgroundNode.color = .black
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundNode.aspectFill(size: size)
        insertChild(backgroundNode, at: 0)
    }
    
    private func setupBackgroundBody() {
        let sequence = SKAction.repeatForever(SKAction.sequence([
            SKAction.scale(by: 0.85, duration: 12),
            SKAction.scale(by: 1/0.85, duration: 12)
        ]))
        let texture = SKTexture(image: celestialBody)
        backgroundBody = SKSpriteNode(texture: texture)
        backgroundBody.position = CGPoint(x: frame.minX + 200, y: frame.maxY - 200)
        backgroundBody.aspectFill(size: CGSize(width: 200, height: 200))
        backgroundBody.run(sequence)
        insertChild(backgroundBody, at: 1)
    }
    
    private func setupBackgroungCarSmoke() {
        guard let carSmoke else { return }
        let sequence = SKAction.repeatForever(SKAction.sequence([
            SKAction.group([
                SKAction.move(by: CGVector(dx: frame.width, dy: 0), duration: 12),
                SKAction.sequence([
                    SKAction.fadeOut(withDuration: 3),
                    SKAction.fadeIn(withDuration: 3),
                    SKAction.fadeOut(withDuration: 3),
                    SKAction.fadeIn(withDuration: 3)
                ])
            ]),
            SKAction.move(by: CGVector(dx: -frame.width, dy: 0), duration: 0)
        ]))
        let texture = SKTexture(image: carSmoke)
        backgroundCarSmoke1 = SKSpriteNode(texture: texture)
        backgroundCarSmoke2 = SKSpriteNode(texture: texture)
        backgroundCarSmoke1.position = CGPoint(x: frame.midX, y: frame.minY + 240)
        backgroundCarSmoke2.position = CGPoint(x: frame.midX - frame.width, y: frame.minY + 240)
        backgroundCarSmoke1.aspectFill(size: CGSize(width: frame.width, height: 100))
        backgroundCarSmoke2.aspectFill(size: CGSize(width: frame.width, height: 100))
        backgroundCarSmoke1.run(sequence)
        backgroundCarSmoke2.run(sequence)
        addChild(backgroundCarSmoke1)
        addChild(backgroundCarSmoke2)
    }
    
    private func setupBackgroundCars() {
        guard let cars else { return }
        let sequence = SKAction.repeatForever(SKAction.sequence([
            SKAction.move(by: CGVector(dx: frame.width, dy: 0), duration: 12),
            SKAction.move(by: CGVector(dx: -frame.width, dy: 0), duration: 0)
        ]))
        let texture = SKTexture(image: cars)
        backgroundCars1 = SKSpriteNode(texture: texture)
        backgroundCars2 = SKSpriteNode(texture: texture)
        backgroundCars1.position = CGPoint(x: frame.midX, y: frame.minY + 240)
        backgroundCars2.position = CGPoint(x: frame.midX - frame.width, y: frame.minY + 240)
        backgroundCars1.aspectFill(size: CGSize(width: frame.width, height: 100))
        backgroundCars2.aspectFill(size: CGSize(width: frame.width, height: 100))
        backgroundCars1.run(sequence)
        backgroundCars2.run(sequence)
        addChild(backgroundCars1)
        addChild(backgroundCars2)
    }
    
    private func setupBackgroundClouds() {
        let sequence = SKAction.repeatForever(SKAction.sequence([
            SKAction.move(by: CGVector(dx: frame.width, dy: 0), duration: 24),
            SKAction.move(by: CGVector(dx: -frame.width * 2, dy: 0), duration: 0),
            SKAction.move(by: CGVector(dx: frame.width, dy: 0), duration: 24)
        ]))
        let texture1 = SKTexture(image: Asset.propCloud1.image)
        let texture2 = SKTexture(image: Asset.propCloud2.image)
        let texture3 = SKTexture(image: Asset.propCloud3.image)
        backgroundCloud1 = SKSpriteNode(texture: texture1)
        backgroundCloud2 = SKSpriteNode(texture: texture2)
        backgroundCloud3 = SKSpriteNode(texture: texture3)
        backgroundCloud1.position = CGPoint(x: frame.minX + 600, y: frame.maxY - 100)
        backgroundCloud2.position = CGPoint(x: frame.minX + 1000, y: frame.maxY - 200)
        backgroundCloud3.position = CGPoint(x: frame.minX + 1400, y: frame.maxY - 150)
        for cloud in [backgroundCloud1, backgroundCloud2, backgroundCloud3] as [SKSpriteNode] {
            cloud.aspectFill(size: CGSize(width: 250, height: 120))
            cloud.run(sequence)
            addChild(cloud)
        }
    }
    
    private func setupBackgroundGrass() {
        let sequence = SKAction.repeatForever(SKAction.sequence([
            SKAction.move(by: CGVector(dx: 10, dy: 0), duration: 3),
            SKAction.move(by: CGVector(dx: -10, dy: 0), duration: 3)
        ]))
        let texture = SKTexture(image: grass)
        backgroundGrass = SKSpriteNode(texture: texture)
        backgroundGrass.position = CGPoint(x: frame.midX, y: frame.minY + 200)
        backgroundGrass.aspectFill(size: CGSize(width: frame.width, height: 150))
        backgroundGrass.run(sequence)
        addChild(backgroundGrass)
    }
    
}
