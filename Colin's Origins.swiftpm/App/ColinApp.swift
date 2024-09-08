import SwiftUI

@main
struct ColinApp: App {
    
    
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            Home()
                .statusBar(hidden: ProcessInfo.processInfo.isiOSAppOnMac)
                .onAppear(perform: setupOnAppear)
                .onDisappear(perform: setupOnDisappear)
        }
    }
    
    
    
    // MARK: - Private Setup Methods
    
    private func setupOnAppear() {
        AudioManager.startMusic(.main)
        NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: .main) { _ in
            AudioManager.stopMusic(.main)
        }
    }
    
    private func setupOnDisappear() {
        AudioManager.stopMusic(.main)
    }
    
}
