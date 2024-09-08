import UIKit

final class HomeViewController: UIViewController, UINavigationControllerDelegate {
    
    
    
    // MARK: - Private Properties
    
    private let rainbowColors = [UIColor.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue, .systemIndigo, .systemPurple]
    
    
    
    // MARK: - Private View Properties
    
    private let buttonFreePlay = UIButton()
    private let buttonStoryMode = UIButton()
    private let imageViewBackground1 = UIImageView(image: Asset.propDirtAndSky.image)
    private let imageViewBackground2 = UIImageView(image: Asset.propGrassFullscreen.image)
    private let imageViewBackground3 = UIImageView(image: Asset.propSunFullscreen.image)
    private let imageViewBackground4 = UIImageView(image: Asset.propCloudsFullscreen.image)
    private let labelTitle = UILabel()
    private let stackView = UIStackView()
    
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerFonts()
        setupImageViewBackground()
        setupButtonFreePlay()
        setupButtonStoryMode()
        setupStackView()
        setupLabelTitle()
        setupView()
    }
    
    
    
    // MARK: - UINavigationControllerDelegate Methods
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return TransitionFade(duration: 1)
        }
    
    
    
    // MARK: - Private Methods
    
    @objc private func animationButtonEnd(_ sender: UIButton) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
    }
    
    @objc private func animationButtonStart(_ sender: UIButton) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    private func registerFonts() {
        let fonts = [URL(fileURLWithPath: "Before the Rainbow.otf"), URL(fileURLWithPath: "16x8PXL.ttf")]
        for font in fonts {
            guard let url = Bundle.main.url(forResource: font.deletingPathExtension().lastPathComponent, withExtension: font.pathExtension),
                  let data = try? Data(contentsOf: url) as CFData,
                  let provider = CGDataProvider(data: data),
                  let cgfont = CGFont(provider) else { continue }
            CTFontManagerRegisterGraphicsFont(cgfont, nil)
        }
    }
    
    @objc private func startGame(_ sender: UIButton) {
        let viewController = GameViewController()
        AudioManager.playOnce(.sfxButtonTap)
        animationButtonEnd(sender)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setupImageViewBackground() {
        let imageViews = [imageViewBackground4, imageViewBackground3, imageViewBackground2, imageViewBackground1]
        for imageView in imageViews {
            imageView.contentMode = .scaleAspectFill
            imageView.layout(in: view, at: 0, [
                imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.topAnchor.constraint(equalTo: view.topAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
        UIView.animate(withDuration: 1.2, delay: 0, options: [.repeat, .autoreverse], animations: { [self] in
            self.imageViewBackground2.transform = CGAffineTransform(translationX: 0, y: 5)
            self.imageViewBackground3.transform = CGAffineTransform(translationX: 5, y: 0)
            self.imageViewBackground4.transform = CGAffineTransform(translationX: 10, y: 0)
        })
    }
    
    private func setupButtonFreePlay() {
        var index = 4
        buttonFreePlay.setTitle("Free Play", for: .normal)
        buttonFreePlay.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonFreePlay.titleLabel?.font = UIFont(name: "Before the Rainbow", size: 40)
        buttonFreePlay.titleLabel?.minimumScaleFactor = 0.5
        buttonFreePlay.backgroundColor = rainbowColors[index]
        buttonFreePlay.layer.borderColor = UIColor.white.cgColor
        buttonFreePlay.layer.borderWidth = 1
        buttonFreePlay.layer.cornerRadius = 10
        Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { [weak self] timer in
            guard let self else { return }
            index += 1
            self.buttonFreePlay.backgroundColor = self.rainbowColors[index % self.rainbowColors.count]
        }
    }
    
    private func setupButtonStoryMode() {
        var index = 0
        buttonStoryMode.setTitle("Story Mode", for: .normal)
        buttonStoryMode.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonStoryMode.titleLabel?.font = UIFont(name: "Before the Rainbow", size: 40)
        buttonStoryMode.titleLabel?.minimumScaleFactor = 0.5
        buttonStoryMode.backgroundColor = rainbowColors[index]
        buttonStoryMode.layer.borderColor = UIColor.white.cgColor
        buttonStoryMode.layer.borderWidth = 1
        buttonStoryMode.layer.cornerRadius = 10
        buttonStoryMode.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        buttonStoryMode.addTarget(self, action: #selector(animationButtonStart), for: .touchDown)
        buttonStoryMode.addTarget(self, action: #selector(animationButtonEnd), for: .touchDragOutside)
        Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { [weak self] timer in
            guard let self else { return }
            index += 1
            self.buttonStoryMode.backgroundColor = self.rainbowColors[index % self.rainbowColors.count]
        }
    }
    
    private func setupLabelTitle() {
        let attributeStroke: [NSAttributedString.Key: Any] = [.strokeColor: UIColor.white, .strokeWidth: -1]
        let attributedTitle = NSMutableAttributedString(string: "Colin's Origins", attributes: attributeStroke)
        labelTitle.adjustsFontSizeToFitWidth = true
        labelTitle.font = UIFont(name: "Before the Rainbow", size: 120)
        labelTitle.minimumScaleFactor = 0.5
        
        for i in 0..<attributedTitle.length {
            let colorIndex = i % rainbowColors.count
            attributedTitle.addAttribute(.foregroundColor, value: rainbowColors[colorIndex], range: NSRange(location: i, length: 1))
        }
        labelTitle.attributedText = attributedTitle
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 80
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(labelTitle)
        stackView.addArrangedSubview(buttonStoryMode)
        // Maybe for a future version!
        // stackViewButtons.addArrangedSubview(buttonFreePlay)
        stackView.layout(in: view, [
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            stackView.widthAnchor.constraint(lessThanOrEqualToConstant: 600),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupView() {
        navigationController?.delegate = self
        view.backgroundColor = .white
    }
    
}
