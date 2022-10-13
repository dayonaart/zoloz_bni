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

class ChromeBrowser extends StatefulWidget {
  final ChromeSafariBrowser browser = MyChromeSafariBrowser();
  String? url;
  ChromeBrowser(this.url, {super.key});
  @override
  _ChromeBrowserState createState() => _ChromeBrowserState();
}

class _ChromeBrowserState extends State<ChromeBrowser> {
  @override
  void initState() {
    // widget.browser.addMenuItem(ChromeSafariBrowserMenuItem(
    //     id: 1,
    //     label: 'Custom item menu 1',
    //     action: (url, title) {
    //       print('Custom item menu 1 clicked!');
    //     }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChromeSafariBrowser Example'),
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
      initialFile: 'assets/index.html',
      // initialUrlRequest: URLRequest(
      //   url: Uri.parse(Uri.dataFromString(
      //           '<html><body>hello world</body></html>',
      //           mimeType: 'text/html')
      //       .toString()),
      // ),
    );
  }

  Center _chrome() {
    return Center(
      child: ElevatedButton(
          onPressed: () async {
            try {
              await widget.browser.open(
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
