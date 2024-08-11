// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatPreviewAdapter extends TypeAdapter<ChatPreview> {
  @override
  final int typeId = 1;

  @override
  ChatPreview read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatPreview(
      chatId: fields[0] as String,
      otherUserId: fields[1] as String,
      otherUserName: fields[2] as String,
      lastMessage: fields[3] as String,
      timestamp: fields[4] as String,
      image: fields[5] as String,
      unreadCount: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChatPreview obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.chatId)
      ..writeByte(1)
      ..write(obj.otherUserId)
      ..writeByte(2)
      ..write(obj.otherUserName)
      ..writeByte(3)
      ..write(obj.lastMessage)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.unreadCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatPreviewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
