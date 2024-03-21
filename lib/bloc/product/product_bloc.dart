import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/model/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial());

  Future<void> _addProduct(Productadd event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      emit(ProductAdd(event.product));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  Future<void> _deleteProduct(
      Productdelete event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      emit(ProductDeleteLoading());
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  Future<void> _getProduct(Productget event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      emit(ProductSuccess([event.product]));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}
