import SwiftUI

struct AccountSettingsView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.dismiss) private var dismiss
    @Binding var showDrawer: Bool

    var body: some View {
        Form {
            Section(header: Text(L10n.Account.displayName)) {
                TextField(L10n.Account.displayName, text: $appState.account.displayName)
            }
            Section(header: Text(L10n.Account.username)) {
                TextField(L10n.Account.username, text: $appState.account.username)
            }
            Section(header: Text(L10n.Account.password)) {
                SecureField(L10n.Account.password, text: $appState.account.password)
            }
            Section(header: Text(L10n.Account.domain)) {
                TextField(L10n.Account.domain, text: $appState.account.domain)
            }
            Section(header: Text(L10n.Account.transport)) {
                Picker(L10n.Account.transport, selection: $appState.account.transport) {
                    ForEach(SIPProtocol.allCases) { proto in
                        Text(proto.label).tag(proto)
                    }
                }
                .pickerStyle(.segmented)
            }
            Section {
                Button(appState.isLoggedIn ? L10n.Account.logout : L10n.Account.login) {
                    appState.isLoggedIn ? appState.logout() : appState.login()
                }
            }
        }
        .navigationTitle(L10n.Account.title)
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

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountSettingsView(showDrawer: .constant(false))
                .environmentObject(AppState())
        }
    }
}
