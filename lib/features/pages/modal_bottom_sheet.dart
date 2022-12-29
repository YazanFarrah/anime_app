import 'package:anime_app/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../widgets/pop_over.dart';

class SettingsModalSheet extends StatefulWidget {
  const SettingsModalSheet({super.key, required BuildContext context});

  @override
  State<SettingsModalSheet> createState() => _SettingsModalSheetState();
}

class _SettingsModalSheetState extends State<SettingsModalSheet> {
  @override
  Widget build(BuildContext context) {
    return settingsModalSheet(context);
  }

  String langauge = 'EN';

  List<String> postCategories = [
    'EN',
    'AR',
  ];

  settingsModalSheet(BuildContext context) {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Popover(
            child: Column(
              children: [
                _buildListItem(
                  context,
                  title: const Text('Dark Mode'),
                  leading: const Icon(Icons.sunny),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                    // dragStartBehavior: DragStartBehavior.start,
                  ),
                ),
                _buildListItem(
                  context,
                  title: const Text('Language'),
                  leading: const Icon(Icons.language),
                  trailing: Row(
                    children: [
                      const Text('EN'),
                      DropdownButton(
                        value: 'En',
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: postCategories.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            langauge = newValue!;
                          });
                        },
                      ),
                      const Text('AR'),
                    ],
                  ),
                ),
                _buildListItem(
                  context,
                  title: const Text('Log out'),
                  leading: const Icon(Icons.logout),
                  trailing: const CircleAvatar(
                      backgroundImage: NetworkImage(
                    'https://t3.ftcdn.net/jpg/01/67/26/42/240_F_167264239_MJTYeDoQEItDJqlhVV13VVdQ94ViScwe.jpg',
                  )),
                ),
                _buildListItem(
                  context,
                  title: const Text('About'),
                  leading: const Icon(Icons.info_outline),
                  trailing: Text('asdasd\nasdasd'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required Widget title,
    required Widget leading,
    required Widget trailing,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (leading != null) leading,
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: DefaultTextStyle(
                style: TextStyle(color: AppColors.textDark),
                child: title,
              ),
            ),
          const Spacer(),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
