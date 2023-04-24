import 'package:flutter/material.dart';

class MdScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  const MdScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: appBar,
          body: SafeArea(
            child: body,
          ),
          drawer: drawer,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
        ),
      );
}

/// 页面主体Column，包含SafeArea，Padding，ScrollView等配置
class MdMainColumn extends StatelessWidget {
  final List<Widget> main;
  final List<Widget> bottom;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsetsGeometry padding;
  final ScrollController? controller;
  final bool scroll;
  final MainAxisSize mainAxisSize;
  final bool safeTop;

  const MdMainColumn({
    Key? key,
    List<Widget>? main,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.padding = const EdgeInsets.all(8),
    this.bottom = const [],
    List<Widget> children = const [],
    this.controller,
    this.scroll = true,
    this.safeTop = true,
  })  : assert(
            !(main != null && children.length != 0), "main 与 children 不能同时有值"),
        main = main ?? children,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = scroll ? (this.controller ?? ScrollController()) : null;
    return SafeArea(
      top: safeTop,
      child: Padding(
          padding: padding,
          child: bottom.isEmpty
              ? _buildColumn(context, controller)
              : Column(
                  mainAxisSize: mainAxisSize,
                  children: [
                    Expanded(child: _buildColumn(context, controller)),
                    ...bottom,
                  ],
                )),
    );
  }

  _buildColumn(BuildContext context, [ScrollController? controller]) {
    final col = Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: main,
    );
    return controller == null
        ? col
        : SingleChildScrollView(controller: controller, child: col);
  }
}
