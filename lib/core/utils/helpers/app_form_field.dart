import 'package:flutter/material.dart';

import 'theme.dart';

class TxtField extends StatefulWidget {
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final String? hintText;
  final String? labelText;
  final bool enabled;
  final TextInputType textInputType;
  final Widget? prefix;
  final bool obscureText;
  final TextEditingController controller;
  final String? extraLabel;
  final List<String>? autoCompleteOptions;

  // Constructor for general text fields
  const TxtField({
    Key? key,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.enabled = true,
    required this.textInputType,
    this.prefix,
    this.obscureText = false,
    required this.controller,
    this.extraLabel,
    this.autoCompleteOptions,
  }) : super(key: key);
  // Named constructor for normal text fields
  TxtField.text({
    Key? key,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.hintText = 'Text',
    this.labelText = 'Enter text',
    this.enabled = true,
    this.textInputType = TextInputType.text,
    this.prefix,
    this.obscureText = false,
    required this.controller,
    this.extraLabel,
    this.autoCompleteOptions,
  }) : super(key: key);
  // Named constructor for password fields
  TxtField.password({
    Key? key,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.hintText = 'Password',
    this.labelText = 'Enter your password',
    this.enabled = true,
    this.textInputType = TextInputType.visiblePassword,
    this.prefix,
    this.obscureText = true,
    required this.controller,
    this.extraLabel,
    this.autoCompleteOptions,
  }) : super(key: key);

  // Named constructor for email fields
  TxtField.email({
    Key? key,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.hintText = 'Email',
    this.labelText = 'Enter your email',
    this.enabled = true,
    this.textInputType = TextInputType.emailAddress,
    this.prefix,
    this.obscureText = false,
    required this.controller,
    this.extraLabel,
    this.autoCompleteOptions,
  }) : super(key: key);

  // Named constructor for phone number fields
  TxtField.phone({
    Key? key,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.hintText = 'Phone Number',
    this.labelText = 'Enter your phone number',
    this.enabled = true,
    this.textInputType = TextInputType.phone,
    this.prefix,
    this.obscureText = false,
    required this.controller,
    this.extraLabel,
    this.autoCompleteOptions,
  }) : super(key: key);

  // Named constructor for AutoComplete TextField
  TxtField.autoComplete({
    Key? key,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.hintText = 'Search',
    this.labelText = 'Start typing...',
    this.enabled = true,
    this.textInputType = TextInputType.text,
    this.prefix,
    this.obscureText = false,
    required this.controller,
    this.extraLabel,
    required this.autoCompleteOptions, // Required for autocomplete
  }) : super(key: key);

  @override
  _TxtFieldState createState() => _TxtFieldState();
}

class _TxtFieldState extends State<TxtField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    if (widget.autoCompleteOptions != null) {
      // If autoCompleteOptions is provided, build the autocomplete field
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.extraLabel != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  widget.extraLabel!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                // Filter options based on the user input
                final filteredOptions =
                    widget.autoCompleteOptions!.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                }).toList();

                // If there are no matching results, return an empty list
                return filteredOptions.isEmpty
                    ? const Iterable<String>.empty()
                    : filteredOptions;
              },
              displayStringForOption: (String option) => option,
              onSelected: (String selection) {
                widget.controller.text = selection;
                if (widget.onChanged != null) {
                  widget.onChanged!(selection);
                }
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return options.isEmpty
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        child:
                            const Text('No data available or invalid search'),
                      )
                    : Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            color: Colors.white,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final String option = options.elementAt(index);
                                return ListTile(
                                  title: Text(option),
                                  onTap: () {
                                    onSelected(option);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      );
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    labelText: widget.labelText,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide(
                        width: 0.5,
                        color: StylesApp.instance.primaryColor,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                  ),
                  onChanged: widget.onChanged,
                );
              },
            ),
          ],
        ),
      );
    } else {
      // Default TextFormField
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.extraLabel != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  widget.extraLabel!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            TextFormField(
              validator: widget.validator,
              controller: widget.controller,
              onSaved: widget.onSaved,
              enabled: widget.enabled,
              keyboardType: widget.textInputType,
              obscureText: widget.obscureText && _isObscured,
              style: const TextStyle(
                color: Color(0xFFC1C1C1),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: StylesApp.instance.primaryColor,
                  ),
                ),
                errorStyle: const TextStyle(
                  color: Color(0xFFC1C1C1),
                  fontSize: 13,
                ),
                prefixIcon: widget.prefix != null
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: widget.prefix,
                      )
                    : null,
                suffixIcon: widget.textInputType ==
                        TextInputType.visiblePassword
                    ? IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 15,
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: StylesApp.instance.primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: StylesApp.instance.primaryColor,
                  ),
                ),
                labelText: widget.labelText,
                hintText: widget.hintText,
                labelStyle: const TextStyle(
                  color: Color(0xFFC1C1C1),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: widget.onChanged,
            ),
          ],
        ),
      );
    }
  }
}
