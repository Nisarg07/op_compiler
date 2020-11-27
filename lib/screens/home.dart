import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:op_compiler/model/indentCode.dart';
import 'package:op_compiler/model/outputModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState1 createState() => _HomeState1();
}

class _HomeState1 extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home1(),
    );
  }
}

class Home1 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home1> with SingleTickerProviderStateMixin {
  final codeController = TextEditingController();
  final lineController = TextEditingController();
  final inputController = TextEditingController();
  final codeFocus = FocusNode();
  var numLines = 0;
  var loading = false;
  TabController tabController;
  var text = "";
  List<String> buttonsList = [
    'TAB',
    '< >',
    '( )',
    '{ }',
    '[ ]',
    '" "',
    '#',
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

  Future<http.Response> sendData(code, input) async {
    var response = await http.post('http://192.168.0.126/compiler_win.php',
        body: {'code': code, 'input': input});
    return response;
  }

  Future<http.Response> indentCode(code) async {
    var response = await http
        .post('http://192.168.0.126/beautify.php', body: {'code': code});
    return response;
  }

  methods(i, selection) {
    print(i);
    if (i + 1 == 1) {
      var textSelection = selection;
      String newText = codeController.text
          .replaceRange(textSelection.start, textSelection.end, "\t");
      codeController.text = newText;
      codeController.selection = textSelection.copyWith(
          baseOffset: textSelection.start + "\t".length,
          extentOffset: textSelection.start + "\t".length);
      // codeController.text = codeController.text + '< >';
    }
    if (i + 1 == 2) {
      var textSelection = selection;
      String newText = codeController.text
          .replaceRange(textSelection.start, textSelection.end, "<>");
      codeController.text = newText;
      codeController.selection = textSelection.copyWith(
          baseOffset: textSelection.start + "<>".length - 1,
          extentOffset: textSelection.start + "<>".length - 1);
      // codeController.text = codeController.text + '< >';
    }
    if (i + 1 == 3) {
      var textSelection = selection;
      String newText = codeController.text
          .replaceRange(textSelection.start, textSelection.end, "()");
      codeController.text = newText;
      codeController.selection = textSelection.copyWith(
          baseOffset: textSelection.start + "()".length - 1,
          extentOffset: textSelection.start + "()".length - 1);
      // codeController.text = codeController.text + '( )';
    }
    if (i + 1 == 4) {
      var textSelection = selection;
      String newText = codeController.text
          .replaceRange(textSelection.start, textSelection.end, "{}");
      codeController.text = newText;
      codeController.selection = textSelection.copyWith(
          baseOffset: textSelection.start + "{}".length - 1,
          extentOffset: textSelection.start + "{}".length - 1);
      // codeController.text = codeController.text + '{ }';
    }
    if (i + 1 == 5) {
      var textSelection = selection;
      String newText = codeController.text
          .replaceRange(textSelection.start, textSelection.end, "[]");
      codeController.text = newText;
      codeController.selection = textSelection.copyWith(
          baseOffset: textSelection.start + "[]".length - 1,
          extentOffset: textSelection.start + "[]".length - 1);
      // codeController.text = codeController.text + '[ ]';
    }
    if (i + 1 == 6) {
      var textSelection = selection;
      String newText = codeController.text
          .replaceRange(textSelection.start, textSelection.end, '""');
      codeController.text = newText;
      codeController.selection = textSelection.copyWith(
          baseOffset: textSelection.start + '""'.length - 1,
          extentOffset: textSelection.start + '""'.length - 1);
      // codeController.text = codeController.text + '< >';
    }
    if (i + 1 == 7) {
      var textSelection = selection;
      String newText = codeController.text
          .replaceRange(textSelection.start, textSelection.end, "#");
      codeController.text = newText;
      codeController.selection = textSelection.copyWith(
          baseOffset: textSelection.start + "#".length,
          extentOffset: textSelection.start + "#".length);
      // codeController.text = codeController.text + '< >';
    }
    if (i + 1 == 8) {
      var textSelection = selection;
      String newText = codeController.text
          .replaceRange(textSelection.start, textSelection.end, "!");
      codeController.text = newText;
      codeController.selection = textSelection.copyWith(
          baseOffset: textSelection.start + "!".length,
          extentOffset: textSelection.start + "!".length);
      // codeController.text = codeController.text + '!';
    }
    if (i + 1 == 9) {
      var textSelection = selection;
      String newText = codeController.text
          .replaceRange(textSelection.start, textSelection.end, "%");
      codeController.text = newText;
      codeController.selection = textSelection.copyWith(
          baseOffset: textSelection.start + "%".length,
          extentOffset: textSelection.start + "%".length);
      // codeController.text = codeController.text + '%';
    }
    if (i + 1 == 10) {
      var textSelection = selection;
      String newText = codeController.text
          .replaceRange(textSelection.start, textSelection.end, "&");
      codeController.text = newText;
      codeController.selection = textSelection.copyWith(
          baseOffset: textSelection.start + "&".length,
          extentOffset: textSelection.start + "&".length);
      // codeController.text = codeController.text + '&';
    }
    if (i + 1 == 11) {
      var textSelection = selection;
      String newText = codeController.text
          .replaceRange(textSelection.start, textSelection.end, "|");
      codeController.text = newText;
      codeController.selection = textSelection.copyWith(
          baseOffset: textSelection.start + "|".length,
          extentOffset: textSelection.start + "|".length);
      // codeController.text = codeController.text + '|';
    }
    if (i + 1 == 12) {
      var textSelection = selection;
      String newText = codeController.text
          .replaceRange(textSelection.start, textSelection.end, ";");
      codeController.text = newText;
      codeController.selection = textSelection.copyWith(
          baseOffset: textSelection.start + ";".length,
          extentOffset: textSelection.start + ";".length);
      // codeController.text = codeController.text + ';';
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
                    setState(() {
                      loading = true;
                    });
                    var response = await sendData(
                        codeController.text, inputController.text);
                    if (response.statusCode == 200) {
                      // print(response.body);
                      var outputObject =
                          OutPutModel.fromJson(json.decode(response.body));
                      if (outputObject.error != null) {
                        if (outputObject.error.isNotEmpty) {
                          setState(() {
                            text = outputObject.error;
                          });
                        }
                      }
                      if (outputObject.output != null) {
                        if (outputObject.output.isNotEmpty) {
                          setState(() {
                            text = outputObject.output;
                          });
                        }
                      }
                    }
                    setState(() {
                      loading = false;
                    });
                    inputController.text = "";
                    codeController.text.isEmpty
                        ? print('')
                        : tabController
                            .animateTo((tabController.index + 1) % 2);
                  },
                )
              ],
            ));
  }

  showButtonList(BuildContext context, selection) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: buttonsList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 9,
                        mainAxisSpacing: 9),
                    itemBuilder: (context, index) {
                      return FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            methods(index, selection);
                          },
                          color: Colors.orange,
                          child: Text(buttonsList[index]));
                    }),
              ));
        });
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
              PopupMenuItem(
                child: Text("IMPORT FILE"),
                value: 3,
              ),
            ],
            onSelected: (value) async {
              if (value == 1) {
                // print(codeController.text);
                codeFocus.unfocus();
                // await setState(() {
                //   text = codeController.text;
                // });
                if (codeController.text.contains('scanf')) {
                  showInputBox();
                } else {
                  setState(() {
                    loading = true;
                  });
                  var response = await sendData(codeController.text, " ");

                  if (response.statusCode == 200) {
                    // print('in if');
                    var outputObject =
                        OutPutModel.fromJson(json.decode(response.body));
                    // print(outputObject.output);

                    if (outputObject.error != null) {
                      if (outputObject.error.isNotEmpty) {
                        setState(() {
                          text = outputObject.error;
                        });
                      }
                    }
                    if (outputObject.output != null) {
                      if (outputObject.output.isNotEmpty) {
                        setState(() {
                          text = outputObject.output;
                        });
                      }
                    }
                    setState(() {
                      loading = false;
                    });
                  }
                  codeController.text.isEmpty
                      ? print('')
                      : tabController.animateTo((tabController.index + 1) % 2);
                }
              }
              if (value == 2) {
                codeFocus.unfocus();
                setState(() {
                  loading = true;
                });
                var response = await indentCode(codeController.text);
                print(response.body);
                if (response.statusCode == 200) {
                  var indentCode =
                      IndentCode.fromJson(jsonDecode(response.body));
                  if (indentCode.code != null) {
                    if (indentCode.code.isNotEmpty) {
                      codeController.text = indentCode.code;
                    }
                  }
                  setState(() {
                    loading = false;
                  });
                }
              }
              if (value == 3) {
                String textFile;
                try {
                  var pickFile = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['c'],
                      allowCompression: true);
                  if (pickFile != null) {
                    File readFile = File(pickFile.files.single.path);
                    textFile = await readFile.readAsString();
                    var lnum = textFile.split('\n');
                    var newNum1 = lnum.length;
                    setState(() {
                      lineController.text = '1';
                    });
                    for (var l = 2; l <= newNum1; l++) {
                      var temp = lineController.text;

                      if (l == newNum1) {
                        setState(() {
                          lineController.text =
                              temp + '\n' + l.toString() + '\n';
                        });
                      } else {
                        setState(() {
                          lineController.text = temp + '\n' + l.toString();
                        });
                      }
                    }
                    // print(textFile);
                    // var lnum = textFile.length;
                    // print(lnum);
                    // print(lnum / 36);
                    codeController.text = "";
                    codeController.text = textFile;
                  }
                } catch (e) {
                  print(e);
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
      body: loading
          ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : TabBarView(controller: tabController, children: [
              Stack(children: [
                SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 3,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .14,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.blueGrey,
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
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onLongPressEnd: (details) {
                                showMenu(
                                    color: Colors.blue,
                                    context: context,
                                    position: RelativeRect.fromLTRB(
                                        65.0, 40.0, 0.0, 0.0),
                                    items: [
                                      PopupMenuItem(
                                          child: Text("Can't Paste the Code!"))
                                    ]);
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                child: ConstrainedBox(
                                  constraints:
                                      BoxConstraints.expand(width: 307),
                                  child: Container(
                                    color: Colors.grey,
                                    height: MediaQuery.of(context).size.height,
                                    // width: MediaQuery.of(context).size.width *
                                    // .85,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        // enableInteractiveSelection: false,
                                        focusNode: codeFocus,
                                        controller: codeController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        // maxLength: 36,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          // counter: null,
                                        ),

                                        onChanged: (value) {
                                          // var newText =
                                          //     codeController.text.split('\n');
                                          // print(newText);
                                          // for (var m = 0; m < newText.length; m++) {
                                          //   if (newText[m].length > 32) {
                                          //     var temp = lineController.text;
                                          //     lineController.text = '';
                                          //     lineController.text = temp + '\n';
                                          //   }
                                          // }
                                          // if (codeController.text.length > 3) {
                                          //   var temp = codeController.text;
                                          //   codeController.text = '';
                                          //   codeController.text = temp + '\n';
                                          //   // setState(() {
                                          //   //   codeController.value =
                                          //   //       TextEditingValue(
                                          //   //           text: temp + '\n',
                                          //   //           selection: TextSelection(
                                          //   //               baseOffset: (temp).length,
                                          //   //               extentOffset:
                                          //   //                   (temp).length));
                                          //   // });
                                          // }
                                          var numtemp = numLines;
                                          setState(() {
                                            numLines = '\n'
                                                    .allMatches(
                                                        codeController.text)
                                                    .length +
                                                1;
                                            // print(''
                                            //         .allMatches(codeController.text)
                                            //         .length -
                                            //     1);
                                            var temp = lineController.text;
                                            // temp.add(numLines);
                                            // for (var i = 0; i < temp.length; i++) {
                                            //   lineController.text = temp[i];
                                            // }
                                            if (numLines > numtemp) {
                                              if (!temp.contains(
                                                  numLines.toString())) {
                                                if (temp == '1') {
                                                  lineController.text = '';
                                                  lineController.text = temp +
                                                      '\n' +
                                                      numLines.toString() +
                                                      '\n';
                                                } else {
                                                  lineController.text = '';
                                                  lineController.text = temp +
                                                      numLines.toString() +
                                                      '\n';
                                                }
                                                // print(numLines);
                                              }
                                            }
                                            if (numLines <= numtemp) {
                                              // print('nothing');
                                              var a = 0;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //     bottom: MediaQuery.of(context).viewInsets.top,
                //     left: 0,
                //     right: 0,
                //     child: Container(
                //       height: 70,
                //       child: ListView(
                //         scrollDirection: Axis.horizontal,
                //         children: getButtons(),
                //       ),
                //     ))
              ]),
              Container(
                child: text.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'OUTPUT',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          text,
                          overflow: TextOverflow.visible,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
              )
            ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () {
          showButtonList(context, codeController.selection);
        },
      ),
    ));
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
