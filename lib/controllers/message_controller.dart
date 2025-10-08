import 'package:get/get.dart';
import '../models/message_model.dart';
import '../services/api_service.dart';
import '../services/rabbitmq_service.dart';

class MessageController extends GetxController {
  var messages = <MessageModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Connect to RabbitMQ when the controller is initialized
    RabbitMQService.connect().then((_) {
      // Setup message listener
      RabbitMQService.listenToMessages().listen((messageContent) {
        // Handle incoming messages
        // This would need to be parsed as a MessageModel in real implementation
        Get.snackbar('New Message', messageContent);
      });
    });
  }

  @override
  void onClose() {
    // Disconnect from RabbitMQ when the controller is closed
    RabbitMQService.disconnect();
    super.onClose();
  }

  // Get messages for a user
  Future<void> getMessages(String receiverId) async {
    try {
      isLoading.value = true;
      final response = await ApiService.viewMessages(receiverId);
      
      if (response['is_error'] == false && response['data'] != null) {
        final messageData = response['data'];
        if (messageData['messages'] != null) {
          messages.value = (messageData['messages'] as List)
              .map((m) => MessageModel.fromJson(m))
              .toList();
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get messages: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // Send a message to a user
  Future<void> sendMessage(String receiverId, String message) async {
    try {
      isLoading.value = true;
      final response = await ApiService.sendMessage(receiverId, message);
      
      if (response['is_error'] == false) {
        Get.snackbar('Success', response['message']);
        
        // Add the sent message to the list
        if (response['data'] != null) {
          final sentMessage = MessageModel.fromJson(response['data']);
          messages.add(sentMessage);
        }
        
        // Also broadcast the message via RabbitMQ
        final broadcastMessage = {
          'senderId': 'current_user_id', // This would be replaced with actual user ID
          'receiverId': receiverId,
          'message': message,
          'timestamp': DateTime.now().toIso8601String(),
        };
        await RabbitMQService.sendMessage(broadcastMessage.toString());
      } else {
        Get.snackbar('Error', response['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to send message: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}