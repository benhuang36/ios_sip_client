import SwiftUI

struct ContentView: View {
    @State private var username = "1001"
    @State private var password = ""
    @State private var domain = "sip.example.com"
    @State private var transport: SipTransport.Kind = .udp
    @StateObject private var manager = SipManager()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account")) {
                    TextField("Username", text: $username)
                    SecureField("Password", text: $password)
                    TextField("Domain", text: $domain)
                }

                Section(header: Text("Transport")) {
                    Picker("Mode", selection: $transport) {
                        Text("UDP").tag(SipTransport.Kind.udp)
                        Text("TCP").tag(SipTransport.Kind.tcp)
                        Text("TLS").tag(SipTransport.Kind.tls)
                    }.pickerStyle(.segmented)
                }

                Section {
                    Button(action: register) {
                        Label("Register", systemImage: "phone.down.circle")
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(manager.registrationState == .connecting)

                    Button(role: .destructive, action: manager.stop) {
                        Label("Disconnect", systemImage: "xmark.circle")
                    }
                }

                Section(header: Text("Status")) {
                    switch manager.registrationState {
                    case .idle:
                        Text("Idle")
                    case .connecting:
                        ProgressView().progressViewStyle(.circular)
                        Text("Connecting…")
                    case .registered:
                        Text("Registered with server")
                            .foregroundStyle(.green)
                    case .failed(let message):
                        Text("Failed: \(message)")
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("SIP Login")
        }
    }

    private func register() {
        let config = SipConfiguration(
            credentials: .init(
                username: username,
                password: password,
                domain: domain,
                displayName: nil
            ),
            transport: .init(kind: transport, port: transport == .tls ? 5061 : 5060),
            stunServer: nil
        )
        manager.start(config: config)
    }
}

#Preview {
    ContentView()
}
