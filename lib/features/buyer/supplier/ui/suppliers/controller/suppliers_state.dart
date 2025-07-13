import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_model.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class SuppliersState {
  final DataState getSuppliersDataState;
  final bool isLoadingMore;
  final List<SupplierModel> suppliers;
  final int pageNumber;
  final bool hasMore;
  final Failure? failure;
  final bool isGridView;

  SuppliersState({
    this.getSuppliersDataState = DataState.initial,
    this.isLoadingMore = false,
    this.suppliers = const [],
    this.pageNumber = 1,
    this.hasMore = false,
    this.failure,
    this.isGridView = true,
  });

  SuppliersState copyWith({
    DataState? getSuppliersDataState,
    bool? isLoadingMore,
    List<SupplierModel>? suppliers,
    int? pageNumber,
    bool? hasMore,
    Failure? failure,
    bool? isGridView,
  }) {
    return SuppliersState(
      getSuppliersDataState: getSuppliersDataState ?? this.getSuppliersDataState,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      suppliers: suppliers ?? this.suppliers,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
      failure: failure ?? this.failure,
      isGridView: isGridView ?? this.isGridView,
    );
  }
}
