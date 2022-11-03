import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trinity_w/helper/design.dart';
import 'package:trinity_w/view/edit_contacts.dart';

class ShowContacts extends StatelessWidget {
  const ShowContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ShowContactsView();
  }
}

class ShowContactsView extends StatelessWidget {
  const ShowContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts', style: TextStyle(color: Colors.white)),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              onLongPress: () {},
              child: const Icon(Icons.search, color: Colors.white)
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        tooltip: 'Search',
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context, CupertinoPageRoute(builder: (context) => const EditContacts())
              ),
              child: ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppDesign.primaryColor
                  ),
                  child: const Center(child: Text('H', style: TextStyle(color: Colors.white))),
                ),
                title: const Text('Hello'),
                contentPadding: const EdgeInsets.symmetric(vertical: 4)
              ),
            );
          }
        ),
      )
    );
  }
}
