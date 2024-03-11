import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:engineering_hub/constants/KStyledText.dart';
import 'package:flutter/material.dart';

//* Input field for college and branch
class SearchDropdownButton extends StatelessWidget {
  final String buttonHint, searchHint;
  final bool? isBorderNeeded;
  final String? selectedValue;
  final List<String> itemsList;
  final Function(String) onSelect;

  const SearchDropdownButton({
    super.key,
    required this.buttonHint,
    required this.searchHint,
    required this.itemsList,
    required this.selectedValue,
    required this.onSelect,
    this.isBorderNeeded,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        //* Inner text style
        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),

        //* Icon Customization
        iconStyleData: IconStyleData(
            icon: Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: Theme.of(context).iconTheme.color,
        )),
        isExpanded: true,
        // Hint text
        hint: StyledText(
          text: buttonHint,
          color: Theme.of(context).hintColor.withOpacity(0.33),
          size: isBorderNeeded == null ? 16 : 14,
        ),
        items: itemsList
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) => onSelect(value!),

        // Dropdown button style
        buttonStyleData: isBorderNeeded != null
            ? ButtonStyleData(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    width: 0.7,
                    color: Theme.of(context).primaryColor.withOpacity(0.4),
                  )),
                ),
              )
            : ButtonStyleData(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 0.1,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ),

        // Dropdown menu style
        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Menu items style
        menuItemStyleData: const MenuItemStyleData(
          height: 50,
        ),

        // Dropdown search bar style
        dropdownSearchData: DropdownSearchData(
          searchController: searchController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            margin: const EdgeInsets.all(8),
            height: 50,
            child: TextFormField(
              expands: true,
              maxLines: null,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
              controller: searchController,
              decoration: InputDecoration(
                isDense: true,
                fillColor:
                    Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                filled: true,
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                hintText: searchHint,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 0.5,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 0.2,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().toLowerCase().contains(
                  searchValue.toLowerCase(),
                );
          },
        ),
      ),
    );
  }
}

///
///
///
///
///
//* Input field for semester
class SelectDropdownButton extends StatelessWidget {
  final String buttonHint;
  final List<String> itemsList;
  final String? selectedValue;
  final bool? isBorderNeeded;
  final Function(String) onSelect;
  const SelectDropdownButton({
    super.key,
    required this.buttonHint,
    required this.itemsList,
    required this.selectedValue,
    required this.onSelect,
    this.isBorderNeeded,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        //* Icon customization
        iconStyleData: IconStyleData(
            icon: Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: Theme.of(context).iconTheme.color,
        )),
        isExpanded: true,

        //* Hint text
        hint: StyledText(
          text: buttonHint,
          color: Theme.of(context).hintColor.withOpacity(0.33),
          size: isBorderNeeded == null ? 14 : 16,
        ),
        items: itemsList
            .map(
              (item) => DropdownMenuItem(
                  value: item,
                  child: Align(alignment: Alignment.center, child: Text(item))),
            )
            .toList(),
        value: selectedValue,
        onChanged: (value) => onSelect(value!),

        // Dropdown button style
        buttonStyleData: isBorderNeeded != null
            ? ButtonStyleData(
                elevation: 10,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.7,
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                    ),
                  ),
                ),
              )
            : ButtonStyleData(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 0.1,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ),

        // Dropdown menu style
        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Menu items style
        menuItemStyleData: const MenuItemStyleData(
          height: 50,
        ),
      ),
    );
  }
}
