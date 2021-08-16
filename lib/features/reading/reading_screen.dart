import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../core/widgets/custom_bloc_widgets.dart';
import '../../models/master/chapter_master_model.dart';
import '../../models/master/manga_master_model.dart';
import 'cubit/reading_cubit.dart';

class ReadingScreen extends StatelessWidget {
  final MangaMasterModel manga;
  final int chapterIndex;

  const ReadingScreen({
    Key? key,
    required this.manga,
    required this.chapterIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MProvider<ReadingCubit>(
      create: (context) =>
          ReadingCubit(manga: manga, chapterIndex: chapterIndex)..init(),
      builder: (context) {
        final readingCubit = context.read<ReadingCubit>();

        return Scaffold(
          appBar: AppBar(
            title: const Text("Reader"),
          ),
          body: MSelector<ReadingCubit, int>(
            selector: (cubit) => cubit.chapterIndex,
            builder: (context, chapterIndex) {
              final pages = readingCubit.currentChapter.pages;

              return PageView.builder(
                controller: readingCubit.pageController,
                itemCount: pages.length + 4,
                itemBuilder: (context, index) {
                  final int pageIndex = index - 2;

                  if (pages.length <= pageIndex || pageIndex < 0) {
                    final isNext = !(pageIndex < 0);
                    final otherChapter = readingCubit
                        .manga.chapters[chapterIndex + (isNext ? 1 : -1)];
                    return _TransitionMediatorPage(
                      isNext: isNext,
                      otherChapter: otherChapter,
                      currentChapter: readingCubit.currentChapter,
                    );
                  }

                  return _MangaPageView(
                    url: pages[pageIndex],
                    page: pageIndex,
                  );
                },
                onPageChanged: (index) {
                  final int pageIndex = index - 2;

                  if (pages.length < pageIndex && readingCubit.hasNext) {
                    readingCubit.nextChapter();
                  } else if (pageIndex == -2 && readingCubit.hasPrevious) {
                    readingCubit.previousChapter();
                  } else {
                    precacheImage(
                        CachedNetworkImageProvider(pages[pageIndex + 1]),
                        context);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _MangaPageView extends StatelessWidget {
  final String url;
  final int page;
  const _MangaPageView({Key? key, required this.url, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoView(
          backgroundDecoration: const BoxDecoration(color: Colors.white),
          imageProvider: CachedNetworkImageProvider(url),
          loadingBuilder: (context, event) {
            return Center(
              child: CircularProgressIndicator(
                value: (event?.cumulativeBytesLoaded ?? 0) /
                    (event?.expectedTotalBytes ?? 1),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(5),
            color: Colors.white,
            child: Text(page.toString()),
          ),
        )
      ],
    );
  }
}

class _TransitionMediatorPage extends StatelessWidget {
  final ChapterMasterModel currentChapter;
  final ChapterMasterModel otherChapter;
  final bool isNext;

  const _TransitionMediatorPage(
      {Key? key,
      required this.currentChapter,
      required this.otherChapter,
      required this.isNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Current chapter: ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "${currentChapter.title} chapter ${currentChapter.chapter}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            "${isNext ? "Next" : "Previous"} chapter:",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "${otherChapter.title} chapter ${otherChapter.chapter}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
