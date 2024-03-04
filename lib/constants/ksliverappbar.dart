import 'package:engineering_hub/backend/local_storage.dart';
import 'package:engineering_hub/constants/kbackground.dart';
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
      floating: true, pinned: true, snap: false, elevation: 10,
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: 230,
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
        background: KBackgroundImage(
          imagePath: "images/mumbai_university.jpg",
          child: Column(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 17.5),
                child: KActionButton(
                  onTap: onSubmit,
                  text: 'Enter following chat',
                  fontSize: 16,
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.5),
                  textColor: Theme.of(context).colorScheme.secondaryContainer,
                  fontWeight: FontWeight.w200,
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
