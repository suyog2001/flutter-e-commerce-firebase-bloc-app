import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../app/app_bloc/app_bloc.dart';
import '../../../constant/form_status.dart';

import '../../../data/repositories/firestore_repository.dart';

part 'add_product_form_state.dart';

class AddProductFormCubit extends Cubit<AddProductFormState> {
  final FireStoreRepository _fireStoreRepository;
  final AppBloc _appBloc;
  AddProductFormCubit(
      {required FireStoreRepository fireStoreRepository,
      required AppBloc appBloc})
      : _fireStoreRepository = fireStoreRepository,
        _appBloc = appBloc,
        super(const AddProductFormState());

  void productNamechanged(String productName) {
    emit(state.copyWith(
        productName: productName, formStatus: const InitialFormStatus()));
  }

  void catagorychanged(String category) {
    emit(state.copyWith(
        category: category, formStatus: const InitialFormStatus()));
  }

  void pricechanged(String price) {
    // FIXME : // ! Try to Validate the the for only number
    emit(state.copyWith(
        price: double.parse(price), formStatus: const InitialFormStatus()));
  }

  void brandchanged(String brand) {
    emit(state.copyWith(brand: brand, formStatus: const InitialFormStatus()));
  }

  void addProduct() {
    emit(state.copyWith(formStatus: FormSubmmitingStatus()));
    try {
      if (_appBloc.state.status == AppStatus.authenticated) {
        final user = _appBloc.state.user;
        _fireStoreRepository.createProduct(
            uid: user.id,
            brand: state.brand,
            category: state.category,
            price: state.price,
            productName: state.productName);
        emit(state.copyWith(formStatus: FormSubmmisionSuccessStatus()));
      } else {
        emit(state.copyWith(
            formStatus: const FormSubmissionFailedStatus(
                errorMessage: 'You Are Unauthenticated')));
      }
    } catch (err) {
      emit(state.copyWith(
          formStatus:
              FormSubmissionFailedStatus(errorMessage: err.toString())));
    }
  }
}
