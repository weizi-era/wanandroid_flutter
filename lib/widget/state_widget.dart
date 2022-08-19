import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/string.dart';

enum ViewState { loading, done, error }

class StateWidget extends StatelessWidget {
  final ViewState viewState;
  final VoidCallback retry;
  final Widget child;

  const StateWidget(
      {Key? key,
      this.viewState = ViewState.loading,
      required this.retry,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (viewState == ViewState.loading) {
      return _loadView;
    } else if (viewState == ViewState.error) {
      return _errorView;
    } else {
      return child;
    }
  }

  Widget get _loadView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget get _errorView {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/ic_error.png",
            width: 100,
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              MyString.netRequestFail,
              style: TextStyle(color: Colors.grey[350], fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: OutlinedButton(
              onPressed: () {},
              child: Text(
                MyString.reloadAgain,
                style: TextStyle(color: Colors.black87),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.black12)),
            ),
          )
        ],
      ),
    );
  }
}
