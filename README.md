# neteasecloud

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
```dart
  ErrorWidget.builder = (FlutterErrorDetails flutterDetails) {
    print("flutterDetails::" + flutterDetails.toString());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/flutter_error.gif", fit: BoxFit.cover),
          Text("Flutter 走神了", style: TextStyle(color: Colors.green, fontSize: 18)),
        ],
      ),
    );
  };
```
