import AVFoundation

final class AudioManager {
    
    
    
    // MARK: - Properties
    
    static var currentMusic: Music?
    
    
    
    // MARK: - Initialization
    
    private init() {}
    
    
    
    // MARK: - Structures
    
    struct Music: Equatable {
        
        private let session = AVAudioSession.sharedInstance()
        private var player: AVAudioPlayer?
        
        static let main = Music(fileName: "Emotional Maths", ofType: "mp3")
        static let sfxButtonTap = Music(fileName: "SFX Button Tap", ofType: "mp3")
        static let sfxCorrect = Music(fileName: "SFX Correct", ofType: "mp3")
        static let sfxExit = Music(fileName: "SFX Exit", ofType: "mp3")
        static let sfxIncorrect = Music(fileName: "SFX Incorrect", ofType: "mp3")
        static let sfxSuccess = Music(fileName: "SFX Success", ofType: "mp3")
        
        fileprivate init(fileName: String, ofType type: String) {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: type) else { return }
            player = try? AVAudioPlayer(contentsOf: url)
            try? session.setCategory(.soloAmbient)
            try? session.setActive(true)
        }
        
        fileprivate func pause() {
            guard let isPlaying = player?.isPlaying, isPlaying else { return }
            player?.pause()
        }
        
        fileprivate func play() {
            guard player?.isPlaying == false else { return }
            currentMusic?.setVolume(0, fadeDuration: player?.duration ?? 0)
            player?.play()
            currentMusic?.setVolume(1, fadeDuration: player?.duration ?? 0)
        }
        
        fileprivate func resume() {
            guard let isPlaying = player?.isPlaying, !isPlaying else { return }
            player?.play()
        }
        
        fileprivate func setVolume(_ volume: Float, fadeDuration: TimeInterval = 0) {
            player?.setVolume(volume, fadeDuration: fadeDuration)
        }
        
        fileprivate func start() {
            currentMusic?.stop()
            currentMusic = self
            player?.numberOfLoops = -1
            player?.volume = 0
            player?.play()
            player?.setVolume(0.5, fadeDuration: 4)
        }
        
        fileprivate func stop() {
            if currentMusic == self { currentMusic = nil }
            player?.setVolume(0, fadeDuration: 4)
            player?.stop()
        }
        
    }
    
    
    
    // MARK: - Methods
    
    static func pauseMusic(_ music: Music) {
        music.pause()
    }
    
    static func playOnce(_ music: Music) {
        music.play()
    }
    
    static func resumeMusic(_ music: Music) {
        music.resume()
    }
    
    static func startMusic(_ music: Music) {
        music.start()
    }
    
    static func stopMusic(_ music: Music) {
        music.stop()
    }
    
}
