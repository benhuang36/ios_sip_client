import SwiftUI

struct ContactEditorView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.dismiss) private var dismiss
    @Binding var contact: Contact?
    @State private var name: String = ""
    @State private var number: String = ""

    var body: some View {
        Form {
            Section(header: Text(L10n.Contacts.namePlaceholder)) {
                TextField(L10n.Contacts.namePlaceholder, text: $name)
                TextField(L10n.Contacts.numberPlaceholder, text: $number)
                    .keyboardType(.phonePad)
            }
        }
        .navigationTitle(contact == nil ? L10n.General.add : L10n.General.edit)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(L10n.General.cancel) { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button(L10n.General.save) {
                    save()
                    dismiss()
                }
            }
        }
        .onAppear(perform: populate)
    }

    private func populate() {
        name = contact?.name ?? ""
        number = contact?.phoneNumber ?? ""
    }

    private func save() {
        if let existing = contact {
            appState.updateContact(existing, name: name, number: number)
        } else {
            appState.addContact(name: name, number: number)
        }
    }
}

struct ContactEditorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactEditorView(contact: .constant(nil))
                .environmentObject(AppState())
        }
    }
}
