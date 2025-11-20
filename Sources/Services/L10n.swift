import Foundation
import SwiftUI

enum L10n {
    enum General {
        static var appName: String { localized("app_name") }
        static var drawerTitle: String { localized("drawer_title") }
        static var accountSettings: String { localized("account_settings") }
        static var settings: String { localized("settings") }
        static var about: String { localized("about") }
        static var version: String { localized("version") }
        static var confirm: String { localized("confirm") }
        static var cancel: String { localized("cancel") }
        static var save: String { localized("save") }
        static var delete: String { localized("delete") }
        static var edit: String { localized("edit") }
        static var add: String { localized("add") }
        static var dialing: String { localized("dialing") }
        static var call: String { localized("call") }
        static var answer: String { localized("answer") }
        static var decline: String { localized("decline") }
        static var noData: String { localized("no_data") }
    }

    enum Tabs {
        static var history: String { localized("tab_history") }
        static var contacts: String { localized("tab_contacts") }
        static var keypad: String { localized("tab_keypad") }
    }

    enum Calls {
        static var incomingCall: String { localized("incoming_call") }
        static var outgoingCall: String { localized("outgoing_call") }
        static var missedCall: String { localized("missed_call") }
    }

    enum Contacts {
        static var title: String { localized("contacts_title") }
        static var namePlaceholder: String { localized("contacts_name_placeholder") }
        static var numberPlaceholder: String { localized("contacts_number_placeholder") }
    }

    enum DialPad {
        static var inputPlaceholder: String { localized("dialpad_placeholder") }
        static var callAction: String { localized("dialpad_call_action") }
    }

    enum Settings {
        static var title: String { localized("settings_title") }
        static var theme: String { localized("settings_theme") }
        static var appearanceFollowSystem: String { localized("settings_appearance_system") }
        static var appearanceLight: String { localized("settings_appearance_light") }
        static var appearanceDark: String { localized("settings_appearance_dark") }
        static var language: String { localized("settings_language") }
    }

    enum Account {
        static var title: String { localized("account_title") }
        static var displayName: String { localized("account_display_name") }
        static var username: String { localized("account_username") }
        static var password: String { localized("account_password") }
        static var domain: String { localized("account_domain") }
        static var protocolTcp: String { localized("account_protocol_tcp") }
        static var protocolUdp: String { localized("account_protocol_udp") }
        static var transport: String { localized("account_transport") }
        static var login: String { localized("account_login") }
        static var logout: String { localized("account_logout") }
    }

    static func localized(_ key: String) -> String {
        NSLocalizedString(key, comment: "")
    }
}

extension Text {
    init(_ key: String, tableName: String? = nil) {
        self.init(LocalizedStringKey(key), tableName: tableName, bundle: .main, comment: "")
    }
}
