import 'package:flutter/material.dart';

/// Shows a fluid bottom sheet that expands with smooth animations
///
/// The sheet animates its padding and border radius as it expands to full screen.
/// It can be dismissed by dragging down the pill indicator or by pulling down
/// when the content is scrolled to the top.
///
/// Example:
/// ```dart
/// showFluidSheet(
///   context: context,
///   builder: (context) => YourContentWidget(),
///   backgroundColor: Colors.white,
///   useSafeArea: true, // Respects safe area (camera, dynamic island)
/// );
/// ```
Future<T?> showFluidSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  double initialHeight = 0.5,
  double maxHeight = 1.0,
  Color backgroundColor = Colors.white,
  Color barrierColor = Colors.black54,
  bool barrierDismissible = true,
  bool showPillIndicator = true,
  Color? pillIndicatorColor,
  bool useSafeArea = false,
}) async {
  return Navigator.of(context).push<T>(
    _FluidSheetRoute<T>(
      builder: builder,
      initialHeight: initialHeight,
      maxHeight: maxHeight,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      showPillIndicator: showPillIndicator,
      pillIndicatorColor: pillIndicatorColor,
      useSafeArea: useSafeArea,
    ),
  );
}

class _FluidSheetRoute<T> extends PopupRoute<T> {
  final Widget Function(BuildContext) builder;
  final double initialHeight;
  final double maxHeight;
  final Color backgroundColor;
  final Color _barrierColor;
  final bool _barrierDismissible;
  final bool showPillIndicator;
  final Color? pillIndicatorColor;
  final bool useSafeArea;

  _FluidSheetRoute({
    required this.builder,
    required this.initialHeight,
    required this.maxHeight,
    required this.backgroundColor,
    required Color barrierColor,
    required bool barrierDismissible,
    required this.showPillIndicator,
    required this.pillIndicatorColor,
    required this.useSafeArea,
  }) : _barrierColor = barrierColor,
       _barrierDismissible = barrierDismissible;

  @override
  Color? get barrierColor => _barrierColor;

  @override
  bool get barrierDismissible => _barrierDismissible;

  @override
  String? get barrierLabel => 'Dismiss';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);

  @override
  Curve get barrierCurve => Curves.easeOut;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return _FluidSheet(
      builder: builder,
      initialHeight: initialHeight,
      maxHeight: maxHeight,
      backgroundColor: backgroundColor,
      animation: animation,
      showPillIndicator: showPillIndicator,
      pillIndicatorColor: pillIndicatorColor,
      useSafeArea: useSafeArea,
    );
  }
}

class _FluidSheet extends StatefulWidget {
  final Widget Function(BuildContext) builder;
  final double initialHeight;
  final double maxHeight;
  final Color backgroundColor;
  final Animation<double> animation;
  final bool showPillIndicator;
  final Color? pillIndicatorColor;
  final bool useSafeArea;

  const _FluidSheet({
    required this.builder,
    required this.initialHeight,
    required this.maxHeight,
    required this.backgroundColor,
    required this.animation,
    required this.showPillIndicator,
    required this.pillIndicatorColor,
    required this.useSafeArea,
  });

  @override
  _FluidSheetState createState() => _FluidSheetState();
}

class _FluidSheetState extends State<_FluidSheet> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController; // Internal controller for fluid effects

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isDismissing = false;

  void _dismiss() async {
    if (_isDismissing) return;
    _isDismissing = true;

    // Animate the sheet down before dismissing with smooth curve
    await _animationController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInCubic, // Smooth ease-in for dismiss
    );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([widget.animation, _animationController]),
      builder: (context, child) {
        final double rawProgress = _animationController.value;
        final double progress = Curves.easeInOutCubic.transform(rawProgress);

        final double rawSlideValue = widget.animation.value;
        final double slideValue = Curves.easeOutCubic.transform(rawSlideValue);

        final EdgeInsets padding = EdgeInsets.lerp(const EdgeInsets.fromLTRB(16, 0, 16, 16), EdgeInsets.zero, progress)!;

        final BorderRadius borderRadius = BorderRadius.lerp(const BorderRadius.all(Radius.circular(16)), BorderRadius.zero, progress)!;

        final slideOffset = Offset(0.0, 1.0 - slideValue);

        return RepaintBoundary(
          child: Transform.translate(
            offset: slideOffset * MediaQuery.of(context).size.height,
            child: Padding(
              padding: padding,
              child: NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  final double newProgress = (notification.extent - widget.initialHeight) / (widget.maxHeight - widget.initialHeight);
                  final clampedProgress = newProgress.clamp(0.0, 1.0);
                  if (_animationController.value != clampedProgress) {
                    _animationController.value = clampedProgress;
                  }
                  return true;
                },
                child: DraggableScrollableSheet(
                  initialChildSize: widget.initialHeight,
                  minChildSize: widget.initialHeight,
                  maxChildSize: widget.maxHeight,
                  builder: (BuildContext context, ScrollController scrollController) {
                    final sheetContent = Material(
                      type: MaterialType.canvas,
                      color: widget.backgroundColor,
                      elevation: 0,
                      child: Column(
                        children: [
                          if (widget.showPillIndicator)
                            // Draggable pill indicator - can be dragged down to dismiss
                            GestureDetector(
                              onVerticalDragUpdate: (details) {
                                // Only allow drag down when at initial position and scroll is at top
                                if (scrollController.hasClients && scrollController.offset <= 0 && details.delta.dy > 0) {
                                  // User is dragging down, trigger dismiss
                                  _dismiss();
                                }
                              },
                              child: Container(
                                color: Colors.transparent, // Make the whole area tappable
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Center(
                                    child: Container(
                                      width: 40,
                                      height: 4,
                                      decoration: BoxDecoration(color: widget.pillIndicatorColor ?? Colors.grey[600], borderRadius: BorderRadius.circular(2)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Expanded(
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                // Detect overscroll at the top (when content is scrolled all the way up)
                                if (notification is OverscrollNotification) {
                                  if (scrollController.offset <= 0 && notification.overscroll < 0) {
                                    // User is trying to scroll down when already at top
                                    _dismiss();
                                    return true;
                                  }
                                }
                                return false;
                              },
                              child: SingleChildScrollView(
                                controller: scrollController, // Pass the scroll controller
                                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                child: RepaintBoundary(
                                  child: widget.builder(context), // The actual content of the sheet
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                    // Wrap with ClipRRect and optionally SafeArea
                    return ClipRRect(
                      borderRadius: borderRadius,
                      child: widget.useSafeArea
                          ? SafeArea(
                              bottom: false, // Don't add padding at bottom
                              child: sheetContent,
                            )
                          : sheetContent,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
