import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  // constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TodoScreen(),);
  }
}


class TodoScreen extends StatefulWidget {
  // constructor
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // リモコンを作成
  final _controller = TextEditingController();

  // タスクを保持するリスト
  final List<String> _todoList = [];

  // タスクを追加するメソッド
  void _addTask() {
    // if the input is not empty
    if (_controller.text.isNotEmpty) {
      // setStateで状態を更新
      setState(() {
        _todoList.add(_controller.text);
        _controller.clear();  // 追加したら入力欄を空にする
      });
    }
  } // addTask

  // UIを組み立てる
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(title: const Text('My Todo List'), backgroundColor: Colors.blue,),
      
      // Body
      body: Padding (
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // 入力欄 & ボタンを横一列に
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'enter a new task'),
                  ), 
                ),
               

                const SizedBox(width: 8),

                ElevatedButton(onPressed: _addTask, child: const Text('add'))
              ] // children for row
            ),

            // タスクリスト
            Expanded(
              child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  // List Tileを使うときれいなリスト項目を作成できる
                  return ListTile(title: Text(_todoList[index]));
                }
              )
            )
          ], // children for column
        )
      )
    );
  }

  // dispose
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}