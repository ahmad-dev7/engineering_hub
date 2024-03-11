import 'package:engineering_hub/backend/local_storage.dart';
import 'package:engineering_hub/constants/kbutton.dart';
import 'package:engineering_hub/model/items_list.dart';
import 'package:engineering_hub/model/student.dart';
import 'package:engineering_hub/packages/dropdown_button2.dart';
import 'package:flutter/material.dart';

class KSliverAppBar extends StatelessWidget {
  const KSliverAppBar({
    super.key,
    required this.selectedCollege,
    required this.selectedBranch,
    required this.selectedSemester,
    required this.onCollegeSelect,
    required this.onBranchSelect,
    required this.onSemesterSelect,
    required this.onSubmit,
  });
  final String? selectedCollege, selectedBranch, selectedSemester;
  final Function(String) onCollegeSelect, onBranchSelect, onSemesterSelect;
  final Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    final Student student = LocalStorage().readStudentData();
    return SliverAppBar(
      forceElevated: true,

      floating: true, pinned: true, snap: false, elevation: 100,
      backgroundColor: Theme.of(context).primaryColor,
      shadowColor: Theme.of(context).shadowColor,
      expandedHeight: 200,
      //* College dropdown
      title: SearchDropdownButton(
        isBorderNeeded: false,
        buttonHint: student.collegeName,
        searchHint: 'Search college',
        itemsList: collegeList,
        selectedValue: selectedCollege,
        onSelect: onCollegeSelect,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //* Semester and Branch dropdown
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //* Select semester dropdown
                    Flexible(
                      flex: 1,
                      child: SelectDropdownButton(
                        isBorderNeeded: false,
                        buttonHint: student.semester,
                        itemsList: semesterList,
                        selectedValue: selectedSemester,
                        onSelect: onSemesterSelect,
                      ),
                    ),

                    //* Empty space
                    const SizedBox(width: 10),

                    //* Select branch dropdown
                    Flexible(
                      flex: 5,
                      child: SearchDropdownButton(
                        isBorderNeeded: false,
                        buttonHint: student.branchName,
                        searchHint: 'Find branch',
                        itemsList: branchList,
                        selectedValue: selectedBranch,
                        onSelect: onBranchSelect,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //* Submit button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: KActionButton(
                onTap: onSubmit,
                text: 'Enter following chat',
                fontSize: 16,
                color: Theme.of(context).scaffoldBackgroundColor,
                textColor: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.w200,
                height: 60,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
