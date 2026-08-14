import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Central mapping of backend exceptions to concise, user-facing messages, plus
/// a themed SnackBar helper. Keeping this in one place guarantees every flow
/// surfaces the same wording and no failure stays silent.

/// Maps a [FirebaseAuthException] to a short message safe to show a user.
String authErrorMessage(FirebaseAuthException e) {
  if (kDebugMode) debugPrint('🔒 Auth error: ${e.code} — ${e.message}');
  switch (e.code) {
    case 'email-already-in-use':
      return 'This email is already registered. Please log in instead.';
    case 'invalid-email':
      return 'Please enter a valid email address.';
    case 'user-not-found':
      return 'No account found for that email.';
    case 'wrong-password':
    case 'invalid-credential':
      return 'Incorrect email or password.';
    case 'weak-password':
      return 'Password is too weak. Use 8+ characters with upper, lower and a number.';
    case 'user-disabled':
      return 'This account has been disabled.';
    case 'too-many-requests':
      return 'Too many attempts. Please wait a moment and try again.';
    case 'network-request-failed':
      return 'Network unavailable. Check your connection and try again.';
    case 'operation-not-allowed':
      return 'Email/password sign-in is currently unavailable.';
    case 'requires-recent-login':
      return 'Please sign in again to continue.';
    default:
      return 'Authentication failed. Please try again.';
  }
}

/// Maps a Firestore [FirebaseException] to a short message safe to show a user.
String firestoreErrorMessage(FirebaseException e) {
  if (kDebugMode) debugPrint('🔥 Firestore error: ${e.code} — ${e.message}');
  switch (e.code) {
    case 'permission-denied':
      return 'You don\'t have permission to do that.';
    case 'unavailable':
      return 'Service temporarily unavailable. Please try again.';
    case 'unauthenticated':
      return 'Your session expired. Please sign in again.';
    default:
      return 'Something went wrong. Please try again.';
  }
}

/// Shows a floating SnackBar. Resolves the app-level [ScaffoldMessenger], so it
/// works from any context under [MaterialApp]. Guard the caller with
/// `context.mounted` when invoking after an `await`.
void showAppSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor:
          isError ? const Color(0xFFD32F2F) : const Color(0xFF2F6BFF),
      duration: const Duration(seconds: 3),
    ),
  );
}
