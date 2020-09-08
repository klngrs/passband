import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:harpy/components/common/dialogs/harpy_dialog.dart';
import 'package:harpy/components/common/misc/flare_icons.dart';
import 'package:harpy/core/message_service.dart';
import 'package:harpy/core/service_locator.dart';

/// A dialog used to inform about a feature being only available for the pro
/// version of harpy.
class ProDialog extends StatefulWidget {
  const ProDialog({
    this.feature,
  });

  /// The name of the pro only feature.
  final String feature;

  @override
  _ProDialogState createState() => _ProDialogState();
}

class _ProDialogState extends State<ProDialog> {
  GestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();

    // todo: link to harpy pro
    // todo: add harpy pro analytics
    _recognizer = TapGestureRecognizer()
      ..onTap = () => app<MessageService>().showInfo('Not yet available');
  }

  @override
  void dispose() {
    _recognizer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final TextStyle style = theme.textTheme.subtitle2;
    final TextStyle linkStyle = style.copyWith(
      color: theme.accentColor,
      fontWeight: FontWeight.bold,
    );

    return HarpyDialog(
      title: const Text('Harpy Pro'),
      content: Column(
        children: <Widget>[
          const FlareIcon.shiningStar(size: 64),
          const SizedBox(height: 16),
          if (widget.feature != null) ...<Widget>[
            Text(
              '${widget.feature} is only available in the '
              'pro version for Harpy.',
              style: style,
            ),
            const SizedBox(height: 16),
          ],
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                const TextSpan(text: 'Buy Harpy Pro in the '),
                TextSpan(
                  text: 'Play Store',
                  style: linkStyle,
                  recognizer: _recognizer,
                ),
              ],
              style: style,
            ),
          ),
        ],
      ),
      actions: const <DialogAction<dynamic>>[
        DialogAction<bool>(
          result: true,
          text: 'Try it out',
        ),
      ],
    );
  }
}
