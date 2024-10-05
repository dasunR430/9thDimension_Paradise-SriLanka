import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Common/Enums/password_textfield_enum.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    super.key,
    required this.label,
    required this.onChanged,
    required this.focusedColor,
    required this.textController,
    this.passwordEnum = PasswordTextFieldEnum.notPassword,
    this.visibilityIconPressed,
    this.isCountryPicker = false,
  });

  final String label;
  final TextEditingController textController;
  final void Function(String) onChanged;
  final Color focusedColor;
  final PasswordTextFieldEnum passwordEnum;
  final Function? visibilityIconPressed;
  final bool isCountryPicker;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isCountryPicker,
      controller: textController,
      onChanged: !isCountryPicker ? onChanged : null,
      obscureText: (passwordEnum == PasswordTextFieldEnum.invisible),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: (passwordEnum != PasswordTextFieldEnum.notPassword)
            ? IconButton(
                onPressed: () {
                  visibilityIconPressed!();
                },
                icon: const Icon(Icons.visibility),
              )
            : isCountryPicker ? IconButton(
                    onPressed: () {
                      showCountryPicker(
                      context: context,
                      onSelect: (Country country) {
                        textController.text = country.name;
                        onChanged(country.countryCode);
                      },
                      // Optional. Sheet moves when keyboard opens.
                      moveAlongWithKeyboard: false,
                      // Optional. Sets the theme for the country list picker.
                      countryListTheme: CountryListThemeData(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                        // Optional. Styles the text in the search field
                        searchTextStyle: const TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    );},
                    icon: const Icon(Icons.arrow_drop_down_outlined))
                : null,
        focusedBorder: (Theme.of(context).inputDecorationTheme.focusedBorder
                as OutlineInputBorder)
            .copyWith(
          borderSide: BorderSide(width: 1, color: focusedColor),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
