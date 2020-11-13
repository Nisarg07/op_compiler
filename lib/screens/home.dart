import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:op_compiler/model/outputModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final codeController = TextEditingController();
  final lineController = TextEditingController();
  final inputController = TextEditingController();
  final codeFocus = FocusNode();
  var numLines = 0;
  TabController tabController;
  var text = "";
  List<String> buttonsList = [
    '< >',
    '( )',
    '{ }',
    '[ ]',
    '!',
    '%',
    '&',
    '|',
    ';'
  ];
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  Future<http.Response> sendData(code, [input]) {
    return http.post('http://compiler-test.herokuapp.com',
        body: jsonEncode(<String, String>{'code': code, 'input': input}));
  }

  methods(i) {
    if (i + 1 == 1) {
      codeController.text = codeController.text + '< >';
    }
    if (i + 1 == 2) {
      codeController.text = codeController.text + '( )';
    }
    if (i + 1 == 3) {
      codeController.text = codeController.text + '{ }';
    }
    if (i + 1 == 4) {
      codeController.text = codeController.text + '[ ]';
    }
    if (i + 1 == 5) {
      codeController.text = codeController.text + '!';
    }
    if (i + 1 == 6) {
      codeController.text = codeController.text + '%';
    }
    if (i + 1 == 7) {
      codeController.text = codeController.text + '&';
    }
    if (i + 1 == 8) {
      codeController.text = codeController.text + '|';
    }
    if (i + 1 == 9) {
      codeController.text = codeController.text + ';';
    }
  }

  showInputBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('INPUT'),
              content: TextFormField(
                controller: inputController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Enter input data....",
                ),
              ),
              actions: [
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: Text("Done"),
                  onPressed: () async {
                    Navigator.pop(context);
                    codeController.text.isEmpty
                        ? print('')
                        : tabController
                            .animateTo((tabController.index + 1) % 2);
                    var response = await sendData(
                        codeController.text, [inputController.text]);
                    var outputObject =
                        OutPutModel.fromJson(json.decode(response.body));
                    if (outputObject.error.isNotEmpty) {
                      setState(() {
                        text = outputObject.error;
                      });
                    }
                    if (outputObject.output.isNotEmpty) {
                      setState(() {
                        text = outputObject.output;
                      });
                    }
                  },
                )
              ],
            ));
  }

  getButtons() {
    List<Widget> widgets = [];
    for (var i = 0; i < 9; i++) {
      widgets.add(Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            FlatButton(
                onPressed: () {
                  methods(i);
                },
                color: Colors.orange,
                child: Text(buttonsList[i]))
          ],
        ),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('COMPILER'),
        // centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              codeController.text = '';
              lineController.text = '1';
              setState(() {
                numLines = 1;
              });
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('RUN'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('BEAUTIFY'),
                value: 2,
              ),
            ],
            onSelected: (value) async {
              if (value == 1) {
                print(codeController.text);
                codeFocus.unfocus();
                // await setState(() {
                //   text = codeController.text;
                // });
                if (codeController.text.contains('scanf')) {
                  showInputBox();
                } else {
                  codeController.text.isEmpty
                      ? print('')
                      : tabController.animateTo((tabController.index + 1) % 2);
                  var response = await sendData(codeController.text, " ");
                  if (response.statusCode == 200) {
                    var outputObject =
                        OutPutModel.fromJson(json.decode(response.body));
                    if (outputObject.error.isNotEmpty) {
                      setState(() {
                        text = outputObject.error;
                      });
                    }
                    if (outputObject.output.isNotEmpty) {
                      setState(() {
                        text = outputObject.output;
                      });
                    }
                  }
                }
              }
            },
          )
        ],
        bottom: TabBar(controller: tabController, tabs: [
          Tab(
            child: Text("CODE"),
          ),
          Tab(
            child: Text("OUTPUT"),
          )
        ]),
      ),
      body: TabBarView(controller: tabController, children: [
        Stack(children: [
          SingleChildScrollView(
            child: Center(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .1,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.blueGrey,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: lineController,
                              focusNode: AlwaysDisabledFocusNode(),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Container(
                        color: Colors.grey,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * .89,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            focusNode: codeFocus,
                            controller: codeController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // counter: null,
                            ),
                            onChanged: (value) {
                              var numtemp = numLines;
                              setState(() {
                                numLines = '\n'
                                        .allMatches(codeController.text)
                                        .length +
                                    1;
                                var temp = lineController.text;
                                // temp.add(numLines);
                                // for (var i = 0; i < temp.length; i++) {
                                //   lineController.text = temp[i];
                                // }
                                if (numLines > numtemp) {
                                  if (!temp.contains(numLines.toString())) {
                                    lineController.text = '';
                                    lineController.text =
                                        temp + numLines.toString() + '\n';
                                    print(numLines);
                                  }
                                }
                                if (numLines <= numtemp) {
                                  print('nothing');
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: MediaQuery.of(context).viewInsets.top,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: getButtons(),
                ),
              ))
        ]),
        Container(
          child: text.isEmpty ? Text('OUTPUT') : Text(text),
        )
      ]),
      // SingleChildScrollView(
      //   child: Center(
      //     child: Container(
      //       width: MediaQuery.of(context).size.width * .9,
      //       child: Form(
      //         child: Column(
      //           children: [
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Text('CODE :'),
      //             SizedBox(
      //               height: 5,
      //             ),
      //             SingleChildScrollView(
      //               child: Container(
      //                 color: Colors.black,
      //                 height: 250,
      //                 child: TextFormField(
      //                   controller: codeController,
      //                   keyboardType: TextInputType.multiline,
      //                   maxLines: null,
      //                   decoration: InputDecoration(
      //                     border: InputBorder.none,
      //                     // counter: null,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Text('INPUT :'),
      //             SizedBox(
      //               height: 5,
      //             ),
      //             SingleChildScrollView(
      //               child: Container(
      //                 height: 150,
      //                 child: TextFormField(
      //                   controller: inputController,
      //                   keyboardType: TextInputType.multiline,
      //                   maxLines: null,
      //                   decoration: InputDecoration(
      //                     counter: null,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             // CodeEditor(
      //             //   onSubmit: (language, code) {
      //             //     print(language);
      //             //     print(code);
      //             //   },
      //             //   model: EditorModel(
      //             //       files: [FileEditor(name: 'a.c', language: 'c')]),
      //             // )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    ));
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
