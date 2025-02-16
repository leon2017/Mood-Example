import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:provider/provider.dart';

///
import 'package:moodexample/db/preferences_db.dart';
import 'package:moodexample/config/language.dart';

///
import 'package:moodexample/view_models/application/application_view_model.dart';

/// 语言设置
class SettingLanguage extends StatefulWidget {
  const SettingLanguage({super.key});

  @override
  State<SettingLanguage> createState() => _SettingLanguageState();
}

class _SettingLanguageState extends State<SettingLanguage> {
  /// 语言列表
  static const _languageConfig = languageConfig;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        /// 跟随系统
        Selector<ApplicationViewModel, bool>(
          selector: (_, applicationViewModel) =>
              applicationViewModel.localeSystem,
          builder: (_, localeSystem, child) {
            ApplicationViewModel applicationViewModel =
                Provider.of<ApplicationViewModel>(context, listen: false);
            return RadioListTile(
              value: localeSystem,
              groupValue: true,
              title: Text(
                S.of(context).app_setting_language_system,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal),
              ),
              onChanged: (value) async {
                await PreferencesDB()
                    .setAppIsLocaleSystem(applicationViewModel, true);
              },
            );
          },
        ),

        /// 语言
        Consumer<ApplicationViewModel>(
          builder: (_, applicationViewModel, child) {
            return Column(
              children: List<Widget>.generate(_languageConfig.length, (index) {
                return RadioListTile(
                  value: _languageConfig[index]["locale"].toString(),
                  groupValue: !applicationViewModel.localeSystem
                      ? applicationViewModel.locale.toString()
                      : false,
                  title: Text(
                    _languageConfig[index]["language"].toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14.sp, fontWeight: FontWeight.normal),
                  ),
                  onChanged: (value) async {
                    await PreferencesDB()
                        .setAppLocale(applicationViewModel, value.toString());
                  },
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
