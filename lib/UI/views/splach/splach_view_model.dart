import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/notification_service.dart';
import 'package:englify_app/services/user_service.dart';
import 'package:englify_app/utils/student_routing.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplachViewModel extends BaseViewModel {

 final _localstorage=
 locator<LocalStorageService>();

 final _navigationservice=
 locator<NavigationService>();

 final _authservice=
 locator<AuthService>();

 final _notificationservice=
 locator<NotificationService>();

 final _userservice=
 locator<UserService>();


 Future<void> runsetuplogic() async {

 await Future.delayed(
 Duration(seconds:3)
 );


 final isfirstlaunch=
 await _localstorage
 .isfirstlaunch();

 if(isfirstlaunch){

 _navigationservice
 .replaceWithOnbordingView();

 return;

 }



 final cachedrole=
 await _localstorage
 .getuserrole();

 if(cachedrole==null){

 _navigationservice
 .replaceWithRoleSelection();

 return;

 }



 final login=
 await _localstorage
 .getislogin();

 if(!login){

 _navigationservice
 .replaceWithAuthView();

 return;

 }



 // Firestore is the source of truth for the role. Re-read it for the signed-in
 // user so a stale local cache can never open the wrong flow. Fall back to the
 // cached role only when the user or the network read is unavailable (offline).
 final user=
 _authservice.currentuser;

 String role=cachedrole;

 if(user!=null){

 try{

 final firestorerole=
 await _userservice
 .getUserrole(user.uid);

 if(firestorerole!=null){

 role=firestorerole;

 await _localstorage
 .saveuserrole(firestorerole);

 }

 }

 catch(e){

 print(
 "Role lookup failed, using cached role: $e"
 );

 }

 }



 // TEACHER FLOW
 if(role=="teacher"){

 _navigationservice
 .replaceWithTeacherBottomTabView();

 await _notificationservice
 .handleLaunchDeepLink();

 return;

 }



 // STUDENT FLOW

 if(user!=null){

 try{

 // Enrolled -> home, no saved name -> personalization, otherwise the
 // join-by-code screen. Shared with login / Google / Apple sign-in so the
 // one-time personalization rule cannot drift between entry points.
 // See lib/utils/student_routing.dart.
 final destination=
 await routeSignedInStudent(
 user.uid
 );

 if(destination==
 StudentDestination.home){

 await _notificationservice
 .handleLaunchDeepLink();

 }

 return;

 }

 catch(e){

 print(
 "Error routing student: $e"
 );

 _navigationservice
 .replaceWithPersonalizationView();

 return;

 }

 }


 // fallback
 _navigationservice
 .replaceWithPersonalizationView();

 }

}
