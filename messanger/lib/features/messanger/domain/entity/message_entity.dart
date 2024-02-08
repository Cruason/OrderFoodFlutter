class MessageEntity {
  final int? id;
  final int? senderId;
  final String? message;
  final DateTime? timeStamp;
  final bool isRed;

  MessageEntity(
      { this.id,
       this.senderId,
       this.message,
       this.timeStamp,
       required this.isRed});

}
