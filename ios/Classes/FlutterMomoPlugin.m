#import "FlutterMomoPlugin.h"
#if __has_include(<flutter_momo/flutter_momo-Swift.h>)
#import <flutter_momo/flutter_momo-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_momo-Swift.h"
#endif

@implementation FlutterMomoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMomoPlugin registerWithRegistrar:registrar];
}
@end
