import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<List<NotificationPermission>> requestUserPermissions(
    BuildContext context,
    {
    // if you only intends to request the permissions until app level, set the channelKey value to null
    required String? channelKey,
    required List<NotificationPermission> permissionList}) async {
  // Check if the basic permission was conceived by the user
  if (!await requestBasicPermissionToSendNotifications()) {
    return [];
  }

  // Check which of the permissions you need are allowed at this time
  List<NotificationPermission> permissionsAllowed = await AwesomeNotifications()
      .checkPermissionList(channelKey: channelKey, permissions: permissionList);

  // If all permissions are allowed, there is nothing to do
  if (permissionsAllowed.length == permissionList.length) {
    return permissionsAllowed;
  }

  // Refresh the permission list with only the disallowed permissions
  List<NotificationPermission> permissionsNeeded =
      permissionList.toSet().difference(permissionsAllowed.toSet()).toList();

  // Check if some of the permissions needed request user's intervention to be enabled
  List<NotificationPermission> lockedPermissions = await AwesomeNotifications()
      .shouldShowRationaleToRequest(
          channelKey: channelKey, permissions: permissionsNeeded);

  // If there is no permissions depending on user's intervention, so request it directly
  if (lockedPermissions.isEmpty) {
    // Request the permission through native resources.
    await AwesomeNotifications().requestPermissionToSendNotifications(
        channelKey: channelKey, permissions: permissionsNeeded);

    // After the user come back, check if the permissions has successfully enabled
    permissionsAllowed = await AwesomeNotifications().checkPermissionList(
        channelKey: channelKey, permissions: permissionsNeeded);
  } else {
    // If you need to show a rationale to educate the user to conceived the permission, show it

    // ignore: use_build_context_synchronously
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color(0xfffbfbfb),
              title: const Text(
                'Awesome Notifications needs your permission',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/animated-clock.gif',
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    'To proceed, you need to enable the permissions above${channelKey?.isEmpty ?? true ? '' : ' on channel $channelKey'}:',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    lockedPermissions
                        .join(', ')
                        .replaceAll('NotificationPermission.', ''),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Deny',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    )),
                TextButton(
                  onPressed: () async {
                    // Request the permission through native resources. Only one page redirection is done at this point.
                    await AwesomeNotifications()
                        .requestPermissionToSendNotifications(
                            channelKey: channelKey,
                            permissions: lockedPermissions);

                    // After the user come back, check if the permissions has successfully enabled
                    permissionsAllowed = await AwesomeNotifications()
                        .checkPermissionList(
                            channelKey: channelKey,
                            permissions: lockedPermissions);

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ));
  }

  // Return the updated list of allowed permissions
  return permissionsAllowed;
}

requestBasicPermissionToSendNotifications() async {
  PermissionStatus? statusNotification =
      await Permission.notification.request();

  bool isGranted = statusNotification == PermissionStatus.granted;
  return isGranted;
}
