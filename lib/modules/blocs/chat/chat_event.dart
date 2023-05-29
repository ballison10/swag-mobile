part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatAddChatsEvent extends ChatEvent {

  final List<ChatData> chats;

  ChatAddChatsEvent(this.chats);
}

class ChatSetMyUser extends ChatEvent {

  final User user;

  ChatSetMyUser(this.user);
}

class ChatUpdateMessageEvent extends ChatEvent {

  final ChatData chatData;
  final BaseMessage message;
  final List<ChatData> chats;

  ChatUpdateMessageEvent({
    required this.chatData, 
    required this.message,
    required this.chats,
  });

  List<ChatData> getUpdatedChats() {

    List<ChatData> chats = this.chats;
    ChatData newChatData = this.chatData;
    int index = this.chats.indexOf(this.chatData);

    newChatData.messages.add(this.message);
    this.chats[index] = this.chatData;

    return chats;
  }
}

class ChatLoadinFileEvent extends ChatEvent {

  final bool isLoadingFile;

  ChatLoadinFileEvent(this.isLoadingFile);
}

class ChatAddMessageVideoController extends ChatEvent {

  final CachedVideoPlayerController newController;
  final List<CachedVideoPlayerController> controllers;

  ChatAddMessageVideoController({
    required this.newController, 
    required this.controllers,
  });

  List<CachedVideoPlayerController> updatedControllers() {

    this.controllers.add(this.newController);
    return this.controllers; 
  }
}
