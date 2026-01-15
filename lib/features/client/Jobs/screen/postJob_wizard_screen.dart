import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// =======================
///  MODELS
/// =======================

/// =======================
///  MAIN SCREEN (WIZARD)
/// =======================
class PostJobWizardScreen extends StatefulWidget {
  const PostJobWizardScreen({super.key});
  static const String routeName = '/post-job-wizard';

  @override
  State<PostJobWizardScreen> createState() => _PostJobWizardScreenState();
}

class _PostJobWizardScreenState extends State<PostJobWizardScreen> {
  final PageController _page = PageController();
  int _step = 0;

  // controllers
  final _titleCtrl = TextEditingController();
  final _searchCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  // data
  late final List<StepItem> steps;
  late final List<CategoryItem> mostUsed;
  late final List<CategoryItem> allCategories;

  final Set<String> _selectedCategoryIds = {};
  ProjectSize? _projectSize;
  final List<AttachedFile> _files = [];

  String? _budgetDropdown; // "$600-$1200"
  String? _budgetQuick; // "SAR 600 +"
  bool _budgetError = false;

  @override
  void initState() {
    super.initState();

    steps = [
      StepItem(
        id: "post",
        title: "Post a job",
        icon: Icons.work_outline,
        number: "1",
      ),
      StepItem(
        id: "offers",
        title: "Get Offers",
        icon: Icons.person_outline,
        number: "2",
      ),
      StepItem(
        id: "choose",
        title: "Choose a\nworkpeer",
        icon: Icons.share_outlined,
        number: "3",
      ),
    ];

    mostUsed = [
      CategoryItem("assembly", "Assembly"),
      CategoryItem("mounting", "Mounting"),
      CategoryItem("moving", "Moving"),
      CategoryItem("cleaning", "Cleaning"),
      CategoryItem("outdoor", "Outdoor Help"),
      CategoryItem("home", "Home Repairs"),
      CategoryItem("painting", "Painting"),
      CategoryItem("trending", "Trending"),
    ];

    allCategories = [
      CategoryItem("gfa", "General Furniture Assembly"),
      CategoryItem("ikea", "IKEA Assembly"),
      CategoryItem("crib", "Crib Assembly"),
      CategoryItem("pax", "PAX Assembly"),
      CategoryItem("desk", "Desk Assembly"),
      CategoryItem("bookshelf", "Bookshelf Assembly"),
    ];

    _projectSize = ProjectSize.small;

    _descCtrl.addListener(() => setState(() {}));
    _searchCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _page.dispose();
    _titleCtrl.dispose();
    _searchCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  // -----------------------
  //  UI TOKENS (design)
  // -----------------------
  static const Color kBorder = Color(0xFFE6E7EB);
  static const Color kMuted = Color(0xFF7A7A7A);
  static const Color kText = Color(0xFF111111);
  static const Color kChipBg = Color(0xFFF3F3F3);
  static const Color kLime = Color(0xFFCAFF45);

  // -----------------------
  //  FLOW ACTIONS
  // -----------------------
  void _back() {
    if (_step == 0) {
      Navigator.maybePop(context);
      return;
    }
    setState(() => _step -= 1);
    _page.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _next() {
    // validations
    if (_step == 0) {
      if (_titleCtrl.text.trim().isEmpty) {
        _toast("Please write a title.");
        return;
      }
    }

    if (_step == 3) {
      final ok =
          (_budgetDropdown != null && _budgetDropdown!.isNotEmpty) ||
          (_budgetQuick != null);
      if (!ok) {
        setState(() => _budgetError = true);
        return;
      }
      // go preview
      final draft = JobDraft(
        title: _titleCtrl.text.trim(),
        categories: _selectedCategories(),
        size: _projectSize ?? ProjectSize.small,
        description: _descCtrl.text.trim(),
        files: List.of(_files),
        budget: _budgetQuick ?? _budgetDropdown ?? "",
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => JobPreviewScreen(
            draft: draft,
            onEdit: () => Navigator.pop(context),
            onPublish: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const JobPostedSuccessScreen(),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    setState(() => _step += 1);
    _page.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg, style: GoogleFonts.plusJakartaSans())),
    );
  }

  List<CategoryItem> _selectedCategories() {
    final map = <String, CategoryItem>{};
    for (final c in mostUsed) map[c.id] = c;
    for (final c in allCategories) map[c.id] = c;
    return _selectedCategoryIds
        .map((id) => map[id])
        .whereType<CategoryItem>()
        .toList();
  }

  // -----------------------
  //  CATEGORY actions
  // -----------------------
  void _toggleCategory(CategoryItem c) {
    setState(() {
      if (_selectedCategoryIds.contains(c.id)) {
        _selectedCategoryIds.remove(c.id);
      } else {
        _selectedCategoryIds.add(c.id);
      }
    });
  }

  // -----------------------
  //  FILE actions (demo)
  // -----------------------
  void _mockAddFile() {
    // তুমি চাইলে এখানে FilePicker integrate করবে।
    // এখন demo হিসেবে file add করছি।
    final idx = Random().nextInt(999);
    setState(() {
      _files.add(AttachedFile("Attachment file $idx.jpeg", "1.2 MB"));
    });
  }

  void _removeFile(int i) {
    setState(() => _files.removeAt(i));
  }

  // -----------------------
  //  BUDGET actions
  // -----------------------
  void _pickQuickBudget(String v) {
    setState(() {
      _budgetError = false;
      _budgetQuick = v;
      _budgetDropdown = null;
    });
  }

  // -----------------------
  //  APP BAR (1/4 progress)
  // -----------------------
PreferredSizeWidget _buildAppBar() {
  final progress = (_step + 1) / 4.0;

  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    toolbarHeight: 84.h, // ✅ match your big header height
    centerTitle: true,

    leadingWidth: 24.w + 40.w + 12.w, // left padding + button + small space
    leading: Padding(
      padding: EdgeInsets.only(left: 24.w),
      child: Align(
        alignment: Alignment.centerLeft, // ✅ vertically centered
        child: InkWell(
          onTap: _back,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            width: 40.w,
            height: 40.w,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded, // ✅ thin like figma
                size: 18.sp,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    ),

    title: Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Text(
        "Post a job",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "SF Pro Display", // ✅ if added in pubspec
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          height: 1.0,
          letterSpacing: 0,
          color: const Color(0xFF000000),
        ),
      ),
    ),

    actions: [
      Padding(
        padding: EdgeInsets.only(right: 16.w),
        child: Center( // ✅ actions vertically centered
          child: Row(
            children: [
              Container(
                width: 54.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(99.r),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 54.w * progress,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: kLime,
                      borderRadius: BorderRadius.circular(99.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                "${_step + 1}/4",
                style: TextStyle(
                  fontFamily: "SF Pro Display",
                  fontSize: 18.sp,           // ✅ figma side number looks big
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                  color: const Color(0xFF9B9B9B),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

  // -----------------------
  //  BOTTOM BUTTON (black bar)
  // -----------------------
  Widget _bottomButton() {
    final isLast = _step == 3;
    final label = isLast ? "Submit & review job post  →" : "Next Step  →";

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 54.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(0),
          ),
          child: InkWell(
            onTap: _next,
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // -----------------------
  //  PAGE: Step 1
  // -----------------------
  Widget _step1() {
    final query = _searchCtrl.text.trim().toLowerCase();
    final results = query.isEmpty
        ? <CategoryItem>[]
        : allCategories
              .where((c) => c.name.toLowerCase().contains(query))
              .toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ListView(
        children: [
          SizedBox(height: 10.h),
          _fieldLabel("Job title *"),
          SizedBox(height: 8.h),
          _textField(controller: _titleCtrl, hint: "Write a title"),
          SizedBox(height: 16.h),
          _fieldLabel("Search skills or add your won *"),
          SizedBox(height: 8.h),
          _textField(
            controller: _searchCtrl,
            hint: "Search category / type",
            suffix: Icon(Icons.search_rounded, color: kMuted, size: 18.sp),
          ),

          // Search results (like screenshot: list with Add/Added)
          if (query.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: kBorder),
              ),
              child: Column(
                children: results.map((c) {
                  final added = _selectedCategoryIds.contains(c.id);
                  return InkWell(
                    onTap: () => _toggleCategory(c),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              c.name,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: kText,
                              ),
                            ),
                          ),
                          Text(
                            added ? "Added" : "Add",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: added ? kLime : kMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          SizedBox(height: 14.h),
          Text(
            "MOST USED CATEGORIES",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFB0B0B0),
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 10.h),

          // Most used chips (with + like screenshot)
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: mostUsed.map((c) {
              final selected = _selectedCategoryIds.contains(c.id);
              return _pillChip(
                text: c.name,
                selected: selected,
                trailing: selected ? null : const Icon(Icons.add, size: 16),
                onTap: () => _toggleCategory(c),
              );
            }).toList(),
          ),

          SizedBox(height: 14.h),

          // Selected category chips (green bordered like screenshot)
          if (_selectedCategoryIds.isNotEmpty) ...[
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: _selectedCategories().map((c) {
                return _selectedChip(
                  text: c.name,
                  onRemove: () => _toggleCategory(c),
                );
              }).toList(),
            ),
          ],

          SizedBox(height: 80.h),
        ],
      ),
    );
  }

  // -----------------------
  //  PAGE: Step 2
  // -----------------------
  Widget _step2() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ListView(
        children: [
          SizedBox(height: 10.h),
          _fieldLabel("Project Size"),
          SizedBox(height: 10.h),
          _radioCard(
            title: "Large",
            subtitle: "Extended or multifaceted  [estimate : 1+ day ]",
            value: ProjectSize.large,
          ),
          SizedBox(height: 10.h),
          _radioCard(
            title: "Medium",
            subtitle: "Precisely defined projects [estimate : 6 - 10 hours]",
            value: ProjectSize.medium,
          ),
          SizedBox(height: 10.h),
          _radioCard(
            title: "Small",
            subtitle: "Simple and efficient tasks [estimate : 4 - 6 hours]",
            value: ProjectSize.small,
          ),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }

  // -----------------------
  //  PAGE: Step 3
  // -----------------------
  Widget _step3() {
    const maxChars = 1000;
    final used = _descCtrl.text.length;
    final left = max(0, maxChars - used);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ListView(
        children: [
          SizedBox(height: 10.h),
          _fieldLabel("Description"),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: kBorder),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                TextField(
                  controller: _descCtrl,
                  maxLines: 9,
                  decoration: InputDecoration(
                    hintText: "Write job description...",
                    hintStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      color: const Color(0xFFB0B0B0),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(14.w),
                  ),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: kText,
                    height: 1.25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 12.w, bottom: 10.h),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$left characters left",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        color: const Color(0xFFB0B0B0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 18.h),
          _fieldLabel("Attach File"),
          SizedBox(height: 10.h),

          // dashed attach box (no plugin)
          DashedBorder(
            radius: 12.r,
            child: InkWell(
              onTap: _mockAddFile,
              child: Container(
                padding: EdgeInsets.all(14.w),
                child: Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF7D7),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.attach_file,
                        size: 20.sp,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Attach file",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w800,
                              color: kText,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "pdf, png, jpeg and max 10mb",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: kMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (_files.isNotEmpty) ...[
            SizedBox(height: 14.h),
            Text(
              "Just attached files",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFB0B0B0),
              ),
            ),
            SizedBox(height: 10.h),
            ...List.generate(_files.length, (i) {
              final f = _files[i];
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: kBorder),
                      ),
                      child: Icon(
                        Icons.insert_drive_file_rounded,
                        size: 18.sp,
                        color: kMuted,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            f.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: kText,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            f.sizeLabel,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: kMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: kBorder),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                      ),
                      onPressed: () => _removeFile(i),
                      child: Text(
                        "Delete",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: kText,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],

          SizedBox(height: 80.h),
        ],
      ),
    );
  }

  // -----------------------
  //  PAGE: Step 4
  // -----------------------
  Widget _step4() {
    final dropdownBorder = _budgetError ? Colors.red : kBorder;

    final quickCosts = [
      "SAR 400 +",
      "SAR 600 +",
      "SAR 800 +",
      "SAR 1000 +",
      "SAR 1200 +",
      "SAR 1400 +",
      "SAR 1600 +",
      "SAR 1800 +",
      "SAR 2000 +",
      "SAR 2200 +",
    ];

    final dropdownItems = [
      "\$600-\$1200",
      "\$1200-\$2000",
      "\$2000-\$3500",
      "\$3500+",
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ListView(
        children: [
          SizedBox(height: 10.h),
          _fieldLabel("select a budget"),
          SizedBox(height: 10.h),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: dropdownBorder),
            ),
            child: DropdownButtonFormField<String>(
              value: _budgetDropdown,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
                border: InputBorder.none,
                hintText: "Type budget",
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFB0B0B0),
                ),
              ),
              icon: Icon(Icons.keyboard_arrow_down_rounded, size: 22.sp),
              items: dropdownItems.map((v) {
                return DropdownMenuItem(
                  value: v,
                  child: Text(
                    v,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: kText,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (v) {
                setState(() {
                  _budgetError = false;
                  _budgetDropdown = v;
                  _budgetQuick = null;
                });
              },
            ),
          ),

          if (_budgetError) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 16.sp,
                  color: Colors.red,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "Your should put a price for move forward",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],

          SizedBox(height: 16.h),
          Text(
            "SELECT COST",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFB0B0B0),
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 10.h),

          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: quickCosts.map((c) {
              final selected = _budgetQuick == c;
              return InkWell(
                onTap: () => _pickQuickBudget(c),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? kLime.withOpacity(0.30) : kChipBg,
                    borderRadius: BorderRadius.circular(999.r),
                    border: Border.all(
                      color: selected ? kLime : Colors.transparent,
                    ),
                  ),
                  child: Text(
                    c,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: selected ? Colors.black : const Color(0xFF505050),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 80.h),
        ],
      ),
    );
  }

  // -----------------------
  //  Common small widgets
  // -----------------------
  Widget _fieldLabel(String t) {
    return Text(
      t,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 13.sp,
        fontWeight: FontWeight.w700,
        color: kText,
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kBorder),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFB0B0B0),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          suffixIcon: suffix == null
              ? null
              : Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: suffix,
                ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 28.w,
            minHeight: 28.w,
          ),
        ),
        style: GoogleFonts.plusJakartaSans(
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
          color: kText,
        ),
      ),
    );
  }

  Widget _pillChip({
    required String text,
    required bool selected,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? Colors.black : kChipBg,
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : const Color(0xFF4E4E4E),
              ),
            ),
            if (!selected && trailing != null) ...[
              SizedBox(width: 6.w),
              Icon(Icons.add, size: 16.sp, color: const Color(0xFF4E4E4E)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _selectedChip({required String text, required VoidCallback onRemove}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: kLime.withOpacity(0.20),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: kLime),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 8.w),
          InkWell(
            onTap: onRemove,
            child: Icon(Icons.close_rounded, size: 16.sp, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _radioCard({
    required String title,
    required String subtitle,
    required ProjectSize value,
  }) {
    final selected = _projectSize == value;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Radio<ProjectSize>(
            value: value,
            groupValue: _projectSize,
            activeColor: Colors.green,
            onChanged: (v) => setState(() => _projectSize = v),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: kText,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: kMuted,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          if (selected)
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 18.sp,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: PageView(
        controller: _page,
        physics: const NeverScrollableScrollPhysics(),
        children: [_step1(), _step2(), _step3(), _step4()],
      ),
      bottomNavigationBar: _bottomButton(),
    );
  }
}

/// =======================
///  PREVIEW SCREEN
/// =======================
class JobPreviewScreen extends StatelessWidget {
  final JobDraft draft;
  final VoidCallback onEdit;
  final VoidCallback onPublish;

  const JobPreviewScreen({
    super.key,
    required this.draft,
    required this.onEdit,
    required this.onPublish,
  });

  static const Color kBorder = Color(0xFFE6E7EB);
  static const Color kMuted = Color(0xFF7A7A7A);
  static const Color kText = Color(0xFF111111);
  static const Color kLime = Color(0xFFCAFF45);

  String _sizeLabel(ProjectSize s) {
    switch (s) {
      case ProjectSize.large:
        return "Large\nExtended or multifaceted tasks [estimate : 1+ day ]";
      case ProjectSize.medium:
        return "Medium\nPrecisely defined projects [estimate : 6 - 10 hours]";
      case ProjectSize.small:
        return "Small\nSimple and efficient tasks [estimate : 4 - 6 hours]";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.sp,
            color: kText,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Job Preview",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: kText,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _openMenu(context),
            icon: Icon(Icons.more_vert_rounded, size: 22.sp, color: kText),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView(
          children: [
            SizedBox(height: 12.h),
            Text(
              "Job title",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: kMuted,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              draft.title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: kText,
                height: 1.25,
              ),
            ),

            SizedBox(height: 18.h),
            Text(
              "Added categories",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: kMuted,
              ),
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: draft.categories.map((c) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: kLime.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(999.r),
                    border: Border.all(color: kLime),
                  ),
                  child: Text(
                    c.name,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 18.h),
            Text(
              "Project size",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: kMuted,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: kBorder),
              ),
              child: Text(
                _sizeLabel(draft.size),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: kText,
                  height: 1.35,
                ),
              ),
            ),

            SizedBox(height: 18.h),
            Text(
              "Description",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: kMuted,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: kBorder),
              ),
              child: Text(
                draft.description.isEmpty ? "-" : draft.description,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: kText,
                  height: 1.35,
                ),
              ),
            ),

            SizedBox(height: 18.h),
            Text(
              "Attached files",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: kMuted,
              ),
            ),
            SizedBox(height: 10.h),
            if (draft.files.isEmpty)
              Text(
                "-",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: kText,
                ),
              )
            else
              ...draft.files.map((f) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    children: [
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: kBorder),
                        ),
                        child: Icon(
                          Icons.insert_drive_file_rounded,
                          size: 18.sp,
                          color: kMuted,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              f.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                color: kText,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              f.sizeLabel,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: kMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

            SizedBox(height: 18.h),
            Text(
              "Project cost",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: kMuted,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: kBorder),
              ),
              child: Text(
                draft.budget,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                  color: kText,
                ),
              ),
            ),

            SizedBox(height: 26.h),
            SafeArea(
              top: false,
              child: Container(
                height: 54.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0D2C),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: InkWell(
                  onTap: onPublish,
                  child: Center(
                    child: Text(
                      "Publish",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 18.h),
          ],
        ),
      ),
    );
  }

  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.circular(99.r),
                ),
              ),
              SizedBox(height: 14.h),
              _sheetItem(
                context,
                "Edit Job Post",
                onTap: () {
                  Navigator.pop(context);
                  onEdit();
                },
              ),
              _sheetItem(
                context,
                "Save as a draft",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              _sheetItem(
                context,
                "Delete the Job Post",
                destructive: true,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 6.h),
              _sheetItem(
                context,
                "Cancel",
                onTap: () => Navigator.pop(context),
                isCancel: true,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }

  Widget _sheetItem(
    BuildContext context,
    String text, {
    VoidCallback? onTap,
    bool destructive = false,
    bool isCancel = false,
  }) {
    final color = destructive ? Colors.red : kText;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        alignment: Alignment.center,
        child: Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: isCancel ? FontWeight.w800 : FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }
}

/// =======================
///  SUCCESS SCREEN
/// =======================
class JobPostedSuccessScreen extends StatelessWidget {
  const JobPostedSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 88.w,
                height: 88.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF2ECC71),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 48.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                "Job posted successfully.",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Container(
                height: 54.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0D2C),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: InkWell(
                  onTap: () => Navigator.popUntil(context, (r) => r.isFirst),
                  child: Center(
                    child: Text(
                      "Go to Discovery Page",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================
///  DASHED BORDER (no plugin)
/// =======================
class DashedBorder extends StatelessWidget {
  final Widget child;
  final double radius;
  const DashedBorder({super.key, required this.child, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedPainter(radius: radius),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: child,
      ),
    );
  }
}

class _DashedPainter extends CustomPainter {
  final double radius;
  _DashedPainter({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 8.0;
    const dashSpace = 6.0;

    final paint = Paint()
      ..color = const Color(0xFFE6E7EB)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().first;

    double distance = 0.0;
    while (distance < metrics.length) {
      final next = distance + dashWidth;
      final extract = metrics.extractPath(distance, next);
      canvas.drawPath(extract, paint);
      distance = next + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedPainter oldDelegate) {
    return oldDelegate.radius != radius;
  }
}

class StepItem {
  final String id;
  final String title;
  final IconData icon;
  final String number; // 1,2,3 bubble
  StepItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.number,
  });
}

class CategoryItem {
  final String id;
  final String name;
  CategoryItem(this.id, this.name);
}

enum ProjectSize { large, medium, small }

class AttachedFile {
  final String name;
  final String sizeLabel; // "1.2 MB"
  AttachedFile(this.name, this.sizeLabel);
}

class JobDraft {
  final String title;
  final List<CategoryItem> categories;
  final ProjectSize size;
  final String description;
  final List<AttachedFile> files;
  final String budget; // "SAR 600" or "$600-$1200"
  JobDraft({
    required this.title,
    required this.categories,
    required this.size,
    required this.description,
    required this.files,
    required this.budget,
  });
}
