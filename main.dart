
import 'package:flutter/material.dart';

void main() {
  runApp(const JKHomeImprovementsApp());
}

class JKHomeImprovementsApp extends StatelessWidget {
  const JKHomeImprovementsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JK Home Improvements',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JK HOME IMPROVEMENTS'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: const Color(0xFF1E1E1E),
              child: ListTile(
                leading: const Icon(Icons.receipt_long, color: Colors.orange),
                title: const Text('Create Invoice'),
                subtitle: const Text('Generate customer invoices'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InvoiceScreen(),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: const Color(0xFF1E1E1E),
              child: ListTile(
                leading: const Icon(Icons.request_quote, color: Colors.orange),
                title: const Text('Quote / Estimate'),
                subtitle: const Text('Create estimates for jobs'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final customerController = TextEditingController();
  final itemController = TextEditingController();
  final priceController = TextEditingController();

  final List<Map<String, dynamic>> items = [];

  double get total {
    double t = 0;
    for (var item in items) {
      t += item['price'];
    }
    return t;
  }

  void addItem() {
    if (itemController.text.isNotEmpty &&
        priceController.text.isNotEmpty) {
      setState(() {
        items.add({
          'name': itemController.text,
          'price': double.tryParse(priceController.text) ?? 0,
        });
      });

      itemController.clear();
      priceController.clear();
    }
  }

  Widget ruggedField(TextEditingController c, String hint) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Invoice'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ruggedField(customerController, 'Customer Name'),
            const SizedBox(height: 12),
            ruggedField(itemController, 'Job / Material'),
            const SizedBox(height: 12),
            ruggedField(priceController, 'Price'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: addItem,
              child: const Text('ADD ITEM'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    color: const Color(0xFF1E1E1E),
                    child: ListTile(
                      title: Text(item['name']),
                      trailing: Text('£${item['price']}'),
                    ),
                  );
                },
              ),
            ),
            Text(
              'TOTAL: £${total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
