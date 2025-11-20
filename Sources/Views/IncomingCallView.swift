import SwiftUI

struct IncomingCallView: View {
    var call: CallSession
    var onAnswer: () -> Void
    var onDecline: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text(L10n.Calls.incomingCall)
                .font(.headline)
            Text(call.counterpart)
                .font(.title)
            HStack(spacing: 32) {
                Button(action: onDecline) {
                    Label(L10n.General.decline, systemImage: "phone.down.fill")
                        .padding()
                        .background(Color.red.opacity(0.9))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                Button(action: onAnswer) {
                    Label(L10n.General.answer, systemImage: "phone.fill")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.thinMaterial)
        .cornerRadius(16)
        .padding()
    }
}

struct IncomingCallView_Previews: PreviewProvider {
    static var previews: some View {
        IncomingCallView(
            call: CallSession(id: UUID(), counterpart: "0912 345 678", direction: .inbound, state: .ringing),
            onAnswer: {},
            onDecline: {}
        )
    }
}
