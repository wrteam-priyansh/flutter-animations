import 'package:flutter/material.dart';

double categoryHeight = 50;
double itemHeight = 100;

class MenuAnimationScreen extends StatefulWidget {
  const MenuAnimationScreen({super.key});

  @override
  State<MenuAnimationScreen> createState() => _MenuAnimationScreenState();
}

class _MenuAnimationScreenState extends State<MenuAnimationScreen>
    with TickerProviderStateMixin {
  GlobalKey burgerLastItemGlobalKey = GlobalKey();
  GlobalKey pizzaLastItemGlobalKey = GlobalKey();

  bool burgerCategoryPinned = true;
  late final AnimationController animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 150));

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget _buildCategoryContainer(
      {required String categoryName, required bool pinned}) {
    return SliverPersistentHeader(
        pinned: pinned,
        delegate:
            CategorySliverPersistentHeaderDelegate(categoryName: categoryName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () async {

      // }),
      body: NotificationListener(
        onNotification: (notification) {
          final renderBox = burgerLastItemGlobalKey.currentContext
              ?.findRenderObject() as RenderBox?;
          final offset = renderBox?.localToGlobal(Offset.zero);

          if (offset != null) {
            final renderBox = burgerLastItemGlobalKey.currentContext
                ?.findRenderObject() as RenderBox?;
            final offset = renderBox?.localToGlobal(Offset.zero);

            if (offset != null) {
              final distance = (offset.dy -
                  kToolbarHeight -
                  MediaQuery.of(context).padding.top -
                  itemHeight);

              if (distance < 0) {
                //If it is already pinned
                if (burgerCategoryPinned) {
                  setState(() {
                    print("Chagne it to ");
                    burgerCategoryPinned = false;
                  });
                }
              }
            }
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),
            AnimatedBuilder(
                animation: animationController,
                builder: (context, _) {
                  return _buildCategoryContainer(
                      categoryName: "Burgers", pinned: burgerCategoryPinned);
                }),
            SliverList.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Container(
                    key: index == 14 ? burgerLastItemGlobalKey : null,
                    decoration: BoxDecoration(border: Border.all()),
                    height: itemHeight,
                    child: ListTile(
                      title: Text("Index $index"),
                    ),
                  );
                }),
            _buildCategoryContainer(categoryName: "Pizza", pinned: true),
            SliverList.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Container(
                    key: index == 14 ? pizzaLastItemGlobalKey : null,
                    decoration: BoxDecoration(border: Border.all()),
                    height: itemHeight,
                    child: ListTile(
                      title: Text("Index $index"),
                    ),
                  );
                }),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategorySliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final String categoryName;

  CategorySliverPersistentHeaderDelegate({required this.categoryName});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: categoryHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      alignment: Alignment.center,
      child: Text(categoryName),
    );
  }

  @override
  double get maxExtent => categoryHeight;

  @override
  double get minExtent => categoryHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
