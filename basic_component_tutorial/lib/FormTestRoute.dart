import 'package:flutter/material.dart';


/*
表单 Form
若要同时对一些控件进行处理，例如清空所有文本框，可将所有文本框放入 form 中
实际上是对控件进行了分组，分组进行处理
*/
class FormTestRoute extends StatefulWidget {
  const FormTestRoute({super.key});

  @override
  FormTestRouteState createState() => FormTestRouteState();
}

class FormTestRouteState extends State<FormTestRoute> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Test"),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: userNameController,
              decoration: const InputDecoration(
                labelText: '用户名',
                hintText: '用户名或邮箱',
                icon: Icon(Icons.person),
              ),
              validator: (value) {
                // 对输入的内容进行校验
                // trim() 去除一个字符串中开头和结尾的空格/制表符/换行符
                return value!.trim().isNotEmpty? null : '用户名不能为空！';
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: '密码',
                hintText: '你的登陆密码',
                icon: Icon(Icons.lock),
              ),
              validator: (value) {
                return value!.trim().length > 5 ? null : '密码不少于6位';
              },
            ),
            // 登陆按钮（用Padding进行封装是为了确定按钮的具体位置）
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // 通过 formKey.currentState 获取用户名和密码的校验结果，校验通过则进行下一步操作
                          if((formKey.currentState as FormState).validate()) {
                            print("登陆成功！");
                          }
                        },
                        child: const Padding(
                            padding: EdgeInsets.all(16.0),
                          child: Text("登陆"),
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}