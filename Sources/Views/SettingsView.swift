import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.dismiss) private var dismiss
    @Binding var showDrawer: Bool

    private let languages = [LanguageOption(id: "zh-Hant", displayName: "繁體中文")]

    var body: some View {
        Form {
            Section(header: Text(L10n.Settings.theme)) {
                Picker(L10n.Settings.theme, selection: $appState.preferences.appearance) {
                    ForEach(AppearanceMode.allCases) { mode in
                        Text(mode.displayName).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section(header: Text(L10n.Settings.language)) {
                Picker(L10n.Settings.language, selection: $appState.preferences.language) {
                    ForEach(languages) { language in
                        Text(language.displayName).tag(language)
                    }
                }
            }
        }
        .navigationTitle(L10n.Settings.title)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(L10n.General.cancel) { dismiss(); showDrawer = false }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button(L10n.General.save) { dismiss(); showDrawer = false }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView(showDrawer: .constant(false))
                .environmentObject(AppState())
        }
    }
}
