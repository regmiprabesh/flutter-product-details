import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:product_description/main.dart';

class ContactSellerDialog extends StatefulWidget {
  const ContactSellerDialog({Key? key}) : super(key: key);

  @override
  _ContactSellerDialogState createState() => _ContactSellerDialogState();
}

class _ContactSellerDialogState extends State<ContactSellerDialog> {
  final TextEditingController messageController = TextEditingController();
  final RxString messageError = ''.obs;

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'message_channel',
      'Message Notifications',
      channelDescription: 'Notifications for sent messages',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Message Sent',
      'Your message has been sent successfully!',
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.contact_mail,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 8),
                          const Text(
                            'Contact Seller',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Obx(() => _buildTextField(
                            controller: messageController,
                            label: 'Message',
                            hint: 'Type your message here...',
                            maxLines: 5,
                            errorText: messageError.value,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_validateInput()) {
                        //Add logic to submit the message to backend server
                        debugPrint(messageController.text);
                        Get.back();
                        await _showNotification(); // Show notification
                        Get.snackbar(
                          'Success',
                          'Your message has been sent!',
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.white,
                          margin: EdgeInsets.symmetric(
                            vertical: GetPlatform.isAndroid ? 90.0 : 60.0,
                            horizontal: 16,
                          ),
                          backgroundColor: Colors.green,
                        );
                        messageController.clear();
                        messageError.value = '';
                      }
                    },
                    icon: const Icon(Icons.send, color: Colors.white),
                    label: const Text(
                      'Send',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Get.theme.primaryColor,
              ),
            ),
            errorText: errorText?.isNotEmpty == true ? errorText : null,
          ),
        ),
      ],
    );
  }

  bool _validateInput() {
    if (messageController.text.trim().isEmpty) {
      messageError.value = 'Please enter your message';
      return false;
    }
    messageError.value = '';
    return true;
  }
}
