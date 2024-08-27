import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/colors_app.dart';

// ignore: must_be_immutable
class TextFormFieldCustom extends StatefulWidget {
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  TextInputType? textInputType;
  List<TextInputFormatter>? inputFormatters;
  FocusNode? focusNode;
  String labelText;
  Color labelColor;
  String hintText;
  bool enabled;
  bool obligatory;
  bool password;

  TextFormFieldCustom({
    this.controller,
    this.onChanged,
    this.validator,
    this.textInputType,
    this.inputFormatters,
    this.focusNode,
    String? labelText,
    Color? labelColor,
    String? hintText,
    bool? enabled,
    bool? obligatory,
    bool? password,
    super.key,
  })  : labelText = labelText ?? '',
        labelColor = labelColor ?? Colors.black87,
        hintText = hintText ?? '',
        enabled = enabled ?? true,
        obligatory = obligatory ?? false,
        password = password ?? false;

  @override
  State<TextFormFieldCustom> createState() => TtexFforFfieldCustomState();
}

class TtexFforFfieldCustomState extends State<TextFormFieldCustom> {
  late bool _obscurePassord = widget.password;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        keyboardType: widget.textInputType,
        obscureText: _obscurePassord,
        enabled: widget.enabled,
        decoration: InputDecoration(
          suffixIcon: widget.password
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      _obscurePassord == false
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color(0xFF72747A),
                    ),
                  ),
                  onTap: () => {
                    setState(
                      () {
                        _obscurePassord = !_obscurePassord;
                      },
                    )
                  },
                )
              : null,
          filled: true,
          fillColor:
              widget.enabled ? Colors.white : Colors.black.withOpacity(0.05),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 13.0,
            horizontal: 10.0,
          ),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.labelText,
                style: const TextStyle(fontSize: 19),
              ),
              Text(
                widget.obligatory ? '*' : '',
                style: const TextStyle(color: Colors.red, fontSize: 19),
              ),
            ],
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: ColorsApp.gray,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          labelStyle: TextStyle(
            color: widget.labelColor,
            fontWeight: FontWeight.w400,
            fontSize: 21,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: ColorsApp.gray),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: ColorsApp.primary,
              width: 2.0,
            ),
          ),
        ),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        validator: widget.validator,
        inputFormatters: widget.inputFormatters,
        focusNode: widget.focusNode,
      ),
    );
  }
}
