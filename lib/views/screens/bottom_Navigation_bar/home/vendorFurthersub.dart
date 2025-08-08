import 'package:flutter/material.dart';
import 'package:my_plo/views/screens/bottom_Navigation_bar/payment/payout.dart';
import 'package:my_plo/views/widgets/back.dart';

class Vendorfurthersub extends StatefulWidget {
  @override
  _ReportExampleScreenState createState() => _ReportExampleScreenState();
}

class _ReportExampleScreenState extends State<Vendorfurthersub> {
  final List<Map<String, dynamic>> items = [
    {
      "title": "test",
      "price": 2000,
      "date": "3-Jun-2025",
      "location": "Indianapolis",
    },
    {
      "title": "Udne vala...",
      "price": 797,
      "date": "20-May-2025",
      "location": "Ualena Street",
    },
  ];
  void onTap() {
    Navigator.pop(context);
  }

  void _showReportDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.purple.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Report User",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: 3,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      border: InputBorder.none,
                      hintText: "Reason for Report",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String reason = _controller.text;
                        if (reason.isNotEmpty) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Reported successfully!")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("Submit"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showReportDialog3(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.purple.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Report User",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  "Are you sure you want to report this user? Our team will review the report and take appropriate action.",
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showReportDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Report",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showReportDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.purple.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Block User",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  "Are you sure you want to block the user? They will no longer be able to contact you or view your profile.",
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("Block", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onMenuSelected(String value, BuildContext context) {
    if (value == 'report') {
      _showReportDialog3(context);
    }
    if (value == 'block') {
      _showReportDialog2(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Party Supplies"),
        leading: Back.buildBack(onTap),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 200,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Stack(
                children: [
                  Container(
                    child: Image.asset('assets/images/babyshower3.jpg'),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Text(
                          item["title"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("\$${item["price"]}"),
                        Text(item["date"]),
                        Text(item["location"], overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  Positioned(
                    right: -10,
                    top: -5,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: PopupMenuButton<String>(
                        onSelected: (value) => _onMenuSelected(value, context),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(value: "report", child: Text("Report")),
                          PopupMenuItem(value: "block", child: Text("Block")),
                        ],
                        icon: Icon(Icons.more_vert, color: Colors.pink),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
