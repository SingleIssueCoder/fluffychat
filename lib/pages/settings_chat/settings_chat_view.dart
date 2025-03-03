import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';

import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/config/setting_keys.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/utils/voip/callkeep_manager.dart';
import 'package:fluffychat/widgets/layouts/max_width_body.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:fluffychat/widgets/settings_switch_list_tile.dart';
import 'settings_chat.dart';

class SettingsChatView extends StatelessWidget {
  final SettingsChatController controller;
  const SettingsChatView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(L10n.of(context)!.chat)),
      body: ListTileTheme(
        iconColor: Theme.of(context).textTheme.bodyLarge!.color,
        child: MaxWidthBody(
          child: Column(
            children: [
              ListTile(
                title: Text(L10n.of(context)!.emoteSettings),
                onTap: () => context.go('/rooms/settings/chat/emotes'),
                trailing: const Icon(Icons.chevron_right_outlined),
                leading: const Icon(Icons.emoji_emotions_outlined),
              ),
              const Divider(),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.renderRichContent,
                onChanged: (b) => AppConfig.renderHtml = b,
                storeKey: SettingKeys.renderHtml,
                defaultValue: AppConfig.renderHtml,
              ),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.hideRedactedEvents,
                onChanged: (b) => AppConfig.hideRedactedEvents = b,
                storeKey: SettingKeys.hideRedactedEvents,
                defaultValue: AppConfig.hideRedactedEvents,
              ),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.hideUnknownEvents,
                onChanged: (b) => AppConfig.hideUnknownEvents = b,
                storeKey: SettingKeys.hideUnknownEvents,
                defaultValue: AppConfig.hideUnknownEvents,
              ),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.hideUnimportantStateEvents,
                onChanged: (b) => AppConfig.hideUnimportantStateEvents = b,
                storeKey: SettingKeys.hideUnimportantStateEvents,
                defaultValue: AppConfig.hideUnimportantStateEvents,
              ),
              if (PlatformInfos.isMobile)
                SettingsSwitchListTile.adaptive(
                  title: L10n.of(context)!.autoplayImages,
                  onChanged: (b) => AppConfig.autoplayImages = b,
                  storeKey: SettingKeys.autoplayImages,
                  defaultValue: AppConfig.autoplayImages,
                ),
              SettingsSwitchListTile.adaptive(
                storeKey: SettingKeys.playMessageNotificationSound, 
                title: "Play message arrived sound",
                onChanged: (b) => AppConfig.playMessageNotificationSound = b,
                defaultValue: AppConfig.playMessageNotificationSound,
              ),
              const Divider(),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.sendTypingNotifications,
                onChanged: (b) => AppConfig.sendTypingNotifications = b,
                storeKey: SettingKeys.sendTypingNotifications,
                defaultValue: AppConfig.sendTypingNotifications,
              ),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.sendOnEnter,
                onChanged: (b) => AppConfig.sendOnEnter = b,
                storeKey: SettingKeys.sendOnEnter,
                defaultValue: AppConfig.sendOnEnter ?? !PlatformInfos.isMobile,
              ),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.experimentalVideoCalls,
                onChanged: (b) {
                  AppConfig.experimentalVoip = b;
                  Matrix.of(context).createVoipPlugin();
                  return;
                },
                storeKey: SettingKeys.experimentalVoip,
                defaultValue: AppConfig.experimentalVoip,
              ),
              if (PlatformInfos.isMobile)
                ListTile(
                  title: Text(L10n.of(context)!.callingPermissions),
                  onTap: () =>
                      CallKeepManager().checkoutPhoneAccountSetting(context),
                  trailing: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.call),
                  ),
                ),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.separateChatTypes,
                onChanged: (b) => AppConfig.separateChatTypes = b,
                storeKey: SettingKeys.separateChatTypes,
                defaultValue: AppConfig.separateChatTypes,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
