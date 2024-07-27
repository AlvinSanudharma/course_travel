import 'package:course_travel/api/urls.dart';
import 'package:course_travel/features/destination/presentation/widgets/circle_loading.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GalleryPhoto extends StatelessWidget {
  const GalleryPhoto({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return Stack(
      children: [
        PhotoViewGallery.builder(
          itemCount: images.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
                imageProvider: ExtendedNetworkImageProvider(
                  URLs.image(
                    images[index],
                  ),
                ),
                initialScale: PhotoViewComputedScale.contained * 0.8,
                heroAttributes: PhotoViewHeroAttributes(tag: images[index]));
          },
          loadingBuilder: (context, event) {
            return const CircleLoading();
          },
          pageController: pageController,
          scrollPhysics: const BouncingScrollPhysics(),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: images.length,
                effect: WormEffect(
                    dotColor: Colors.grey[300]!,
                    activeDotColor: Theme.of(context).primaryColor,
                    dotHeight: 10,
                    dotWidth: 10),
              ),
            )),
        const Align(alignment: Alignment.topRight, child: CloseButton())
      ],
    );
  }
}
