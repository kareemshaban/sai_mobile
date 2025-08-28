import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/domain/entity/store_entity/product_option_entity.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class ProductOptionDropdown extends StatelessWidget {
  final String name;
  final List<ProductOptionValuesEntity> values;
  final int? value;
  final void Function(int?)? onChange;

  const ProductOptionDropdown({
    super.key,
    required this.name,
    required this.values,
    this.value,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: Get.textTheme.titleMedium!.copyWith(
              fontSize: AppSize.s18(context),
            ),
          ),
          SizedBox(
            width: 100,
            child: DropdownButtonFormField2<int>(
              items: List.generate(
                values.length,
                (index2) {
                  return DropdownMenuItem(
                    value: values[index2].id,
                    child: Text(
                      values[index2].name,
                    ),
                  );
                },
              ),
              value: value,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                ),
                iconSize: 20,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null && value == 0) {
                  return AppStrings.emptyError;
                }
                return null;
              },
              onChanged: onChange,
            ),
          ),
        ],
      ),
    );
  }
}
