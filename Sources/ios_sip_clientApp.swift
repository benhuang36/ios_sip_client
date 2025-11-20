import SwiftUI

@main
struct IosSipClientApp: App {
    @StateObject private var appState = AppState()
    @State private var showDrawer = false

    var body: some Scene {
        WindowGroup {
            ContentView(showDrawer: $showDrawer)
                .environmentObject(appState)
                .preferredColorScheme(appState.preferences.appearance.colorScheme)
        }
    }
}
