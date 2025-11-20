import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState
    @Binding var showDrawer: Bool
    @State private var selectedTab = 0
    @State private var showIncoming = false

    var body: some View {
        ZStack(alignment: .leading) {
            NavigationView {
                VStack(spacing: 0) {
                    header
                    TabView(selection: $selectedTab) {
                        CallHistoryView()
                            .tag(0)
                            .tabItem { Label(L10n.Tabs.history, systemImage: "clock") }
                        ContactsView()
                            .tag(1)
                            .tabItem { Label(L10n.Tabs.contacts, systemImage: "person.2") }
                        DialPadView()
                            .tag(2)
                            .tabItem { Label(L10n.Tabs.keypad, systemImage: "circle.grid.3x3") }
                    }
                }
                .navigationBarHidden(true)
            }
            .blur(radius: showDrawer ? 4 : 0)
            .disabled(showDrawer)

            if showDrawer {
                DrawerView(showDrawer: $showDrawer)
                    .frame(maxWidth: 280)
                    .transition(.move(edge: .leading))
            }
        }
        .overlay(alignment: .topLeading) {
            Color.black.opacity(showDrawer ? 0.3 : 0)
                .ignoresSafeArea()
                .onTapGesture { withAnimation { showDrawer = false } }
        }
        .overlay {
            if let incoming = appState.incomingCall {
                IncomingCallView(call: incoming, onAnswer: appState.answerCall, onDecline: appState.declineCall)
            }
        }
    }

    private var header: some View {
        HStack {
            Button(action: { withAnimation { showDrawer.toggle() } }) {
                Image(systemName: "line.3.horizontal")
                    .imageScale(.large)
                    .padding()
            }

            Spacer()
            Text(L10n.General.appName)
                .font(.headline)
            Spacer()

            Button(action: { appState.receiveInvite(from: "+886900000000") }) {
                Image(systemName: "bell.badge")
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(showDrawer: .constant(false))
            .environmentObject(AppState())
    }
}
