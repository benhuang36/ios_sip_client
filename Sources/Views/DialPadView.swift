import SwiftUI

struct DialPadView: View {
    @EnvironmentObject private var appState: AppState
    @State private var number: String = ""
    @State private var showingCallStatus = false

    let keypad: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["*", "0", "#"]
    ]

    var body: some View {
        VStack(spacing: 24) {
            TextField(L10n.DialPad.inputPlaceholder, text: $number)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .keyboardType(.phonePad)
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.secondary))
                .padding(.horizontal)

            VStack(spacing: 16) {
                ForEach(keypad, id: \.[0]) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button(action: { number.append(item) }) {
                                Text(item)
                                    .font(.title)
                                    .frame(maxWidth: .infinity, minHeight: 44)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)

            Button(action: placeCall) {
                HStack {
                    Image(systemName: "phone.fill")
                    Text(L10n.DialPad.callAction)
                }
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(.horizontal)
            }
            .disabled(number.isEmpty)

            Spacer()
        }
        .sheet(isPresented: $showingCallStatus) {
            CallStatusView(number: number)
        }
        .padding(.top)
    }

    private func placeCall() {
        appState.placeCall(to: number)
        showingCallStatus = true
    }
}

struct DialPadView_Previews: PreviewProvider {
    static var previews: some View {
        DialPadView()
            .environmentObject(AppState())
    }
}
