import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../inhouse_app_ads.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({
    super.key,
    required this.state,
    required this.primaryColor,
  });

  final InAppAdsSupabaseModelResponse state;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Try out our other products",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: _AnimatedButton(
            duration: 2,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            statusBarColor: primaryColor,
          ),
          titleSpacing: 0,
          elevation: 0,
          excludeHeaderSemantics: true,
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.appName ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CarouselSlider.builder(
                itemCount: state.appImage?.length ?? 0,
                options: CarouselOptions(
                  height: 400,
                  autoPlay: true,
                  aspectRatio: 6.0,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.2,
                  viewportFraction: 0.6,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                itemBuilder: (context, index, realIdx) {
                  return Center(
                    child: GestureDetector(
                      onTap: () => _launchAppUrlLink(state),
                      child: CachedNetworkImage(
                        imageUrl: state.appImage?[index] ?? "",
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              _AnimatedButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => _launchAppUrlLink(state),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            elevation: 0,
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: const SizedBox(
                          width: double.maxFinite,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Let's Try",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Features that you will have..",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  state.appFeatures?.length ?? 0,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("• "),
                        Flexible(
                          child: Text(
                            state.appFeatures?[index] ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "No Thanks!",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchAppUrlLink(InAppAdsSupabaseModelResponse state) {
    Helper helper = Helper.instance;
    if (Platform.isAndroid) {
      helper.launchUrlInBrowser(state.androidLink ?? "");
    } else if (Platform.isIOS) {
      {
        helper.launchUrlInBrowser(
          state.iosLink ?? "",
        );
      }
    }
  }
}

class _AnimatedButton extends StatefulWidget {
  const _AnimatedButton({required this.child, this.duration = 1});

  final Widget child;
  final int duration;

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton> {
  late double opacityLevel;

  @override
  void initState() {
    super.initState();
    opacityLevel = 0.0;
    Timer(Duration(seconds: widget.duration), () {
      _changeOpacity();
    });
  }

  void _changeOpacity() {
    setState(() => opacityLevel = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacityLevel,
      duration: Duration(seconds: widget.duration),
      child: widget.child,
    );
  }
}
