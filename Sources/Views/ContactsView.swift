import SwiftUI

struct ContactsView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showingEditor = false
    @State private var contactToEdit: Contact?

    var body: some View {
        List {
            if appState.contacts.isEmpty {
                Text(L10n.General.noData)
                    .foregroundColor(.secondary)
            } else {
                ForEach(appState.contacts) { contact in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(contact.name)
                                .font(.headline)
                            Text(contact.phoneNumber)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button { appState.placeCall(to: contact.phoneNumber) } label: {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.green)
                        }
                        Button { contactToEdit = contact; showingEditor = true } label: {
                            Image(systemName: "pencil")
                        }
                        Button(role: .destructive) { appState.deleteContact(contact) } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { contactToEdit = nil; showingEditor = true }) {
                    Label(L10n.General.add, systemImage: "plus")
                }
            }
        }
        .navigationTitle(L10n.Contacts.title)
        .sheet(isPresented: $showingEditor) {
            NavigationView {
                ContactEditorView(contact: $contactToEdit)
            }
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactsView()
                .environmentObject(AppState())
        }
    }
}
