import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}

class ChromeBrowser extends StatelessWidget {
  final ChromeSafariBrowser browser = MyChromeSafariBrowser();
  String? url;
  ChromeBrowser(this.url, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: _inAppWeb(),
    );
  }

  InAppWebView _inAppWeb() {
    return InAppWebView(
      androidOnPermissionRequest: (controller, origin, resources) async {
        return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT);
      },
      initialData: InAppWebViewInitialData(data: url!),
      // initialFile: 'assets/index.html',
    );
  }

  Center _chrome() {
    return Center(
      child: ElevatedButton(
          onPressed: () async {
            try {
              await browser.open(
                  url: Uri.parse("https://id.webcamtests.com/"),
                  options: ChromeSafariBrowserClassOptions(
                      android: AndroidChromeCustomTabsOptions(
                          shareState: CustomTabsShareState.SHARE_STATE_OFF),
                      ios: IOSSafariOptions(barCollapsingEnabled: true)));
            } catch (e) {
              return;
            }
          },
          child: const Text("Open Chrome Safari Browser")),
    );
  }
}
