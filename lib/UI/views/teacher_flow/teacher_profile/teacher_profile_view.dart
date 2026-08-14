import 'package:englify_app/UI/views/teacher_flow/teacher_profile/teacher_profile_viewmodel.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TeacherProfileView extends StatelessWidget {
  const TeacherProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TeacherProfileViewmodel>.reactive(
      viewModelBuilder: () => TeacherProfileViewmodel(),
      onViewModelReady: (model)=> model.init(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset('assets/images/dies_logo.png',
                    fit: BoxFit.cover),
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.25)),
              ),
              SafeArea(
                child: model.isBusy
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white))
                    : Column(
                        children: [
                          // Top bar
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.rs(20),
                                vertical: context.rs(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Profile',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: context.rf(24),
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'heading',
                                    )),
                              ],
                            ),
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.rs(20)),
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  // Profile Card
                                  Container(
                                    padding: EdgeInsets.all(context.rs(10)),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.92),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        // Profile image
                                        GestureDetector(
                                          onTap: model.pickAndUploadImage,
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: context.rs(42),
                                                backgroundColor: Colors.grey[200],
                                                backgroundImage:
                                                    model.profileImageUrl != null
                                                        ? NetworkImage(
                                                            model.profileImageUrl!)
                                                        : null,
                                                child: model.profileImageUrl == null
                                                    ? Icon(Icons.person,
                                                        size: context.rs(36),
                                                        color: Colors.grey[400])
                                                    : null,
                                              ),
                                              if (model.isUploadingImage)
                                                Positioned.fill(
                                                  child: CircleAvatar(
                                                    radius: context.rs(36),
                                                    backgroundColor: Colors.black
                                                        .withOpacity(0.4),
                                                    child: SizedBox(
                                                      width: context.rs(20),
                                                      height: context.rs(20),
                                                      child:
                                                          const CircularProgressIndicator(
                                                              color: Colors.white,
                                                              strokeWidth: 2),
                                                    ),
                                                  ),
                                                ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      context.rs(4)),
                                                  decoration: const BoxDecoration(
                                                      color: Color(0xFF2F6BFF),
                                                      shape: BoxShape.circle),
                                                  child: Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.white,
                                                      size: context.rs(12)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: context.rs(14)),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Username — tap to edit
                                              GestureDetector(
                                                onTap: () =>
                                                    _showUsernameDialog(
                                                        context, model),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        model.username,
                                                        style: TextStyle(
                                                          fontSize:
                                                              context.rf(18),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black87,
                                                        ),
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: context.rs(4)),
                                                    Icon(Icons.edit,
                                                        size: context.rs(14),
                                                        color: const Color(
                                                            0xFF2F6BFF)),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: context.rs(4)),

                                              // Email — tap to edit
                                              GestureDetector(
                                                onTap: () => _showEmailDialog(
                                                    context, model),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.email_outlined,
                                                        size: context.rs(13),
                                                        color: Colors.grey[500]),
                                                    SizedBox(
                                                        width: context.rs(3)),
                                                    Flexible(
                                                      child: Text(
                                                        model.email.isEmpty
                                                            ? 'Add email'
                                                            : model.email,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize:
                                                              context.rf(13),
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: context.rs(3)),
                                                    if (model.isUpdatingEmail)
                                                      SizedBox(
                                                        width: context.rs(12),
                                                        height: context.rs(12),
                                                        child:
                                                            const CircularProgressIndicator(
                                                          strokeWidth: 1.5,
                                                          color:
                                                              Color(0xFF2F6BFF),
                                                        ),
                                                      )
                                                    else
                                                      Icon(Icons.edit,
                                                          size: context.rs(12),
                                                          color: const Color(
                                                              0xFF2F6BFF)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: context.rs(16)),

                                  // Settings Card — score/level wali cheez nahi hai
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.92),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.06),
                                            blurRadius: 10),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        _buildToggleItem(
                                          context: context,
                                          icon: Icons.notifications_outlined,
                                          iconColor: Colors.orange,
                                          label: 'Notification',
                                          value: model.isNotificationEnabled,
                                          onChanged: (_) =>
                                              model.toggleNotification(),
                                        ),
                                        _divider(),
                                        _buildNavItem(
                                          context: context,
                                          icon: Icons.menu_book_outlined,
                                          iconColor: Colors.green,
                                          label: 'Rules',
                                          onTap: model.onRules,
                                        ),
                                        _divider(),
                                        _buildNavItem(
                                          context: context,
                                          icon: Icons.feedback_outlined,
                                          iconColor: Colors.teal,
                                          label: 'Feedback',
                                          onTap: model.onFeedback,
                                        ),
                                        _divider(),
                                        _buildNavItem(
                                          context: context,
                                          icon: Icons.description_outlined,
                                          iconColor: Colors.indigo,
                                          label: 'Terms of Service',
                                          onTap: model.onTerms,
                                        ),
                                        _divider(),
                                        _buildNavItem(
                                          context: context,
                                          icon: Icons.privacy_tip_outlined,
                                          iconColor: Colors.purple,
                                          label: 'Privacy Policy',
                                          onTap: model.onPrivacy,
                                        ),
                                        _divider(),
                                        _buildNavItem(
                                          context: context,
                                          icon: Icons.lock_outline,
                                          iconColor: model.isGoogleAccount
                                              ? Colors.grey
                                              : Colors.red,
                                          label: 'Change Password',
                                          onTap: model.isGoogleAccount
                                              ? null
                                              : model.onChangePassword,
                                          subtitle: model.isGoogleAccount
                                              ? 'Not available for Google accounts'
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: context.rs(16)),

                                  // Logout
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.92),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: _buildNavItem(
                                      context: context,
                                      icon: Icons.logout,
                                      iconColor: Colors.red,
                                      label: 'Logout',
                                      labelColor: Colors.red,
                                      onTap: () =>
                                          _showLogoutDialog(context, model),
                                    ),
                                  ),
                                  SizedBox(height: context.rs(16)),

                                  // Delete account
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.92),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: _buildNavItem(
                                      context: context,
                                      icon: Icons.delete_forever,
                                      iconColor: Colors.red,
                                      label: 'Delete Account',
                                      labelColor: Colors.red,
                                      onTap: () =>
                                          _showDeleteAccountDialog(
                                              context, model),
                                    ),
                                  ),
                                  SizedBox(height: context.rs(30)),
                                ],
                              ),
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

  void _showUsernameDialog(
      BuildContext context, TeacherProfileViewmodel model) {
    final controller = TextEditingController(text: model.username);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Edit Name'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                cursorColor: Colors.black,
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F6BFF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              model.updateUsername(controller.text.trim());
            },
            child: const Text('Save',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── Email update flow
  void _showEmailDialog(
      BuildContext context, TeacherProfileViewmodel model) {
    final controller = TextEditingController(text: model.email);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Update Email'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                cursorColor: Colors.black,
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter new email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F6BFF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _runEmailUpdate(context, model, controller.text.trim());
            },
            child: const Text('Save',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _runEmailUpdate(
      BuildContext context, TeacherProfileViewmodel model, String newEmail,
      {String? password}) async {
    final messenger = ScaffoldMessenger.of(context);
    final result = await model.updateEmail(newEmail, password: password);
    if (result == null) {
      messenger.showSnackBar(SnackBar(
        content: Text(
          'Verification link sent to $newEmail. '
          'Please verify it to finish updating your email.',
        ),
      ));
    } else if (result == 'requires-recent-login') {
      _showReauthForEmail(context, model, newEmail);
    } else {
      messenger.showSnackBar(SnackBar(content: Text(result)));
    }
  }

  void _showReauthForEmail(
      BuildContext context, TeacherProfileViewmodel model, String newEmail) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Confirm Password'),
        content: SingleChildScrollView(
          child: TextField(
            controller: controller,
            obscureText: true,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F6BFF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _runEmailUpdate(context, model, newEmail,
                  password: controller.text);
            },
            child: const Text('Confirm',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── Logout Dialog
  void _showLogoutDialog(
      BuildContext context, TeacherProfileViewmodel model) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: const SingleChildScrollView(
          child: Text('Are you sure you want to logout?'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              model.logout(context);
            },
            child: const Text('Logout',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── Delete Account flow
  void _showDeleteAccountDialog(
      BuildContext context, TeacherProfileViewmodel model) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Account',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: const SingleChildScrollView(
          child: Text(
            'This permanently deletes your account and your data. '
            'This action cannot be undone. Continue?',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if (model.isPasswordAccount) {
                _showReauthPasswordDialog(context, model);
              } else {
                _runDelete(context, model);
              }
            },
            child:
                const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showReauthPasswordDialog(
      BuildContext context, TeacherProfileViewmodel model) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Confirm Password'),
        content: SingleChildScrollView(
          child: TextField(
            controller: controller,
            obscureText: true,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _runDelete(context, model, password: controller.text);
            },
            child:
                const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _runDelete(BuildContext context, TeacherProfileViewmodel model,
      {String? password}) async {
    final messenger = ScaffoldMessenger.of(context);
    final error = await model.deleteAccount(password: password);
    if (error != null) {
      messenger.showSnackBar(SnackBar(content: Text(error)));
    }
  }

  Widget _buildToggleItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.rs(16), vertical: context.rs(4)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.rs(6)),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: context.rs(20)),
          ),
          SizedBox(width: context.rs(12)),
          Expanded(
              child: Text(label,
                  style: TextStyle(
                      fontSize: context.rf(15),
                      fontWeight: FontWeight.w500,
                      color: Colors.black87))),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              thumbColor: MaterialStateProperty.all(Colors.white),
              trackColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return const Color(0xFF2F6BFF);
                }
                return Colors.grey.shade400;
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback? onTap,
    String? subtitle,
    Color? labelColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.rs(16), vertical: context.rs(12)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(context.rs(6)),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: context.rs(20)),
            ),
            SizedBox(width: context.rs(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          fontSize: context.rf(15),
                          fontWeight: FontWeight.w500,
                          color: labelColor ?? Colors.black87)),
                  if (subtitle != null)
                    Text(subtitle,
                        style: TextStyle(
                            fontSize: context.rf(11),
                            color: Colors.grey[500])),
                ],
              ),
            ),
            if (onTap != null && labelColor == null)
              Icon(Icons.chevron_right,
                  color: Colors.grey[400], size: context.rs(20)),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Divider(height: 1, color: Colors.grey[200]),
      );
}
