import SwiftUI

struct DrawerView: View {
    @EnvironmentObject private var appState: AppState
    @Binding var showDrawer: Bool
    @State private var showAccountSettings = false
    @State private var showSettings = false
    @State private var showAbout = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            Divider()
            drawerItem(title: L10n.General.accountSettings, systemImage: "person.crop.circle") {
                showAccountSettings = true
            }
            drawerItem(title: L10n.General.settings, systemImage: "gearshape") {
                showSettings = true
            }
            drawerItem(title: L10n.General.about, systemImage: "info.circle") {
                showAbout = true
            }
            Spacer()
        }
        .padding(.top, 48)
        .padding(.horizontal, 16)
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(Material.ultraThin)
        .sheet(isPresented: $showAccountSettings) {
            NavigationView {
                AccountSettingsView(showDrawer: $showDrawer)
            }
        }
        .sheet(isPresented: $showSettings) {
            NavigationView {
                SettingsView(showDrawer: $showDrawer)
            }
        }
        .sheet(isPresented: $showAbout) {
            NavigationView {
                AboutView()
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(L10n.General.drawerTitle)
                .font(.title2)
                .bold()
            Text(appState.account.username.isEmpty ? "-" : appState.account.username)
                .font(.headline)
            Text(appState.account.domain)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    private func drawerItem(title: String, systemImage: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: systemImage)
                Text(title)
                Spacer()
            }
            .padding(.vertical, 10)
        }
        .buttonStyle(.plain)
    }
}

struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerView(showDrawer: .constant(true))
            .environmentObject(AppState())
    }
}
