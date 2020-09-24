# flutter_momo

A MoMo payment plugin

## Setup:
Connect with MoMo to have partner account and necessary information

### Android:

Add internet permission into android `manifest.xml` file:

    <uses-permission android:name="android.permission.INTERNET" />

### iOS:

Config `Info.plist` file:

    <key>CFBundleURLTypes</key>
    <array>
      <dict>
        <key>CFBundleURLName</key>
        <string></string>
        <key>CFBundleURLSchemes</key>
        <array>
          <string>partnerSchemeId</string>
        </array>
      </dict>
    </array>
    <key>LSApplicationQueriesSchemes</key>
    <array>
      <string>momo</string>
    </array>
    <key>NSAppTransportSecurity</key>
    <dict>
      <key>NSAllowsArbitraryLoads</key>
      <true/>
    </dict>
- CFBundleURLTypes: add scheme . Note: partnerSchemeId provided by MoMo , get from business.momo.vn
- LSApplicationQueriesSchemes: add the scheme as "momo"

Add the below to `AppDelegate.swift` file:

    override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        MoMoPayment.handleOpenUrl(url: url, sourceApp: sourceApplication!)
        return true
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        MoMoPayment.handleOpenUrl(url: url, sourceApp: "")
        return true
    }

## Usage:

Checkout the example for the detail