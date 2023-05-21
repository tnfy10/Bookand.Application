import 'package:bookand/core/const/bookmark_type.dart';
import 'package:bookand/domain/model/bookmark/bookmark_model.dart';
import 'package:bookand/presentation/provider/bookmark/bookmark_edit_provider.dart';
import 'package:bookand/presentation/screen/main/bookmark/bookmark_style.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/content_components/bookmark_container.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/content_components/edit_sheet_button.dart';
import 'package:bookand/presentation/screen/main/home/article_screen.dart';
import 'package:bookand/presentation/screen/main/home/bookstore_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookmarkContents extends ConsumerWidget {
  final BookmarkType type;
  final List<BookmarkModel> bookmarkList;
  final ScrollController scrollController;
  const BookmarkContents(
      {Key? key,
      required this.type,
      required this.bookmarkList,
      required this.scrollController})
      : super(key: key);

  final TextStyle titleStyle =
      const TextStyle(fontSize: 18, color: Color(0xff222222));
  final TextStyle settingStyle = const TextStyle(
    fontSize: 12,
  );
  final TextStyle noContentDes = const TextStyle(
    fontSize: 14,
  );

  final Color grey = const Color(0xffacacac);

  final double noContentHeight = 180;
  final Size settingSize = const Size(56, 24);
  final double settingIconSize = 12;

  final Size warningSize = const Size(36, 36);

  final warningPath = 'assets/images/map/ic_warning.png';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool settingMode = ref.watch(bookmarkEditNotifierProvider);
    bool isEmpty = bookmarkList.isEmpty;
    // 테스트
    return isEmpty
        ? SizedBox(
            height: noContentHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  warningPath,
                  width: warningSize.width,
                  height: warningSize.height,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '북마크한 서점이 없어요',
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  '북마크 기능을 이용해\n나만의 리스트를 만들어보세요!',
                  textAlign: TextAlign.center,
                  style: noContentDes.copyWith(color: grey),
                ),
              ],
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: Padding(
              padding: pagePadding,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '모아보기',
                        style: titleStyle,
                      ),
                      EditSheetButton()
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      childAspectRatio: BookmarkContainer.size.width /
                          BookmarkContainer.size.height,
                      children: [
                        ...bookmarkList.map((e) {
                          return BookmarkContainer(
                            model: e,
                            settingMode: settingMode,
                            onTap: () {
                              context.goNamed(
                                  type == BookmarkType.article
                                      ? ArticleScreen.routeName
                                      : BookstoreScreen.routeName,
                                  params: {'id': e.bookmarkId!.toString()});
                            },
                          );
                        }).toList()
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
