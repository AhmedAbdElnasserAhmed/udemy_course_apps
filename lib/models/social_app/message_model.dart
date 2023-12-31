class MessageModel
{
  late String? senderId;
  late String? receiverId;
  late String? dataTime;
  late String? text;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dataTime,
    this.text,
  });

  MessageModel.fromJson(Map<String , dynamic> json)
  {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dataTime = json['dataTime'];
    text = json['text'];
  }

  Map<String , dynamic> toMap()
  {
    return
      {
        'senderId' : senderId,
        'receiverId' : receiverId,
        'dataTime' : dataTime,
        'text' : text,
      };
  }
}