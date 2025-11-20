# Building a real SIP client

The SwiftUI views and SIP wrapper in this repository are configured to talk to a production SIP server as soon as the PJSIP SDK is linked. PJSIP is a proven SIP/VoIP stack and exposes the `pjsua` API that handles account registration, presence, and media.

## Prerequisites
- Xcode 15+
- iOS 17+ deployment target
- PJSIP (built for iOS as XCFrameworks) or a pod that packages the libraries
- A SIP registrar/proxy with a reachable domain or IP
- SIP credentials (username, password, realm/domain) and the transport/port (UDP/TCP/TLS)

## Integrating PJSIP
1. Add the libraries to your project using one of:
   - CocoaPods (set `USE_PJSIP_POD=1` and optionally `PJSIP_PODSPEC=https://your.hosted/specs/PJSIP.podspec` before running `pod install --repo-update`)
   - Prebuilt XCFrameworks added to **Frameworks, Libraries, and Embedded Content**
2. Expose the headers in `YourApp-Bridging-Header.h`:
   ```objc
   #import <pjsua-lib/pjsua.h>
   ```
3. Ensure `Other Linker Flags` include `-ObjC` and that Audio, VideoToolbox, and AVFoundation frameworks are linked.
4. For VoIP push notifications, enable PushKit/CallKit capabilities (optional).

## Running against a live SIP server
1. Set your SIP hostname in the UI or provide it as a default in `ContentView`.
2. Choose the matching transport (UDP/TCP/TLS) and port required by your PBX/provider.
3. Tap **Register**. The `SipManager` invokes `PJSIPWrapper.bootstrap` to start `pjsua`, creates the transport, and calls `registerAccount` with your credentials. Successful registration will update the UI to **Registered**.
4. Use the `Disconnect` button to cleanly destroy the account and shut down the stack.

## Where to extend
- **Calls**: add `pjsua_call_make_call` and incoming-call callbacks inside `PJSIPWrapper`.
- **Audio routing**: configure `AVAudioSession` and `pjsua_set_snd_dev`.
- **STUN/TURN**: pass STUN/TURN servers into `SipConfiguration` for NAT traversal.
- **TLS**: if you need pinned certificates, customize the PJSIP `pj_ssl_sock_param` inside `bootstrap`.

With these steps the client can register against any SIP infrastructure that accepts PJSIP user agents, allowing you to test against PBX appliances, cloud SBCs, or hosted SIP providers.
