import SwiftUI

struct MarkdownSection: Identifiable {
    
    
    
    // MARK: - Properties
    
    let title: String
    let body: LocalizedStringKey
    let image: UIImage?
    
    var id = UUID()
    
    
    
    // MARK: - Initialization
    
    init(title: String, body: LocalizedStringKey, image: Asset? = nil) {
        self.title = title
        self.body = body
        self.image = image?.image
    }
    
}
