import 'package:dim_sum_app/base/base.dart';
import 'package:dim_sum_app/data/model/item_setting_model.dart';
import 'package:dim_sum_app/data/services/auth.dart';
import 'package:dim_sum_app/generated/l10n.dart';
import 'package:dim_sum_app/page/page_export.dart';
import 'package:dim_sum_app/res/colors.dart';
import 'package:dim_sum_app/utils/constants.dart';
import 'package:dim_sum_app/utils/logs/logger.dart';
import 'package:dim_sum_app/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends BasePage {
  ProfilePage({Key? key}) : super(bloc: ProfileBloc());
  static const routeName = '/ProfilePage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfilePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> signOut() async {
    final SharedPreferences prefs = await _prefs;
    await Auth().signOut();
    prefs.clear();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, SplashPage.routeName);
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  List<ItemSettingsModel> getItemsListOne() {
    return [
      ItemSettingsModel(
          id: Constants.ITEM_MENU_INFO, title: S.current.info_user, image: ''),
      ItemSettingsModel(
          id: Constants.ITEM_MENU_SETTING, title: S.current.setting, image: '')
    ];
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil.getInstance().screenHeight,
        width: ScreenUtil.getInstance().screenWidth,
        padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenUtil.getInstance().getAdapterSize(35),
              ),
              Row(
                children: [
                  Text(
                    S.current.function,
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getAdapterSize(25),
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: (){
                      signOut();
                    },
                    onDoubleTap: (){},
                    child: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, LoginPage.routeName);
                  //   },
                  //   child: Text(
                  //     S.current.login,
                  //     style: TextStyle(
                  //       fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                  //       fontWeight: FontWeight.w400,
                  //       color: AppColor.colorWhiteDark,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: ScreenUtil.getInstance().getAdapterSize(20),
              ),
              _itemCard(getItemsListOne()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemCard(List<ItemSettingsModel> items) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return _itemFunctionWidget(
            text: items[index].title,
            imageXML: items[index].image,
            onTap: () {
              _onClickItem(items[index].id);
            });
      },
    );
  }

  Widget _itemFunctionWidget(
      {required String text,
      required String imageXML,
      required GestureTapCallback onTap,
      Color? textColor}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      color: Theme.of(context).cardTheme.color,
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(color: textColor),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _onClickItem(String id) {
    switch (id) {
      case Constants.ITEM_MENU_INFO:
        DebugLog.show('Click ITEM_MENU_HISTORY');
        Navigator.pushNamed(context, InfoPage.routeName);
        break;
      case Constants.ITEM_MENU_SETTING:
        DebugLog.show('Click ITEM_MENU_SETTING');
        Navigator.pushNamed(context, SettingPage.routeName);
        break;
      default:
        break;
    }
  }
}
