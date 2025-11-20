import Foundation

// MARK: - PJSIP-backed implementation (compiled only when USE_PJSIP is defined)
#if USE_PJSIP
final class PJSIPWrapper {
    static let shared = PJSIPWrapper()

    private var isInitialized = false
    private var accountId: Int32 = -1

    func bootstrap(transport: SipTransport) throws {
        guard !isInitialized else { return }

        try pjsuaCheck(status: pjsua_create())

        var cfg = pjsua_config()
        pjsua_config_default(&cfg)

        var logCfg = pjsua_logging_config()
        pjsua_logging_config_default(&logCfg)
        logCfg.console_level = 4

        var mediaCfg = pjsua_media_config()
        pjsua_media_config_default(&mediaCfg)

        try pjsuaCheck(status: pjsua_init(&cfg, &logCfg, &mediaCfg))

        var transportCfg = pjsua_transport_config()
        pjsua_transport_config_default(&transportCfg)
        transportCfg.port = transport.port

        let transportType: pjsip_transport_type_e
        switch transport.kind {
        case .udp: transportType = PJSIP_TRANSPORT_UDP
        case .tcp: transportType = PJSIP_TRANSPORT_TCP
        case .tls: transportType = PJSIP_TRANSPORT_TLS
        }

        try pjsuaCheck(status: pjsua_transport_create(transportType, &transportCfg, nil))
        try pjsuaCheck(status: pjsua_start())
        isInitialized = true
    }

    func registerAccount(credentials: SipCredentials, stunServer: URL?) throws {
        guard isInitialized else { throw SipError.notBootstrapped }

        var accCfg = pjsua_acc_config()
        pjsua_acc_config_default(&accCfg)

        credentials.userUri.withCString { accCfg.id = pj_str(UnsafeMutablePointer(mutating: $0)) }
        credentials.registrarUri.withCString { accCfg.reg_uri = pj_str(UnsafeMutablePointer(mutating: $0)) }

        if let displayName = credentials.displayName {
            displayName.withCString { accCfg.display_name = pj_str(UnsafeMutablePointer(mutating: $0)) }
        }

        if let stunServer {
            stunServer.absoluteString.withCString {
                accCfg.stun_srv_cnt = 1
                accCfg.stun_srv = [pj_str(UnsafeMutablePointer(mutating: $0))]
            }
        }

        var creds = pjsip_cred_info()
        creds.scheme = pj_str(UnsafeMutablePointer(mutating: "Digest"))
        creds.realm = pj_str(UnsafeMutablePointer(mutating: credentials.domain))
        creds.username = pj_str(UnsafeMutablePointer(mutating: credentials.username))
        creds.data_type = Int32(PJSIP_CRED_DATA_PLAIN_PASSWD.rawValue)
        creds.data = pj_str(UnsafeMutablePointer(mutating: credentials.password))
        accCfg.cred_count = 1
        accCfg.cred_info.0 = creds

        var account = pjsua_acc_id()
        try pjsuaCheck(status: pjsua_acc_add(&accCfg, pj_bool_t(PJ_TRUE), &account))
        accountId = account
    }

    func shutdown() {
        if accountId != -1 {
            pjsua_acc_del(accountId)
            accountId = -1
        }
        if isInitialized {
            pjsua_destroy()
            isInitialized = false
        }
    }

    // MARK: - Helpers

    private func pjsuaCheck(status: pj_status_t) throws {
        if status != PJ_SUCCESS {
            throw SipError.pjsipFailure(Int32(status))
        }
    }
}
#else
// MARK: - Stub implementation (default)
/// Provides a no-op PJSIP wrapper so the app builds out of the box without linking PJSIP.
/// Define `USE_PJSIP` in **Other Swift Flags** once the SDK and bridging header are configured.
final class PJSIPWrapper {
    static let shared = PJSIPWrapper()

    private var isInitialized = false
    private var accountId: Int32 = -1

    func bootstrap(transport: SipTransport) throws {
        isInitialized = true
        accountId = 1
        #if DEBUG
        print("PJSIP stub bootstrap invoked for transport: \(transport.description)")
        #endif
    }

    func registerAccount(credentials: SipCredentials, stunServer: URL?) throws {
        guard isInitialized else { throw SipError.notBootstrapped }
        #if DEBUG
        print("PJSIP stub registering user: \(credentials.username)@\(credentials.domain) (STUN: \(stunServer?.absoluteString ?? "none"))")
        #endif
    }

    func shutdown() {
        #if DEBUG
        print("PJSIP stub shutdown invoked")
        #endif
        isInitialized = false
        accountId = -1
    }
}
#endif

// MARK: - Errors
enum SipError: LocalizedError {
    case pjsipFailure(Int32)
    case notBootstrapped

    var errorDescription: String? {
        switch self {
        case .pjsipFailure(let code):
            return "PJSIP returned status \(code)"
        case .notBootstrapped:
            return "Bootstrap must be called before account registration"
        }
    }
}
