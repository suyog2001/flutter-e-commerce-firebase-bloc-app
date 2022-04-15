import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/constant/form_status.dart';
import 'package:flutter_e_commerce_app/data/repositories/firestore_repository.dart';
import 'package:flutter_e_commerce_app/pages/product_add_page/add_product_form_cubit/add_product_form_cubit.dart';

import '../../../app/app_bloc/app_bloc.dart';

class ProductAddPage extends StatelessWidget {
  ProductAddPage({Key? key}) : super(key: key);
  final _productFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductFormCubit(
          appBloc: context.read<AppBloc>(),
          fireStoreRepository: context.read<FireStoreRepository>()),
      child: BlocListener<AddProductFormCubit, AddProductFormState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (state.formStatus is FormSubmmisionSuccessStatus) {
            Navigator.of(context).pop();
          } else if (formStatus is FormSubmissionFailedStatus) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(formStatus.errorMessage)));
          }
        },
        child: Scaffold(
            appBar: AppBar(title: const Text('Add Product'), centerTitle: true),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _productFormKey,
                child: Column(children: [
                  const _ProductNameField(),
                  const _BrandNameField(),
                  const _CategoryDropDownField(),
                  const _PriceField(),
                  _AddProductButton(productFormKey: _productFormKey)
                ]),
              ),
            )),
      ),
    );
  }
}

class _BrandNameField extends StatelessWidget {
  const _BrandNameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductFormCubit, AddProductFormState>(
      buildWhen: (previous, current) => previous.brand != current.brand,
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) =>
              context.read<AddProductFormCubit>().brandchanged(value),
          decoration: const InputDecoration(label: Text('Brand Name')),
        );
      },
    );
  }
}

class _AddProductButton extends StatelessWidget {
  const _AddProductButton({
    Key? key,
    required GlobalKey<FormState> productFormKey,
  })  : _productFormKey = productFormKey,
        super(key: key);

  final GlobalKey<FormState> _productFormKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductFormCubit, AddProductFormState>(
      builder: (context, state) {
        if (state.formStatus is FormSubmmitingStatus) {
          return const CircularProgressIndicator();
        }
        return ElevatedButton(
            onPressed: () {
              if (_productFormKey.currentState!.validate()) {
                context.read<AddProductFormCubit>().addProduct();
              }
            },
            child: const Text('Add'));
      },
    );
  }
}

class _PriceField extends StatelessWidget {
  const _PriceField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductFormCubit, AddProductFormState>(
      buildWhen: (previous, current) => previous.price != current.price,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.price.toStringAsPrecision(2),
          onChanged: (value) => context
              .read<AddProductFormCubit>()
              .pricechanged(value.trim().isEmpty ? '0.0' : value),
          validator: (value) {
            // TODO : Do Validation
            return null;
          },
          decoration: const InputDecoration(label: Text('Product Price')),
          keyboardType: TextInputType.number,
        );
      },
    );
  }
}

class _CategoryDropDownField extends StatelessWidget {
  const _CategoryDropDownField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductFormCubit, AddProductFormState>(
      buildWhen: (previous, current) => previous.category != current.category,
      builder: (context, state) {
        return DropdownButtonFormField<String>(
            value: state.category,
            decoration: const InputDecoration(label: Text('Product Category')),
            items: const [
              DropdownMenuItem(
                child: Text('Not Selected'),
                value: '',
              ),
              DropdownMenuItem(
                child: Text('clothes'),
                value: 'clothes',
              ),
              DropdownMenuItem(
                child: Text('electronics'),
                value: 'electronics',
              ),
              DropdownMenuItem(
                child: Text('food'),
                value: 'food',
              ),
              DropdownMenuItem(
                child: Text('toys'),
                value: 'toys',
              )
            ],
            onChanged: (value) {
              context.read<AddProductFormCubit>().catagorychanged(value!);
            });
      },
    );
  }
}

class _ProductNameField extends StatelessWidget {
  const _ProductNameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductFormCubit, AddProductFormState>(
      buildWhen: (previous, current) =>
          previous.productName != current.productName,
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) {
            context.read<AddProductFormCubit>().productNamechanged(value);
          },
          decoration: const InputDecoration(label: Text('Product Name')),
        );
      },
    );
  }
}
