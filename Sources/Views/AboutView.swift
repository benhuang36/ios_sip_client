import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            Text(L10n.General.appName)
                .font(.title)
            Text("v1.0.0")
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
        .navigationTitle(L10n.General.about)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(L10n.General.confirm) { dismiss() }
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { AboutView() }
    }
}
