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



// task class
// 今まではタスクリストはただの文字列で何もタスクが終わったかどうか判断する要素がないのでクラスを作成してタスクリストの中の要素をこれに置き換える
class TodoItem {
  String title;   // task name
  bool isDone;    // 完了状態 (true: 完了)

  // 設計図から新しいタスクを作成するときに使う(constructor)
  TodoItem({required this.title, this.isDone = false});
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
  final List<TodoItem> _todoList = [];

  // タスクを追加するメソッド
  void _addTask() {
    // if the input is not empty
    if (_controller.text.isNotEmpty) {
      // setStateで状態を更新
      setState(() {
        //_todoList.add(_controller.text);
        _todoList.add(TodoItem(title: _controller.text)); // Titleに渡す
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
            // リストの項目をタップできるようにListTileにonTapというプロパティを追加
            Expanded(
              child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  // List Tileを使うときれいなリスト項目を作成できる
                  final todo = _todoList[index];  // 現在のタスクを取得
                  // To remove tasks USE Dismissible
                  return Dismissible(
                    // Key: 各項目を一意に識別するためのkey
                    key: UniqueKey(),
                    // onDismissed: スワイプされた後の処理
                    onDismissed: (direction) {
                      setState(() {
                        // リストから該当タスクを削除
                        _todoList.removeAt(index);
                      });
                    },
                    // スワイプ中の背景 (赤い削除アイコン)
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    // child: スワイプされるウィジェット本体
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          // isDoneの状態を反転させる
                          todo.isDone = !todo.isDone;
                        });
                      },

                      title: Text(
                        todo.title,
                        style: TextStyle(decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none)
                      )
                    ),
                  );
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