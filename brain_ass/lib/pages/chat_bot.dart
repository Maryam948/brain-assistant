// pages/chat_bot.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/serviece/chatboot_service.dart';

class ChatBot extends StatefulWidget {
  static const String routeName = '/chat_bot';
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  String get currentTime {
    final now = TimeOfDay.now();
    return "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    // رسالة ترحيب أولية
    _messages.add({
      "role": "bot",
      "text": "Hello! How can I help you today?",
      "time": currentTime,
    });
  }

  void _sendMessage() async {
    final query = _controller.text.trim();
    if (query.isEmpty || _isLoading) return;

    final time = currentTime;
    setState(() {
      _messages.add({"role": "user", "text": query, "time": time});
      _isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    final result = await ChatbotService.sendMessage(query);

    setState(() {
      _isLoading = false;
      _messages.add({
        "role": "bot",
        "text": result != null
            ? result["answer"] ?? "No answer found."
            : "Sorry, I couldn't connect to the server.",
        "time": currentTime,
      });
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("Assets/chat_rebot.png"),
            ),
            const SizedBox(width: 17),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Brain Assistant",
                  style: GoogleFonts.poppins(
                    color: const Color(0xff242424),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "your ai health companion",
                  style: GoogleFonts.poppins(
                    color: const Color(0xff757575),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        titleSpacing: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xffC2C2C2), height: 1),
        ),
      ),

      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 120, left: 20, right: 20, bottom: 20),
        itemCount: _messages.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          // Typing indicator
          if (index == _messages.length) return _buildTypingIndicator();

          final msg = _messages[index];
          final isUser = msg["role"] == "user";

          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: isUser ? _buildUserBubble(msg) : _buildBotBubble(msg),
          );
        },
      ),

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(color: const Color(0xffC2C2C2), height: 1),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 10),
            child: Container(
              height: 43,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (_) => _sendMessage(),
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                          hintText: "Ask about your brain health....",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xffC9C9C9),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _isLoading ? null : _sendMessage,
                    child: Container(
                      width: 31,
                      height: 31,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: _isLoading ? Colors.grey : const Color(0xff096CE1),
                        shape: BoxShape.circle,
                      ),
                      child: Transform.rotate(
                        angle: -2.35,
                        child: const Icon(Icons.send, size: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotBubble(Map<String, String> msg) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage("Assets/chat_rebot.png"),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xffEDEDED),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                msg["text"] ?? "",
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              msg["time"] ?? "",
              style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserBubble(Map<String, String> msg) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.65,
            ),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xff096CE1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              msg["text"] ?? "",
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xffEDEDED)),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            msg["time"] ?? "",
            style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage("Assets/chat_rebot.png"),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xffEDEDED),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dot(0),
              const SizedBox(width: 4),
              _dot(150),
              const SizedBox(width: 4),
              _dot(300),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dot(int delayMs) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 1.0),
      duration: Duration(milliseconds: 600 + delayMs),
      builder: (_, value, __) => Opacity(
        opacity: value,
        child: const CircleAvatar(
          radius: 4,
          backgroundColor: Color(0xff096CE1),
        ),
      ),
    );
  }
}