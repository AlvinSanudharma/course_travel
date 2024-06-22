import 'package:course_travel/features/destination/presentation/bloc/top_destination/top_destination_bloc.dart';
import 'package:course_travel/features/destination/presentation/widgets/circle_loading.dart';
import 'package:course_travel/features/destination/presentation/widgets/text_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final topDestinationController = PageController();

  refresh() {
    context.read<TopDestinationBloc>().add(OnGetTopDestination());
  }

  @override
  void initState() {
    refresh();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async => refresh(),
      child: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          header(),
          const SizedBox(
            height: 20,
          ),
          search(),
          const SizedBox(
            height: 24,
          ),
          categories(),
          const SizedBox(
            height: 20,
          ),
          topDestination()
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(
                'assets/images/profile.png',
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'Hi, Dre!',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Spacer(),
          const Badge(
              backgroundColor: Colors.red,
              alignment: Alignment(0.6, -0.6),
              child: Icon(
                Icons.notifications_none,
              ))
        ],
      ),
    );
  }

  Widget search() {
    return Container(
      padding: const EdgeInsets.only(left: 24),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          const Expanded(
              child: TextField(
            decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Search destination here... ',
                hintStyle:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
                contentPadding: EdgeInsets.all(0)),
          )),
          const SizedBox(
            width: 10,
          ),
          IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 24,
              ))
        ],
      ),
    );
  }

  Widget categories() {
    List list = ['Beach', 'Lake', 'Mountain', 'Forest', 'City'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          list.length,
          (index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? 30 : 10,
                  right: index == list.length - 1 ? 30 : 10,
                  bottom: 10,
                  top: 4),
              child: Material(
                elevation: 4,
                color: Colors.white,
                shadowColor: Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  child: Text(
                    list[index],
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  topDestination() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top Destination',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              BlocBuilder<TopDestinationBloc, TopDestinationState>(
                builder: (context, state) {
                  if (state is TopDestinationLoaded) {
                    return SmoothPageIndicator(
                      controller: topDestinationController,
                      count: state.data.length,
                      effect: WormEffect(
                          dotColor: Colors.grey[300]!,
                          activeDotColor: Theme.of(context).primaryColor,
                          dotHeight: 10,
                          dotWidth: 10),
                    );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<TopDestinationBloc, TopDestinationState>(
          builder: (context, state) {
            if (state is TopDestinationLoading) {
              return const CircleLoading();
            }

            if (state is TopDestinationFailure) {
              return TextFailure(message: state.message);
            }

            if (state is TopDestinationLoaded) {}

            return const SizedBox(
              height: 120,
            );
          },
        )
      ],
    );
  }
}
