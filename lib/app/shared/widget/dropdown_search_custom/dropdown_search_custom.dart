import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../shared/util/colors_app.dart';
import '../text_form_field_custom/text_form_field_custom.dart';

class DropdownSearchCustom<T> extends StatefulWidget {
  final String searchHintText;
  final String hintText;
  final bool obligatory;
  final bool enabled;
  final List<T>? items;
  final T? initialItem;
  final dynamic Function(T)? onChanged;
  final String? Function(T?)? validator;
  final bool searchEnabled;

  const DropdownSearchCustom({
    this.searchHintText = 'Pesquisar...',
    required this.hintText,
    required this.items,
    this.initialItem,
    this.obligatory = false,
    this.enabled = true,
    this.onChanged,
    this.validator,
    this.searchEnabled = true,
    super.key,
  });

  @override
  State<DropdownSearchCustom<T>> createState() =>
      _CustomDropdownSearchCustomState<T>();
}

class _CustomDropdownSearchCustomState<T>
    extends State<DropdownSearchCustom<T>> {
  T? thisValue;

  @override
  void initState() {
    super.initState();

    thisValue = widget.initialItem;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enabled) {
      if (widget.items?.isEmpty ?? true) {
        return _dataNotFound();
      }
      if (widget.searchEnabled) {
        return _dropdownSearch();
      } else {
        return _dropdownSimple();
      }
    } else {
      return _disabled();
    }
  }

  Widget _disabled() {
    return TextFormFieldCustom(
      controller: TextEditingController()
        ..text = thisValue != null ? thisValue.toString() : '',
      textInputType: TextInputType.text,
      obligatory: widget.obligatory,
      labelText: widget.hintText,
      enabled: false,
    );
  }

  Widget _dataNotFound() {
    return TextFormFieldCustom(
      controller: TextEditingController()..text = 'Nenhum dado encontrado',
      textInputType: TextInputType.text,
      obligatory: widget.obligatory,
      labelText: widget.hintText,
      enabled: false,
    );
  }

// Widget Function(BuildContext, String, bool)?
  Widget Function(BuildContext, String, bool)? hintBuilder() {
    return (context, hint, obligatory) {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        Text(
          hint,
          style: const TextStyle(fontSize: 19),
        ),
        Text(
          widget.obligatory ? '*' : '',
          style: const TextStyle(color: Colors.red, fontSize: 19),
        ),
      ]);
    };
  }

  EdgeInsets? closedHeaderPadding =
      const EdgeInsets.symmetric(horizontal: 9, vertical: 12);

  CustomDropdownDecoration? decoration = const CustomDropdownDecoration(
    headerStyle: TextStyle(
      color: ColorsApp.black,
      fontSize: 17,
      fontWeight: FontWeight.w400,
    ),
    listItemStyle: TextStyle(
      color: ColorsApp.black,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
    closedBorderRadius: BorderRadius.all(Radius.circular(15)),
    closedBorder: Border.fromBorderSide(
      BorderSide(
        color: ColorsApp.gray,
        // width: 0.5,
      ),
    ),
  );

  Widget _label() {
    return Visibility(
      visible: thisValue != null,
      child: Row(
        children: [
          Text(
            widget.hintText,
            style: const TextStyle(
              color: ColorsApp.black,
              fontSize: 14,
            ),
          ),
          Text(
            widget.obligatory ? '*' : '',
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _dropdownSimple() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(),
        CustomDropdown<T>(
          hintText: widget.hintText,
          items: widget.items,
          initialItem: widget.initialItem,
          overlayHeight: 342,
          hintBuilder: hintBuilder(),
          closedHeaderPadding: closedHeaderPadding,
          decoration: decoration,
          onChanged: (value) {
            setState(() {
              thisValue = value;
            });

            if (widget.onChanged != null) {
              widget.onChanged!.call(value as T);
            }
          },
          validator: widget.validator,
        ),
      ],
    );
  }

  Widget _dropdownSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: thisValue != null,
          child: Row(
            children: [
              Text(
                widget.hintText,
                style: const TextStyle(
                  color: ColorsApp.black,
                  fontSize: 14,
                ),
              ),
              Text(
                widget.obligatory ? '*' : '',
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
        CustomDropdown<T>.search(
          searchHintText: widget.searchHintText,
          hintText: widget.hintText,
          items: widget.items,
          initialItem: widget.initialItem,
          overlayHeight: 342,
          hintBuilder: hintBuilder(),
          closedHeaderPadding: closedHeaderPadding,
          decoration: decoration,
          onChanged: (value) {
            setState(() {
              thisValue = value;
            });

            if (widget.onChanged != null) {
              widget.onChanged!.call(value as T);
            }
          },
          validator: widget.validator,
        ),
      ],
    );
  }
}
