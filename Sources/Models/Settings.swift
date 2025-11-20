import Foundation
import SwiftUI

enum AppearanceMode: String, CaseIterable, Identifiable, Codable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .system:
            return L10n.Settings.appearanceFollowSystem
        case .light:
            return L10n.Settings.appearanceLight
        case .dark:
            return L10n.Settings.appearanceDark
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

struct LanguageOption: Identifiable, Equatable, Codable {
    let id: String
    let displayName: String
}

struct AppPreferences: Codable, Equatable {
    var appearance: AppearanceMode
    var language: LanguageOption
}
