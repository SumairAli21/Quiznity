import 'package:englify_app/UI/views/teacher_flow/teacher_home/teacher_home_view_model.dart';
import 'package:englify_app/UI/widgets/custom_class_card.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TeacherHomeView extends StatelessWidget {
  const TeacherHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;
    final isSmall = context.isShort;
    final isTablet = context.isTablet;

    final headerFontSize = isLandscape
        ? (isTablet ? 20.0 : 16.0)
        : (isTablet ? 30.0 : isSmall ? 20.0 : 26.0);

    final subFontSize = isTablet ? 15.0 : isSmall ? 12.0 : 14.0;

    final topPadding = isLandscape
        ? (isTablet ? 10.0 : 6.0)
        : (isTablet ? 24.0 : isSmall ? 10.0 : 16.0);

    final searchHeight = isLandscape
        ? (isTablet ? 50.0 : 42.0)
        : (isTablet ? 56.0 : 48.0);

    final gridCrossCount = isTablet
        ? (isLandscape ? 4 : 3)
        : (isLandscape ? 3 : 2);

    final gridAspectRatio = isTablet
        ? (isLandscape ? 1.2 : 0.85)
        : (isLandscape ? 1.1 : 0.70);

    final fabSize = isTablet ? 36.0 : isLandscape ? 24.0 : 32.0;
    final fabPad = isTablet ? 16.0 : isLandscape ? 10.0 : 14.0;
    final fabBottom = isLandscape
        ? (isTablet ? 16.0 : 12.0)
        : (isTablet ? 24.0 : 70.0);

    final hPadding = isTablet ? 32.0 : 24.0;

    return ViewModelBuilder<TeacherHomeViewModel>.reactive(
      viewModelBuilder: () => TeacherHomeViewModel(),
      onViewModelReady: (model) => model.loadClassrooms(),
      builder: (context, model, child) {
        return SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                // Background
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/dies_logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
                // Subtle overlay to keep header/search text readable.
                Positioned.fill(
                  child: Container(color: Colors.black.withOpacity(0.25)),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header + Search
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          hPadding, topPadding, hPadding, 0),
                      child: isLandscape
                          ? Row(
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome back! 👋",
                                      style: TextStyle(
                                        fontSize: headerFontSize,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "heading",
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Learn and grow daily.",
                                      style: TextStyle(
                                        fontSize: subFontSize,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: SizedBox(
                                    height: searchHeight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(28),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withOpacity(0.1),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        cursorColor: Colors.black,
                                        controller: model.searchcontroller,
                                        onChanged: model.onSearchChanged,
                                        decoration: InputDecoration(
                                          hintText: "Search Classroom",
                                          hintStyle: TextStyle(
                                              fontSize: subFontSize),
                                          prefixIcon: Icon(Icons.search,
                                              color: Colors.grey[400],
                                              size: 20),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(28),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(28),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF2F6BFF), width: 1.6),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Welcome back! 👋",
                                          style: TextStyle(
                                            fontSize: headerFontSize,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "heading",
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: isSmall ? 2 : 4),
                                        Text(
                                          "Learn and grow daily.",
                                          style: TextStyle(
                                            fontSize: subFontSize,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: isSmall ? 10 : 16),
                                SizedBox(
                                  height: searchHeight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(28),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.1),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: TextField(
                                      cursorColor: Colors.black,
                                      controller: model.searchcontroller,
                                      onChanged: model.onSearchChanged,
                                      decoration: InputDecoration(
                                        hintText: "Search Classroom",
                                        prefixIcon: Icon(Icons.search,
                                            color: Colors.grey[400]),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(28),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(28),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF2F6BFF), width: 1.6),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: isSmall ? 10 : 16),
                              ],
                            ),
                    ),

                    if (isLandscape) const SizedBox(height: 8),

                    // Grid
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: hPadding),
                        child: model.isBusy
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              )
                            : model.classrooms.isEmpty
                                // ✅ Fix — SingleChildScrollView wrap kiya
                                ? Center(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            model.searchcontroller.text
                                                    .isNotEmpty
                                                ? Icons.search_off
                                                : Icons.class_outlined,
                                            size: isTablet ? 80 : 64,
                                            color: Colors.white70,
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            model.searchcontroller.text
                                                    .isNotEmpty
                                                ? "No classrooms found"
                                                : "No classrooms yet.\nCreate one to get started!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize:
                                                  isTablet ? 18 : 16,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          if (model.searchcontroller.text
                                              .isNotEmpty)
                                            TextButton(
                                              onPressed: model.clearSearch,
                                              child: const Text(
                                                "Clear Search",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  )
                                : GridView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(
                                      bottom: isLandscape ? 16 : 100,
                                    ),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: gridCrossCount,
                                      crossAxisSpacing:
                                          isTablet ? 16 : 12,
                                      mainAxisSpacing: isTablet ? 16 : 12,
                                      childAspectRatio: gridAspectRatio,
                                    ),
                                    itemCount: model.classrooms.length,
                                    itemBuilder: (context, index) {
                                      final classroom =
                                          model.classrooms[index];
                                      return ClassroomCard(
                                        classroomName: classroom['name'],
                                        classroomId: classroom['id'],
                                        imageUrl: classroom['imageUrl'],
                                        onTap: () => model
                                            .onClassroomTap(classroom),
                                      );
                                    },
                                  ),
                      ),
                    ),
                  ],
                ),

                // FAB
                Positioned(
                  right: hPadding,
                  bottom: fabBottom,
                  child: GestureDetector(
                    onTap: model.oncreateclassroom,
                    child: Container(
                      padding: EdgeInsets.all(fabPad),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2F6BFF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add,
                          size: fabSize, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}