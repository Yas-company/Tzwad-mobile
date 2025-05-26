import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/util/constants.dart';
import 'package:tzwad_mobile/features/product/ui/search/providers/search_controller_provider.dart';

class FilterProductsBottomSheet extends StatefulWidget {
  const FilterProductsBottomSheet({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  static void show(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) => FilterProductsBottomSheet(ref: ref),
    );
  }

  @override
  State<FilterProductsBottomSheet> createState() => _FilterProductsBottomSheetState();
}

class _FilterProductsBottomSheetState extends State<FilterProductsBottomSheet> {
  int? categoryId;
  String? search;
  late RangeValues currentRangeValues;

  @override
  void initState() {
    super.initState();
    final minPrice = widget.ref.read(
      searchControllerProvider.select(
        (state) => state.minPrice,
      ),
    );
    final maxPrice = widget.ref.read(
      searchControllerProvider.select(
        (state) => state.maxPrice,
      ),
    );

    categoryId = widget.ref.read(
      searchControllerProvider.select(
        (state) => state.categoryId,
      ),
    );

    search = widget.ref.read(
      searchControllerProvider.select(
        (state) => state.search,
      ),
    );

    currentRangeValues = RangeValues(
      minPrice?.toDouble() ?? 0,
      maxPrice?.toDouble() ?? 1000,
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.ref.watch(
      searchControllerProvider.select((state) => state.categories),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            const Gap(AppPadding.p16),
            _buildCategorySection(categories),
            const Gap(AppPadding.p16),
            _buildPriceSection(),
            const Gap(AppPadding.p16),
            _buildActionButtons(context),
            const Gap(AppPadding.p16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Filter By:',
            style: StyleManager.getSemiBoldStyle(
              color: ColorManager.blackColor,
              fontSize: FontSize.s16,
            ),
          ),
        ),
        IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _buildCategorySection(List categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: StyleManager.getRegularStyle(
            color: ColorManager.blackColor,
          ),
        ),
        const Gap(AppPadding.p4),
        SizedBox(
          height: AppSize.s40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => const Gap(AppPadding.p12),
            itemBuilder: (context, index) {
              final cat = categories[index];
              final isSelected = categoryId == cat.id;

              return AppRippleWidget(
                onTap: () => setState(() => categoryId = cat.id),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                  decoration: BoxDecoration(
                    color: isSelected ? ColorManager.colorPrimary1 : ColorManager.colorPureWhite,
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  child: Text(cat.name ?? ''),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Price',
              style: StyleManager.getRegularStyle(
                color: ColorManager.blackColor,
              ),
            ),
            Text(
              '${currentRangeValues.start.round()} - ${currentRangeValues.end.round()} ${Constants.currency}',
              style: StyleManager.getRegularStyle(
                color: ColorManager.colorPrimary,
              ),
            ),
          ],
        ),
        const Gap(AppPadding.p4),
        RangeSlider(
          values: currentRangeValues,
          min: 0,
          max: 5000,
          divisions: 40,
          labels: RangeLabels(
            '${currentRangeValues.start.round()}',
            '${currentRangeValues.end.round()}',
          ),
          onChanged: (values) => setState(() {
            currentRangeValues = values;
          }),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButtonWidget(
            label: 'Reset Filter',
            onPressed: () => _applyFilter(context, reset: true),
            buttonType: ButtonType.outline,
            buttonSize: ButtonSize.small,
          ),
        ),
        const Gap(AppPadding.p16),
        Expanded(
          child: AppButtonWidget(
            label: 'Apply',
            onPressed: () => _applyFilter(context),
            buttonSize: ButtonSize.small,
          ),
        ),
      ],
    );
  }

  void _applyFilter(BuildContext context, {bool reset = false}) {
    widget.ref.read(searchControllerProvider.notifier).filterProducts(
          categoryId: reset ? null : categoryId,
          minPrice: reset ? null : currentRangeValues.start,
          maxPrice: reset ? null : currentRangeValues.end,
          search: search,
        );

    context.pop();
  }
}
