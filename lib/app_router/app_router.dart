import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();
  static AppRouter appRouter = AppRouter._();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  pushReplacement(Widget screen) {
    navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (notNeededContext) {
      return screen;
    }));
  }

  push(Widget screen) {
    navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (notNeededContext) {
      return screen;
    }));
  }

  pop() {
    navigatorKey.currentState!.pop();
  }

  bool canPop() {
    return navigatorKey.currentState!.canPop();
  }

  showNoteDialog(String title, Widget? content) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            ElevatedButton(
                onPressed: () {
                  pop();
                },
                child: Text('Close'))
          ],
        );
      },
    );
  }

  showConfirmDialog(String title, Widget? content, Function? onConfirm) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            ElevatedButton(
              onPressed: () {
                pop();
              },
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm!();
                pop();
              },
              child: Text('Confirm'),
            )
          ],
        );
      },
    );
  }
}
