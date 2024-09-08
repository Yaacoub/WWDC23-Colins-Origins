import SwiftUI

struct Home: UIViewControllerRepresentable {
    
    
    
    // MARK: - Methods
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
    
}
