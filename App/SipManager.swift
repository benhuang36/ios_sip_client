import Combine
import Foundation

/// High level SIP manager that wraps PJSIP start up, registration and teardown.
/// This keeps UI code Swifty while bridging to the C API through PJSIPWrapper.
final class SipManager: ObservableObject {
    enum RegistrationState {
        case idle
        case connecting
        case registered
        case failed(String)
    }

    @Published private(set) var registrationState: RegistrationState = .idle

    private let wrapper: PJSIPWrapper

    init(wrapper: PJSIPWrapper = .shared) {
        self.wrapper = wrapper
    }

    func start(config: SipConfiguration) {
        registrationState = .connecting
        do {
            try wrapper.bootstrap(transport: config.transport)
            try wrapper.registerAccount(credentials: config.credentials, stunServer: config.stunServer)
            registrationState = .registered
        } catch {
            registrationState = .failed(error.localizedDescription)
        }
    }

    func stop() {
        wrapper.shutdown()
        registrationState = .idle
    }
}
