import 'package:englify_app/UI/views/student_flow/student_fav/student_fav_viewmodel.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StudentFavView extends StatelessWidget {
  const StudentFavView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentFavViewmodel>.reactive(
      viewModelBuilder: () => StudentFavViewmodel(),
      onViewModelReady: (model)=> model.init(),
      builder: (context, model, child) {
        return  Scaffold(
          body: Stack(
            children: [
              // ── Background
              Positioned.fill(
                child: Image.asset(
                  'assets/images/dies_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.rs(10),),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.rs(20), vertical: context.rs(14)),
                      child: Row(
                        children: [
                          Text(
                            'Favorite Topics',
                            style: TextStyle(
                              fontSize: context.rf(26),
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontFamily: 'heading',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Search bar
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.rs(20)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: model.searchController,
                          onChanged: model.onSearchChange,
                          decoration: InputDecoration(
                            hintText: 'Search topics',
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: context.rf(14)),
                            prefixIcon: Icon(Icons.search,
                                color: Colors.grey[400]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide.none,
                            ),
                            // BorderSide.none opts a field out of the themed
                            // focus ring entirely, so it is set explicitly here
                            // (at this field's own radius) to stay consistent.
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: const BorderSide(
                                  color: Color(0xFF2F6BFF), width: 1.6),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: context.rs(16), vertical: context.rs(14)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.rs(16)),

                    // ── List
                    Expanded(
                      child: model.isBusy
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Color(0xFF2F6BFF)),
                            )
                          : model.filteredFavourites.isEmpty
                              ? Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.bookmark_border,
                                            size: context.rs(64),
                                            color: Colors.grey[400]),
                                        SizedBox(height: context.rs(16)),
                                        Text(
                                          model.searchController.text
                                                  .isNotEmpty
                                              ? 'No topics found'
                                              : 'No favourites yet.\nBookmark a lesson to see it here!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: context.rf(16),
                                            color: Colors.grey[500],
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: context.rs(20)),
                                  itemCount:
                                      model.filteredFavourites.length,
                                  itemBuilder: (context, index) {
                                    final fav =
                                        model.filteredFavourites[index];
                                    return _FavCard(
                                      fav: fav,
                                      onTap: () =>
                                          model.onFavTap(context, fav),
                                      index: index,
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

  class _FavCard extends StatelessWidget {
  final Map<String, dynamic> fav;
  final VoidCallback onTap;
  final int index;

  const _FavCard({
    required this.fav,
    required this.onTap,
    required this.index,
  });

  // Alternating highlight color like image
  Color get _highlightColor {
    final colors = [
      Colors.transparent,
      const Color(0xFFFFF3CD), // yellow tint
      Colors.transparent,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final title = fav['lessonTitle'] as String? ?? 'Lesson';
    final imageUrl = fav['imageUrl'] as String?;
    final className = fav['className'] as String? ?? '';
    final addedAt = fav['addedAt'];

    // Format date
    String dateText = '';
    if (addedAt != null) {
      try {
        final dt = (addedAt as dynamic).toDate() as DateTime;
        dateText =
            '${dt.day}/${_monthName(dt.month)}/${dt.year}';
      } catch (_) {}
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: context.rs(12)),
        padding: EdgeInsets.all(context.rs(12)),
        decoration: BoxDecoration(
          color: _highlightColor == Colors.transparent
              ? Colors.white
              : _highlightColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Lesson image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      width: context.rs(70),
                      height: context.rs(70),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _placeholder(context),
                    )
                  : _placeholder(context),
            ),
            SizedBox(width: context.rs(12)),

            // ── Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: context.rf(15),
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: context.rs(4)),
                  Text(
                    className,
                    style: TextStyle(
                      fontSize: context.rf(13),
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (dateText.isNotEmpty) ...[
                    SizedBox(height: context.rs(6)),
                    Text(
                      dateText,
                      style: TextStyle(
                        fontSize: context.rf(11),
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // ── Bookmark icon
            Icon(
              Icons.bookmark,
              color: const Color(0xFFFFD700),
              size: context.rs(22),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      width: context.rs(70),
      height: context.rs(70),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.image_not_supported,
          color: Colors.grey[400], size: context.rs(28)),
    );
  }

  String _monthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }
  }

