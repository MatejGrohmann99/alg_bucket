import 'package:fluent_ui/fluent_ui.dart';

OverlayEntry? _loadingIndicatorEntry;

class ProgressBarOverlay extends StatelessWidget {
  const ProgressBarOverlay({super.key});

  static void show(BuildContext context) {
    hide();
    _loadingIndicatorEntry = OverlayEntry(builder: (context) => const ProgressBarOverlay());
    Overlay.maybeOf(context)?.insert(_loadingIndicatorEntry!);
  }

  static void hide() {
    _loadingIndicatorEntry?.remove();
    _loadingIndicatorEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          const AbsorbPointer(
            child: AnimatedOpacity(
              opacity: 0.3,
              duration: Duration(milliseconds: 50),
              child: ColoredBox(
                color: Color(0x80000000),
                child: SizedBox.expand(),
              ),
            ),
          ),
          ContentDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: 20,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: const ProgressBar(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
