import 'package:flutter/material.dart';
import 'package:sastra_ebooks/profile/settingScreens/credits.dart';

class CustomAboutDialog extends StatelessWidget {
  /// Creates an about box.
  ///
  /// The arguments are all optional. The application name, if omitted, will be
  /// derived from the nearest [Title] widget. The version, icon, and legalese
  /// values default to the empty string.
  const CustomAboutDialog({
    Key key,
    this.applicationName,
    this.applicationVersion,
    this.applicationIcon,
    this.applicationLegalese,
    this.children,
  }) : super(key: key);

  /// The name of the application.
  ///
  /// Defaults to the value of [Title.title], if a [Title] widget can be found.
  /// Otherwise, defaults to [Platform.resolvedExecutable].
  final String applicationName;

  /// The version of this build of the application.
  ///
  /// This string is shown under the application name.
  ///
  /// Defaults to the empty string.
  final String applicationVersion;

  /// The icon to show next to the application name.
  ///
  /// By default no icon is shown.
  ///
  /// Typically this will be an [ImageIcon] widget. It should honor the
  /// [IconTheme]'s [IconThemeData.size].
  final Widget applicationIcon;

  /// A string to show in small print.
  ///
  /// Typically this is a copyright notice.
  ///
  /// Defaults to the empty string.
  final String applicationLegalese;

  /// Widgets to add to the dialog box after the name, version, and legalese.
  ///
  /// This could include a link to a Web site, some descriptive text, credits,
  /// or other information to show in the about box.
  ///
  /// Defaults to nothing.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final String name = applicationName;
    final String version = applicationVersion;
    final Widget icon = applicationIcon;
    return AlertDialog(
      content: ListBody(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (icon != null)
                IconTheme(data: Theme.of(context).iconTheme, child: icon),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListBody(
                    children: <Widget>[
                      Text(name, style: Theme.of(context).textTheme.headline5),
                      Text(version,
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(height: 18),
                      Text(applicationLegalese ?? '',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ...?children,
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CREDITS'),
          onPressed: () {
            Navigator.pushNamed(context, Credits.id);
          },
        ),
        FlatButton(
          child:
              Text(MaterialLocalizations.of(context).viewLicensesButtonLabel),
          onPressed: () {
            showLicensePage(
              context: context,
              applicationName: applicationName,
              applicationVersion: applicationVersion,
              applicationIcon: applicationIcon,
              applicationLegalese: applicationLegalese,
            );
          },
        ),
        FlatButton(
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      scrollable: true,
    );
  }
}
