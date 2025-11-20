# ios_sip_client

A SwiftUI-based SIP client that can register to a real SIP server using the PJSIP stack.

## Features
- Enter SIP credentials (username, password, domain) and choose UDP/TCP/TLS transport.
- Register and disconnect against a live SIP registrar.
- Simple status UI for registration feedback.

## Getting started
1. Add PJSIP to the Xcode project (CocoaPods or XCFrameworks) and expose `pjsua` headers in a bridging header.
2. Open the project and run the `SipClientApp` target on a device or simulator.
3. Enter your SIP account details and tap **Register**.

See [`docs/REAL_SIP_CLIENT.md`](docs/REAL_SIP_CLIENT.md) for detailed setup instructions and extension points for calls, audio routing, and NAT traversal.
