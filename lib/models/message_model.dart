class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final String status;
  final String createdAt;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  // Factory constructor to create a MessageModel from a JSON object
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      senderId: json['sender_id'] ?? json['senderId'] ?? '',
      receiverId: json['receiver_id'] ?? json['receiverId'] ?? '',
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? json['createdAt'] ?? '',
    );
  }

  // Method to convert the MessageModel to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message,
      'status': status,
      'created_at': createdAt,
    };
  }
}

class MessageResponseModel {
  final bool isError;
  final String message;
  final MessageData? data;

  MessageResponseModel({
    required this.isError,
    required this.message,
    this.data,
  });

  // Factory constructor to create a MessageResponseModel from a JSON object
  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(
      isError: json['is_error'] ?? json['isError'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? MessageData.fromJson(json['data']) : null,
    );
  }

  // Method to convert the MessageResponseModel to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'is_error': isError,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class MessageData {
  final String? conversationId;
  final List<dynamic>? participants; // Can be expanded with a Participant model
  final List<MessageModel>? messages;

  MessageData({
    this.conversationId,
    this.participants,
    this.messages,
  });

  // Factory constructor to create a MessageData from a JSON object
  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      conversationId: json['conversation_id'] ?? json['conversationId'],
      participants: json['participants'] != null 
          ? List<dynamic>.from(json['participants']) 
          : null,
      messages: json['messages'] != null
          ? (json['messages'] as List).map((m) => MessageModel.fromJson(m)).toList()
          : null,
    );
  }

  // Method to convert the MessageData to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'conversation_id': conversationId,
      'participants': participants,
      'messages': messages?.map((m) => m.toJson()).toList(),
    };
  }
}