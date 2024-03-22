import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/firebase/firestore_cloude.dart';
import 'package:product_app/model/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<Productadd>(_addProduct);
    on<Productget>(_getProduct);
    on<Productdelete>(_deleteProduct);
  }

  Future<void> _addProduct(Productadd event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final responce = await FireStoreProvider().addProduct(event.product);
      if (responce == null) {
        emit(ProductAddSuccess(event.product));
      } else {
        emit(ProductFailure('Unable to add product $responce'));
      }
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
      final responce = await FireStoreProvider()
          .getProducts(val: event.product == 'all' ? null : event.product);

      if (responce is List<ProductModel>) {
        emit(ProductSuccess(responce));
      } else {
        emit(ProductFailure('Unable to get product $responce'));
      }
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}
