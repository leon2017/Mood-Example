import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

///
import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';

class UniMPMiniappsPage extends StatefulWidget {
  const UniMPMiniappsPage({super.key});

  @override
  State<UniMPMiniappsPage> createState() => _UniMPMiniappsPageState();
}

class _UniMPMiniappsPageState extends State<UniMPMiniappsPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF6F8FA),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
          title: const Text("uniapp 小程序"),
          leading: ActionButton(
            decoration: BoxDecoration(
                color: AppTheme.backgroundColor1,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(18.w))),
            child: Icon(
              Remix.arrow_left_line,
              size: 24.sp,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: const SafeArea(
          child: UniMPMiniappsBody(),
        ),
      ),
    );
  }
}

class UniMPMiniappsBody extends StatefulWidget {
  const UniMPMiniappsBody({super.key});

  @override
  State<UniMPMiniappsBody> createState() => _UniMPMiniappsBodyState();
}

class _UniMPMiniappsBodyState extends State<UniMPMiniappsBody> {
  @override
  Widget build(BuildContext context) {
    // 创建渠道与原生沟通
    const channel = MethodChannel("UniMP_mini_apps");

    Future callNativeMethod(String appID) async {
      try {
        // 通过渠道，调用原生代码代码的方法
        final future = await channel.invokeMethod("open", {"AppID": appID});
        // 打印执行的结果
        debugPrint(future.toString());
      } on PlatformException catch (e) {
        debugPrint(e.toString());
      }
    }

    return ListView(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 24.w,
        bottom: 20.h,
      ),
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        /// 版本
        Padding(
          padding: EdgeInsets.only(bottom: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("UniMPSDK_Android 版本：3.4.7.V2.20220425"),
              Text("UniMPSDK_iOS 版本：3.4.7"),
              Text("HBuilderX 版本：3.4.7"),
            ],
          ),
        ),

        /// 小程序
        ListCard(
          leading: Icon(
            Remix.mini_program_fill,
            size: 32.sp,
            color: Colors.black87,
          ),
          title: "uView",
          subtitle: "uView UI，是 uni-app 生态优秀的 UI 框架，全面的组件和便捷的工具会让您信手拈来，如鱼得水",
          onPressed: () async {
            await callNativeMethod("__UNI__F87B0CE");
          },
        ),
        ListCard(
          leading: Icon(
            Remix.mini_program_fill,
            size: 32.sp,
            color: Colors.black87,
          ),
          title: "hello-uniapp",
          subtitle: "演示 uni-app 框架的组件、接口、模板等",
          onPressed: () async {
            await callNativeMethod("__UNI__3BC70CE");
          },
        ),
      ],
    );
  }
}

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leading,
    this.onPressed,
  });

  /// 标题
  final String title;

  /// 描述
  final String subtitle;

  /// 图标
  final Widget leading;

  /// 点击打开触发
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12.w),
      shadowColor: Colors.black38,
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(48.sp)),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          children: [
            ListTile(
              leading: leading,
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onPressed,
                  child: const Text('打开'),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
