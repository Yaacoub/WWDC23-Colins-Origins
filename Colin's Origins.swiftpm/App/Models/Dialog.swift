struct DialogLine {
    
    
    
    // MARK: - Properties
    
    let speaker: Speaker
    let sentence: String
    let emotion: Emotion
    
    
    
    // MARK: - Enumerations
    
    enum Emotion: String {
        case curious = "Emotions/Curious"
        case funny = "Emotions/Funny"
        case happy = "Emotions/Happy"
        case sad = "Emotions/Sad"
    }
    
    enum Speaker: String {
        case colin = "Colin"
        case shay = "Shay"
    }
    
}
