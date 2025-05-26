import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_text_field_widget.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/util/debouncer.dart';
import 'package:tzwad_mobile/features/product/ui/search/providers/search_controller_provider.dart';

class SearchFieldWidget extends HookConsumerWidget {
  const SearchFieldWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final controller = useSearchFieldController(
    //   ref: ref,
    //   initialText: '',
    // );
    final categoryId = ref.watch(
      searchControllerProvider.select(
        (state) => state.categoryId,
      ),
    );

    final minPrice = ref.watch(
      searchControllerProvider.select(
        (state) => state.minPrice,
      ),
    );
    final maxPrice = ref.watch(
      searchControllerProvider.select(
        (state) => state.maxPrice,
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: AppTextFieldWidget(
        // controller: controller,
        hintText: 'What are you looking for?',
        onChanged: (value) {
          Debouncer().run(() {
            ref.read(searchControllerProvider.notifier).filterProducts(
                  search: value,
                  categoryId: categoryId,
                  minPrice: minPrice,
                  maxPrice: maxPrice,
                );
          });
        },
      ),
    );
  }
}
