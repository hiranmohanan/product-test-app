import 'package:flutter/material.dart';
import 'package:product_app/view/home/widget.dart';

import '../../widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.logout),
      //       onPressed: () {
      //         looutbuttonfn(context);
      //       },
      //     )
      //   ],
      // ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: true,
            pinned: false,
            title: const Text('Home'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  looutbuttonfn(context);
                },
              )
            ],
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          const SliverToBoxAdapter(
            child: Center(
              child: Text('Welcome to Home'),
            ),
          ),
          SliverList.builder(
              addAutomaticKeepAlives: true,
              itemCount: 19,
              itemBuilder: (context, index) {
                return const Center(child: ProductCard());
              }),
        ],
      ),
    );
  }
}
