import SpriteKit

final class GameViewController: UIViewController {
    
    
    
    // MARK: - Lifecyle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setupView() {
        let hue1 = CGFloat.random(in: 0...1)
        let hue2 = (hue1 + CGFloat.random(in: 0.20...0.30)).truncatingRemainder(dividingBy: 1)
        let color1 = HSB(hue: hue1, saturation: .random(in: 0.3...0.7), brightness: .random(in: 0.3...0.7))
        let color2 = HSB(hue: hue2, saturation: .random(in: 0.3...0.7), brightness: .random(in: 0.3...0.7))
        let scene = Level0Scene(controller: self, color1: color1, color2: color2, size: CGSize(width: 1872, height: 1170))
        view = SKView(frame: view.bounds)
        (view as! SKView).presentScene(scene)
    }
    
}
