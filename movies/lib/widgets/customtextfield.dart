// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:Movie_App/settings/const.dart';
import 'package:flutter/material.dart';

class Customtextfield extends StatefulWidget {
  final String upperText;
  final String hintText;
  final Icon suffixIcon;
  final bool ObsecureText;
  final String errorText;
  final TextEditingController controller;
  VoidCallback? onTap;
  final double screenWidth;
  Icon? emergancyIcon;

  Customtextfield({
    super.key,
    required this.errorText,
    required this.screenWidth,
    required this.hintText,
    required this.suffixIcon,
    required this.ObsecureText,
    required this.upperText,
    this.emergancyIcon,
    this.onTap,
    required this.controller,
  });

  @override
  State<Customtextfield> createState() => _CustomtextfieldState();
}

class _CustomtextfieldState extends State<Customtextfield> {
  late bool isSecured;
  @override
  void initState() {
    super.initState();
    isSecured = widget.ObsecureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.upperText,
            style: Settings.menuText,
          ),
          SizedBox(
            width: widget.screenWidth,
            height: 40,
            //=================================TextFormField======================
            child: TextFormField(
              controller: widget.controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return widget.errorText;
                } else {
                  return null;
                }
              },
              obscureText:
                  widget.ObsecureText ? isSecured : widget.ObsecureText,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      widget.ObsecureText
                          ? setState(() {
                              isSecured = !isSecured;
                            })
                          : widget.onTap == null
                              ? null
                              : widget.onTap!();
                    },
                    icon: widget.ObsecureText
                        ? (isSecured
                            ? widget.suffixIcon
                            : widget.emergancyIcon!)
                        : widget.suffixIcon),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.8),
                    width: 1.0,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
