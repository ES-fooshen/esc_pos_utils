import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discover Printers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<void> print() async {
  PaperSize paper = PaperSize.mm58;
  final CapabilityProfile profile = await CapabilityProfile.load();
  final NetworkPrinter printer = NetworkPrinter(paper, profile);
  final Generator generator = Generator(paper, profile);
  final PosPrintResult res = await printer.connect('192.168.101.35', port: 9100);
  List<int> bytes = [];

  bytes = generator.row(<PosColumn>[
    PosColumn(text: 'qty', width: 2, containsChinese: true),
    PosColumn(text: 'items', width: 5, containsChinese: true),
    PosColumn(
      text: '',
      width: 2,
      styles: const PosStyles(align: PosAlign.right),
    ),
    PosColumn(
      text: 'price',
      width: 3,
      styles: const PosStyles(align: PosAlign.right),
    ),
  ]);

  printer.rawBytes(bytes);
  printer.cut();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    print();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
