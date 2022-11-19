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

  showCustomDialog(String title, String content) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            height: 300,
            child: Column(
              children: [
                Text(content),
                ElevatedButton(
                    onPressed: () {
                      pop();
                    },
                    child: Text('Close'))
              ],
            ),
          ),
        );
      },
    );
  }
}
