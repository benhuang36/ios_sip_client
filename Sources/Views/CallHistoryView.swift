import SwiftUI

struct CallHistoryView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        List {
            if appState.callHistory.isEmpty {
                Text(L10n.General.noData)
                    .foregroundColor(.secondary)
            } else {
                ForEach(appState.callHistory) { record in
                    HStack {
                        Image(systemName: icon(for: record))
                            .foregroundColor(color(for: record))
                        VStack(alignment: .leading) {
                            Text(record.counterpart)
                                .font(.headline)
                            Text(record.timestamp, style: .time)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text(label(for: record))
                            .font(.subheadline)
                            .foregroundColor(color(for: record))
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }

    private func icon(for record: CallRecord) -> String {
        switch (record.direction, record.status) {
        case (.outbound, .dialing):
            return "phone.arrow.up.right"
        case (.outbound, _):
            return "phone.fill"
        case (.inbound, .ringing):
            return "phone.arrow.down.left"
        case (.inbound, .ended):
            return "phone.badge.minus"
        default:
            return "phone"
        }
    }

    private func color(for record: CallRecord) -> Color {
        switch record.direction {
        case .outbound:
            return .green
        case .inbound:
            return record.status == .ended ? .orange : .blue
        }
    }

    private func label(for record: CallRecord) -> String {
        switch (record.direction, record.status) {
        case (.inbound, .ended):
            return L10n.Calls.missedCall
        case (.inbound, _):
            return L10n.Calls.incomingCall
        case (.outbound, _):
            return L10n.Calls.outgoingCall
        }
    }
}

struct CallHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        CallHistoryView()
            .environmentObject(AppState())
    }
}
