import SpriteKit
import SwiftUI

final class Level1_1Scene: Level {
    
    
    
    // MARK: - Level Properties
    
    override var destination: SKScene? { Level1_2Scene(controller: controller, color1: colorColin, color2: colorShay, size: size) }
    override var title: String { "Level 1.1 : THE CITY" }
    
    override var dialog: [DialogLine] {[
        DialogLine(speaker: .colin, sentence: "Shay, do you know what hue is?", emotion: .curious),
        DialogLine(speaker: .shay, sentence: "Hue? Is that like a color?", emotion: .curious),
        DialogLine(speaker: .colin, sentence: "Well, color is made up of three things: hue, brightness, and saturation.", emotion: .happy),
        DialogLine(speaker: .shay, sentence: "Woah, that sounds complicated.", emotion: .sad),
        DialogLine(speaker: .colin, sentence: "Basically, hue is the simplest form of color, like red or green.", emotion: .funny),
        DialogLine(speaker: .shay, sentence: "So, to find the right mix, we need to get the hue, brightness, and saturation.", emotion: .happy),
        DialogLine(speaker: .colin, sentence: "That's right! Let's experiment with hue to figure out the blend of colors.", emotion: .happy)
    ]}
    
    override var learnMore: [MarkdownSection] {[
        MarkdownSection(title: "Color models", body: """
Color models are systems that use numbers to describe colors mathematically. Some popular color models include:

- RYB (Red, Yellow, Blue), used in art and design.
- RGB (Red, Green, Blue), used in light-transmitting media like screens.
- CMYK (Cyan, Magenta, Yellow, Black), used in printing.
""", image: .learnMoreModels),
        MarkdownSection(title: "HSB", body: """
HSB (Hue, Saturation, Brightness) or HSV (Hue, Saturation, Value) is a color model that makes color mixing more intuitive for inexperienced users or those familiar with traditional art. It establishes easily understandable relationships between its three properties.
""", image: .learnMoreHSB),
        MarkdownSection(title: "Hue", body: """
In painting, hue is the purest pigment that doesn't contain white or black. In the digital world, it is the brightest and most intense representation of color, disregarding saturation and brightness.
""", image: .learnMoreHue)
    ]}
    
    
    
    // MARK: - Private Node Properties
    
    private var backgroundNode: BackgroundNode!
    
    
    
    // MARK: - Lifecyle Methods
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupBackgroundNode()
        setupCharacterColin()
        setupCharacterShay()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        backgroundNode.updateBrightness()
    }
    
    
    
    // MARK: - Level Methods
    
    override func advanceLevel() {
        characterColin?.physicsBody?.applyAngularImpulse(-40)
        characterShay?.physicsBody?.applyAngularImpulse(-40)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            super.advanceLevel()
        }
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setupBackgroundNode() {
        let background = Asset.propCityDay.image
        let carSmoke = Asset.propSmokeDay.image
        let cars = Asset.propCarsDay.image
        let grass = Asset.propGrassDay.image
        let sun = Asset.propSun.image
        backgroundNode = BackgroundNode(background: background, carSmoke: carSmoke, cars: cars, celestialBody: sun, grass: grass, size: size)
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        insertChild(backgroundNode, at: 0)
    }
    
    private func setupCharacterColin() {
        characterColin = CharacterNode(color: colorColin)
        characterColin?.position = CGPoint(x: frame.midX - 200, y: frame.midY)
        guard let characterColin else { return }
        addChild(characterColin)
    }
    
    private func setupCharacterShay() {
        characterShay = CharacterNode(color: colorShay)
        characterShay?.position = CGPoint(x: frame.midX + 200, y: frame.midY)
        guard let characterShay else { return }
        addChild(characterShay)
    }
    
}
