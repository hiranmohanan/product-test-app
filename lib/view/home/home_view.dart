import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/bloc/product/product_bloc.dart';
import 'package:product_app/view/home/widget.dart';

import '../../model/product_model.dart';
import '../../widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(Productget('all'));
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            context.read<ProductBloc>().add(Productget('all'));
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
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
                  height: 30,
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SerachBox(),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 30,
                ),
              ),
              BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  // Navigator.of(context, rootNavigator: true).pop();
                  if (state is ProductFailure) {
                    showsnackbar(error: state.error, context: context);
                  }
                },
                builder: (context, state) {
                  if (state is ProductSuccess) {
                    if (state.products.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Text('No Products Found'),
                        ),
                      );
                    }
                    return SliverList.builder(
                        addAutomaticKeepAlives: true,
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return Center(
                              child: ProductCard(
                            pmodel: ProductModel(
                              name: state.products[index].name,
                              price: state.products[index].price,
                              quantity: state.products[index].quantity,
                              measurement: state.products[index].measurement,
                            ),
                          ));
                        });
                  } else if (state is ProductLoading) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('No Products Found'),
                    ),
                  );
                },
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (_) => const ProductAddSheet());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
