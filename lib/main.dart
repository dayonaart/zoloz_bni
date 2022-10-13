import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:myapp/chrome_web.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zolozkit_for_flutter/zolozkit_for_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.microphone.request();
  // await Permission.storage.request();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      ));
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // final _clientCfg =
  //     "eyJzaWduIjoib05jeE5xM1pPbUY3UXdBT2pqVVVHNU1YV1liSXdaaFA2RGVuSW82ZXN1UHFEdDNmWUk3ajRrRWZiWWdDU2I3T0M4clZNRVlhaTkzU0FtWm4wSmxjaDJaTitqSmRjaDNwNXhSalBTVVRTc3NGT0dxN3NoQXl1Q2ordyswS1h6OHZ6NDRrak1TR3g2Ly9CL1ZoV3M5bVpxU2xoNllJSDV5YlV1QlYzSjdwTk9NREJyN0dUZUNkYitXV1g3aDNsSjMrK2xBc0Y5QkN3TVBMaklZM2JmUkdVNkxNTlRJQmN2enJ3WE0rV0o4V05XZWhqUVBnY3p5REJxamx5VjR6ODQyLytKOUJHaVEvYVp4aVdUWjg4TGZhS0xtZG5PQk8vcHFxN2xmUTdiTEFsd3FnbkFDaEZiUUhLNmpTUVRYZDRTMldiVHhUNjNUR2tuQnZPU25ZMjcxVjRBPT0iLCJjb250ZW50Ijoie1wiR0FURVdBWV9VUkxcIjpcImh0dHBzOi8vc2ctc2FuZGJveC1hcGkuem9sb3ouY29tL3ptZ3MvdjIvc2VjXCIsXCJBUFBfSURcIjpcIlwiLFwiaXNJZnJhbWVcIjp0cnVlLFwia2V5TWV0YVwiOlwie1xcXCJtaWRcXFwiOlxcXCI0ODBcXFwiLFxcXCJrZXlWZXJcXFwiOlxcXCJ2MVxcXCJ9XCIsXCJsb2NhbGVcIjpcImlkXCIsXCJpbnRlcnJ1cHRDYWxsYmFja1VybFwiOlwiaHR0cHM6Ly9sb2NhbGhvc3Q6ODQ0My9zaW1wYW5hbi9kYXRhLWZpbGVcIixcIldPUktTUEFDRV9JRFwiOlwiXCIsXCJ6aW1JZFwiOlwiRzAwMDAwMDAwNGI2MDM4MjM3NjRmZWRiYjg4ZDQyN2QzNTJlYTUzNTAyXCIsXCJzdGF0ZVwiOlwiRzAwMDAwMDAwNEZGQzIwMjIxMDEzMDAwMDAwMDI3NTc2NTA0MzU4XCIsXCJjb21wbGV0ZUNhbGxiYWNrVXJsXCI6XCJodHRwczovL2xvY2FsaG9zdDo4NDQzL3NpbXBhbmFuL2RhdGEtZmlsZVwiLFwiQzJTX1BVQl9LRVlcIjpcIk1JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBdmc3OEVJRzdDS1RWK0ZMb3RDdS80aEpnYmhQdWtWVTFVaTh1azN0bERBcnQ4ekQ4cTRTSCtsQm92YU9jaHhleWFtU1EwSEszTmd2Z1RJY2ZEaEZjT05FVFR6TnIxRjlhSTFqaWlrdkpDNlR4NVc0dmE3TjlVREI4K3I1TzM2MmtScnR0QUI3M3B5ZWJnQWlEOTMyVm4xaEU5ZTMxQlQ4SnEwK3gxQUVlS0FsMGxTS3dmOUFtbnFuQ2xTSS84N2tIakVKMmZWU0xDR1I5M3NzMDlsdmp3YWJ5KzFiSktSWkhUb3k1UmR0by9mTVZnNHZuL3ZsNEN4dnFySWpFTGpBTjFwcU5NLzBXWG9Kem9wb2dvYktTVXh4R1JvRU4xRFFnZjRieTMwS3ZHeEhqUzcxcUFKdlowMk41RjN5YkdSdWczdjc3TXJtc1F5YmhVQkI5cTRPWTlRSURBUUFCXCIsXCJSRU1PVEVMT0dfVVJMXCI6XCJodHRwczovL3NnLXNhbmRib3gtYXBpLnpvbG96LmNvbS9sb2dndy9sb2dVcGxvYWQuZG9cIn0ifQ==";
  String get _html => """
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    </head>
    <body>
         <script type='text/javascript'>
        var clientCfg =
      "eyJzaWduIjoib05jeE5xM1pPbUY3UXdBT2pqVVVHNU1YV1liSXdaaFA2RGVuSW82ZXN1UHFEdDNmWUk3ajRrRWZiWWdDU2I3T0M4clZNRVlhaTkzU0FtWm4wSmxjaDJaTitqSmRjaDNwNXhSalBTVVRTc3NGT0dxN3NoQXl1Q2ordyswS1h6OHZ6NDRrak1TR3g2Ly9CL1ZoV3M5bVpxU2xoNllJSDV5YlV1QlYzSjdwTk9NREJyN0dUZUNkYitXV1g3aDNsSjMrK2xBc0Y5QkN3TVBMaklZM2JmUkdVNkxNTlRJQmN2enJ3WE0rV0o4V05XZWhqUVBnY3p5REJxamx5VjR6ODQyLytKOUJHaVEvYVp4aVdUWjg4TGZhS0xtZG5PQk8vcHFxN2xmUTdiTEFsd3FnbkFDaEZiUUhLNmpTUVRYZDRTMldiVHhUNjNUR2tuQnZPU25ZMjcxVjRBPT0iLCJjb250ZW50Ijoie1wiR0FURVdBWV9VUkxcIjpcImh0dHBzOi8vc2ctc2FuZGJveC1hcGkuem9sb3ouY29tL3ptZ3MvdjIvc2VjXCIsXCJBUFBfSURcIjpcIlwiLFwiaXNJZnJhbWVcIjp0cnVlLFwia2V5TWV0YVwiOlwie1xcXCJtaWRcXFwiOlxcXCI0ODBcXFwiLFxcXCJrZXlWZXJcXFwiOlxcXCJ2MVxcXCJ9XCIsXCJsb2NhbGVcIjpcImlkXCIsXCJpbnRlcnJ1cHRDYWxsYmFja1VybFwiOlwiaHR0cHM6Ly9sb2NhbGhvc3Q6ODQ0My9zaW1wYW5hbi9kYXRhLWZpbGVcIixcIldPUktTUEFDRV9JRFwiOlwiXCIsXCJ6aW1JZFwiOlwiRzAwMDAwMDAwNGI2MDM4MjM3NjRmZWRiYjg4ZDQyN2QzNTJlYTUzNTAyXCIsXCJzdGF0ZVwiOlwiRzAwMDAwMDAwNEZGQzIwMjIxMDEzMDAwMDAwMDI3NTc2NTA0MzU4XCIsXCJjb21wbGV0ZUNhbGxiYWNrVXJsXCI6XCJodHRwczovL2xvY2FsaG9zdDo4NDQzL3NpbXBhbmFuL2RhdGEtZmlsZVwiLFwiQzJTX1BVQl9LRVlcIjpcIk1JSUJJakFOQmdrcWhraUc5dzBCQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBdmc3OEVJRzdDS1RWK0ZMb3RDdS80aEpnYmhQdWtWVTFVaTh1azN0bERBcnQ4ekQ4cTRTSCtsQm92YU9jaHhleWFtU1EwSEszTmd2Z1RJY2ZEaEZjT05FVFR6TnIxRjlhSTFqaWlrdkpDNlR4NVc0dmE3TjlVREI4K3I1TzM2MmtScnR0QUI3M3B5ZWJnQWlEOTMyVm4xaEU5ZTMxQlQ4SnEwK3gxQUVlS0FsMGxTS3dmOUFtbnFuQ2xTSS84N2tIakVKMmZWU0xDR1I5M3NzMDlsdmp3YWJ5KzFiSktSWkhUb3k1UmR0by9mTVZnNHZuL3ZsNEN4dnFySWpFTGpBTjFwcU5NLzBXWG9Kem9wb2dvYktTVXh4R1JvRU4xRFFnZjRieTMwS3ZHeEhqUzcxcUFKdlowMk41RjN5YkdSdWczdjc3TXJtc1F5YmhVQkI5cTRPWTlRSURBUUFCXCIsXCJSRU1PVEVMT0dfVVJMXCI6XCJodHRwczovL3NnLXNhbmRib3gtYXBpLnpvbG96LmNvbS9sb2dndy9sb2dVcGxvYWQuZG9cIn0ifQ==";
        var baseurl = "https://sg-production-cdn.zoloz.com/page/zoloz-face-fe/index.html";
var zolozurl = baseurl + "?clientcfg="+encodeURIComponent(clientCfg);
// redirect the url 
window.location.href = zolozurl;
    </script>
    </body>
</html>
                  """;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(child: ChromeBrowser(_html)),
    );
  }

  Scaffold _zolozFlutter() {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              var metaInfo = await ZolozkitForFlutter.metaInfo;
              print("metaaaa=> $metaInfo");
              await ZolozkitForFlutter.start("_clientCfg", {
                // "nik": "1323233222222234",
                // "channel": "EFORM",
                // "bizId": "20221013104354711403",
                // "refNum": "20221013104354137",
                // // "metaInfo": metaInfo,
                // "userId": "dummy_userid_1665632634071",
                // "completeCallbackUrl":
                //     "https://localhost:8443/simpanan/data-file",
                // "interruptCallbackUrl":
                //     "https://localhost:8443/simpanan/data-file",
                // "isIframe": "Y",
                // "locale": "id"
              }, (res) {
                print(res);
              });
            },
            child: const Text("data")),
      ),
    );
  }
}
