import SwiftUI

struct CallStatusView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.dismiss) private var dismiss
    var number: String

    var body: some View {
        VStack(spacing: 24) {
            if let call = appState.currentCall {
                Text(call.direction == .outbound ? L10n.General.dialing : L10n.Calls.incomingCall)
                    .font(.headline)
                Text(call.counterpart)
                    .font(.title)
            } else {
                Text(number)
                    .font(.title)
            }

            HStack(spacing: 32) {
                Button(role: .destructive) {
                    appState.endCurrentCall()
                    dismiss()
                } label: {
                    Label(L10n.General.decline, systemImage: "phone.down.fill")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.9))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                if appState.currentCall?.state == .dialing {
                    Button {
                        dismiss()
                    } label: {
                        Label(L10n.General.cancel, systemImage: "xmark")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding()
    }
}

struct CallStatusView_Previews: PreviewProvider {
    static var previews: some View {
        CallStatusView(number: "123")
            .environmentObject(AppState())
    }
}
