import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/providers/products_supplier_controller_provider.dart';
import '../../../../../../core/resource/font_manager.dart';
import '../../../../../../core/resource/values_manager.dart';


class SearchBackRow extends ConsumerWidget {
  const SearchBackRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearchVisible = ref.watch(isSearchVisibleProvider);
    final searchQuery = ref.watch(supplierSearchQueryProvider);
    final searchController = TextEditingController(text: searchQuery);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: ColorManager.colorWhite3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Image(image: AssetImage("assets/icons/ic_arrow.png")),
                ),
                const SizedBox(width: AppPadding.p8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "المنتجات",
                      style: StyleManager.getBoldStyle(
                        color: Colors.white,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    Text(
                      "منتجات الألبان",
                      style: StyleManager.getRegularStyle(
                        color: ColorManager.colorWhite3,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ],
                )
              ],
            ),
            InkWell(
              onTap: () {
                if (isSearchVisible) {
                  ref.read(supplierSearchQueryProvider.notifier).state = '';
                }
                ref.read(isSearchVisibleProvider.notifier).state = !isSearchVisible;
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isSearchVisible
                    ? const Icon(Icons.clear, color: Colors.white)
                    : Image.asset(
                  "assets/icons/ic_search.png",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        if (!isSearchVisible) const SizedBox(height:14,),
        if (isSearchVisible)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: TextField(
              onChanged: (val) => ref
                  .read(supplierSearchQueryProvider.notifier)
                  .state = val,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "بحث....",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
