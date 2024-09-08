import UIKit

enum Asset: String {
    
    
    
    // MARK: - Properties
    
    var image: UIImage { UIImage(named: rawValue) ?? UIImage(systemName: "questionmark.square.dashed") ?? UIImage() }
    
    
    
    // MARK: - Cases
    
    case buttonExit = "Buttons/Exit"
    case buttonLearnMore = "Buttons/Learn More"
    case buttonSkip = "Buttons/Skip"
    
    case emotionCurious = "Emotions/Curious"
    case emotionFunny = "Emotions/Funny"
    case emotionHappy = "Emotions/Happy"
    case emotionSad = "Emotions/Sad"
    
    case learnMoreBlendModes = "Learn More/Blend Modes"
    case learnMoreBrightness = "Learn More/Brightness"
    case learnMoreHue = "Learn More/Hue"
    case learnMoreHSB = "Learn More/HSB"
    case learnMoreModels = "Learn More/Models"
    case learnMoreSaturation = "Learn More/Saturation"
    
    case propCarsDay = "Props/Cars Day"
    case propCarsDusk = "Props/Cars Dusk"
    case propCityDay = "Props/City Day"
    case propCityDusk = "Props/City Dusk"
    case propCityNight = "Props/City Night"
    case propCloud1 = "Props/Cloud 1"
    case propCloud2 = "Props/Cloud 2"
    case propCloud3 = "Props/Cloud 3"
    case propCloudsFullscreen = "Props/Clouds Fullscreen"
    case propDirtAndSky = "Props/Dirt and Sky"
    case propGrassDay = "Props/Grass Day"
    case propGrassNight = "Props/Grass Night"
    case propGrassFullscreen = "Props/Grass Fullscreen"
    case propMoon = "Props/Moon"
    case propPictureFrameDay = "Props/Picture Frame Day"
    case propPictureFrameDusk = "Props/Picture Frame Dusk"
    case propPictureFrameNight = "Props/Picture Frame Night"
    case propSmokeDay = "Props/Smoke Day"
    case propSmokeDusk = "Props/Smoke Dusk"
    case propSun = "Props/Sun"
    case propSunFullscreen = "Props/Sun Fullscreen"
    case propWindows1 = "Props/Windows 1"
    case propWindows2 = "Props/Windows 2"
    case propWindows3 = "Props/Windows 3"
    
}
