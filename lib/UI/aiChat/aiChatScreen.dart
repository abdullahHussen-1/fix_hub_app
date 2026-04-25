import 'package:dio/dio.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart' as intl;

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;

  final String _apiKey =
      "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";
  final String _baseUrl = "https://api.groq.com/openai/v1/chat/completions";
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _messages.add({
      "role": "ai",
      "message": "أهلاً بك في مساعد FixHub. كيف يمكنني مساعدتك اليوم؟",
      "time": intl.DateFormat('hh:mm a').format(DateTime.now()),
    });
  }

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userMessage = _controller.text;
    setState(() {
      _messages.add({
        "role": "user",
        "message": userMessage,
        "time": intl.DateFormat('hh:mm a').format(DateTime.now()),
      });
      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    try {
      final response = await _dio.post(
        _baseUrl,
        options: Options(
          headers: {
            "Authorization": "Bearer $_apiKey",
            "Content-Type": "application/json",
          },
        ),
        data: {
          "model": "llama-3.3-70b-versatile",
          "messages": [
            {
              "role": "system",
              "content": "أنت خبير صيانة ذكي لتطبيق FixHub. "
                  "تحدث بالعامية المصرية المهذبة والراقية (بدون مبالغة في المصطلحات الشعبية). "
                  "اجعل إجاباتك منظمة، دقيقة، ومفيدة جداً للمستخدم. "
                  "استخدم أسلوباً ودوداً ومحترماً."
            },
            {"role": "user", "content": userMessage}
          ],
          "temperature": 0.6,
        },
      );

      if (response.statusCode == 200) {
        final aiResponse = response.data['choices'][0]['message']['content'];
        setState(() {
          _messages.add({
            "role": "ai",
            "message": aiResponse.trim(),
            "time": intl.DateFormat('hh:mm a').format(DateTime.now()),
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          "role": "ai",
          "message": "عذراً، حدث خطأ أثناء الاتصال. يرجى المحاولة مرة أخرى.",
          "time": intl.DateFormat('hh:mm a').format(DateTime.now()),
        });
      });
    } finally {
      setState(() => _isLoading = false);
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primaryBackgroundBlue,
          // --- جعل الـ AppBar بالإنجليزية ---
          title: const Text(
            "FixHub AI Assistant",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(15),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  bool isUser = msg["role"] == "user";
                  return _buildChatBubble(msg["message"], isUser, msg["time"]);
                },
              ),
            ),
            if (_isLoading)
              const LinearProgressIndicator(
                  color: AppColors.primaryBackgroundBlue),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(String message, bool isUser, String time) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.85),
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color:
                  isUser ? AppColors.primaryBackgroundBlue : Colors.grey[100],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isUser ? 18 : 0),
                bottomRight: Radius.circular(isUser ? 0 : 18),
              ),
            ),
            child: Directionality(
              textDirection: isUser ? TextDirection.ltr : TextDirection.rtl,
              child: SelectableText(
                message,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomText(
                text: time,
                fontsize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.normal),
          ),
          const Gap(5),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "كيف يمكنني مساعدتك؟",
                  filled: true,
                  fillColor: Colors.grey[50],
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const Gap(10),
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primaryBackgroundBlue,
            child: IconButton(
              icon:
                  const Icon(Icons.send_rounded, color: Colors.white, size: 20),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
