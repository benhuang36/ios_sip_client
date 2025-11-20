# ios_sip_client

A SwiftUI-based SIP client that can register to a real SIP server using the PJSIP stack.

## Features
- Enter SIP credentials (username, password, domain) and choose UDP/TCP/TLS transport.
- Register and disconnect against a live SIP registrar.
- Simple status UI for registration feedback.

## Getting started
1. Open `ios_sip_client.xcodeproj` in Xcode 15 or newer.
2. Select the **ios_sip_client** target and ensure the deployment target is iOS 16 (or newer) as configured.
3. Build and run on a simulator or device. By default the project uses a stub PJSIP wrapper so it compiles immediately after cloning.
4. To link the real PJSIP SDK, add the frameworks/pods to the project, expose `pjsua` headers in a bridging header, and define `USE_PJSIP` in **Other Swift Flags** so the native wrapper is compiled.
5. Enter your SIP account details and tap **Register**.

See [`docs/REAL_SIP_CLIENT.md`](docs/REAL_SIP_CLIENT.md) for detailed setup instructions and extension points for calls, audio routing, and NAT traversal.
