import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:poruch/screens/screens.dart';
import 'package:poruch/widgets/widgets.dart';

class TestModeLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/*'];

  TestModeLocation(super.routeInformation);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('testMode'),
          type: BeamPageType.noTransition,
          child: TestModeScreen(),
        ),
        if (state.pathPatternSegments.contains('map'))
          const BeamPage(
            key: ValueKey('testMode/map'),
            child: MapScreen(),
          )
      ];
}

class AlarmButtonLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/*'];

  AlarmButtonLocation(super.routeInformation);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('alarmButton'),
          type: BeamPageType.noTransition,
          child: AlarmButtonScreen(),
        ),
      ];
}

class MoreLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/*'];

  MoreLocation(super.routeInformation);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
         BeamPage(
          key: const ValueKey('more'),
          type: BeamPageType.noTransition,
          child: MoreScreen(),
        ),
        if (state.pathPatternSegments.contains('add_trinket'))
          BeamPage(
            key: const ValueKey('more/add_trinket'),
            child: AddTrinketScreen(),
          )
        else if (state.pathPatternSegments.contains('profile'))
          const BeamPage(
            key: ValueKey('more/profile'),
            child: ProfileScreen(),
          )
        else if (state.pathPatternSegments.contains('subscribtion'))
          const BeamPage(
            key: ValueKey('more/subscribtion'),
            child: SubscribtionScreen(),
          )
        else if (state.pathPatternSegments.contains('notifications'))
          const BeamPage(
            key: ValueKey('more/notifications'),
            child: NotificationsScreen(),
          )
        else if (state.pathPatternSegments.contains('wallet'))
          const BeamPage(
            key: ValueKey('more/subscribtion'),
            child: WalletScreen(),
          )
      ];
}

/// The details screen for either the A or B screen.
class DetailsScreen extends StatefulWidget {
  /// The label to display in the center of the screen.
  final String label;

  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

/// For test! The state for DetailsScreen
class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        withBackButton: true,
        title: 'Додати брелок',
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Details for ${widget.label} - Counter: $_counter',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment counter'),
            ),
          ],
        ),
      ),
    );
  }
}
