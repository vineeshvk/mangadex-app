import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../core/widgets/custom_bloc_widgets.dart';
import '../../models/master/chapter_master_model.dart';
import '../../models/master/manga_master_model.dart';
import 'cubit/reading_cubit.dart';

class ReadingScreen extends StatelessWidget {
  final MangaMasterModel manga;
  final ChapterMasterModel initialChapter;

  const ReadingScreen({
    Key? key,
    required this.manga,
    required this.initialChapter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MProvider<ReadingCubit>(
      create: (context) =>
          ReadingCubit(manga: manga, currentChapter: initialChapter)..init(),
      builder: (context) {
        final readingCubit = context.read<ReadingCubit>();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: MSelector<ReadingCubit, String>(
              selector: (cubit) => cubit.currentChapter.title,
              builder: (context, value) => Text(value),
            ),
          ),
          body: MSelector<ReadingCubit, List<PagePresenter>>(
            selector: (cubit) => cubit.manga.chapterPresenter,
            builder: (context, chapterPresenter) {
              return PhotoViewGestureDetectorScope(
                axis: Axis.horizontal,
                child: PageView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: chapterPresenter.length,
                  controller: readingCubit.pageController,
                  itemBuilder: (context, index) {
                    final pagePresenter = chapterPresenter[index];

                    if (pagePresenter.isTitleCard) {
                      if (pagePresenter.isLastPage) {
                        return _LastPage(isBeginning: index == 0);
                      }

                      return _TransitionMediatorPage(
                        currentChapter: pagePresenter.chapterTitle!.first,
                        otherChapter: pagePresenter.chapterTitle!.last,
                        isNext: true,
                      );
                    }

                    return _MangaPageView(
                      url: pagePresenter.pageUrl ?? "",
                      page: pagePresenter.pageNumber,
                    );
                  },
                  onPageChanged: (index) {
                    readingCubit.onPageChange(index);
                    precacheImageList(chapterPresenter, index, context);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// `precacheImageList` is for precaching the images to a certain extent.
  /// The amount of precaching is configurable via `count` argument. The default value is `5`.
  void precacheImageList(
    List<PagePresenter> presenters,
    int page,
    BuildContext context, {
    int count = 5,
  }) {
    for (int i = page + 1; i <= (page + count) && i < presenters.length; i++) {
      final nextPageUrl = presenters[i].pageUrl;

      if (nextPageUrl != null) {
        precacheImage(
          CachedNetworkImageProvider(nextPageUrl),
          context,
        );
      }
    }
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
          minScale: PhotoViewComputedScale.contained,
          backgroundDecoration: const BoxDecoration(color: Colors.black),
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
            color: Colors.black,
            child: Text(
              page.toString(),
              style: const TextStyle(color: Colors.white),
            ),
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

class _LastPage extends StatelessWidget {
  final bool isBeginning;

  const _LastPage({Key? key, this.isBeginning = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isBeginning
                ? "This is the beginning of the manga"
                : "No more pages left in the manga",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
