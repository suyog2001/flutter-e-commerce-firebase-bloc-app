part of 'add_product_form_cubit.dart';

class AddProductFormState extends Equatable {
  const AddProductFormState(
      {this.productName = '',
      this.price = 0.0,
      this.category = '',
      this.brand = '',
      this.formStatus = const InitialFormStatus()});
  final String productName;
  final double price;
  final String category;
  final FormSubmissionStatus formStatus;
  final String brand;
  @override
  List<Object?> get props => [productName, price, category, brand];

  AddProductFormState copyWith(
      {String? productName,
      double? price,
      String? category,
      String? brand,
      FormSubmissionStatus? formStatus}) {
    return AddProductFormState(
        productName: productName ?? this.productName,
        price: price ?? this.price,
        brand: brand ?? this.brand,
        category: category ?? this.category,
        formStatus: formStatus ?? this.formStatus);
  }
}
