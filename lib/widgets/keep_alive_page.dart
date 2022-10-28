import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeepAlivePage extends StatefulWidget {
  KeepAlivePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ThemeProvider>(context, listen: false);
    // provider.getThemeLocal();
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}