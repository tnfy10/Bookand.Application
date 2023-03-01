import 'package:bookand/core/widget/base_app_bar.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/component/drawer_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/app_strings.dart';

class NoticeScreen extends StatefulWidget {
  static String get routeName => 'noticeScreen';

  const NoticeScreen({Key? key}) : super(key: key);

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  final tempList = [false, false, false, false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBar: const BaseAppBar(title: AppStrings.notice),
      child: Scrollbar(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return DrawerListTile(
              value: tempList[index],
              onChanged: (value) {
                setState(() {
                  tempList[index] = value;
                });
              },
              title: const Text(
                '가나다라마바사아자차카타파하가나다라마바사아자',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  letterSpacing: -0.02,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subTitle: Text(
                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                style: const TextStyle(
                  color: Color(0xFFACACAC),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  letterSpacing: -0.02,
                ),
              ),
              trailing: SvgPicture.asset(
                tempList[index]
                    ? 'assets/images/my/ic_drawer_close.svg'
                    : 'assets/images/my/ic_drawer_open.svg',
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              drawerBackground: const Color(0xFFF5F5F7),
              child: const Markdown(
                data:
                    '가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하',
              ),
            );
          },
          separatorBuilder: (_, __) => const Divider(
            height: 0,
            thickness: 2,
            color: Color(0xFFF5F5F7),
          ),
          itemCount: tempList.length,
        ),
      ),
    );
  }
}
