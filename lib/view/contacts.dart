import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trinity_w/controller/contacts_controller.dart';
import 'package:trinity_w/helper/design.dart';
import 'package:trinity_w/model/contacts_model.dart';
import 'package:trinity_w/repo/contacts_repo.dart';
import 'package:trinity_w/view/edit_contacts.dart';

class ShowContacts extends StatelessWidget {
  const ShowContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactsBloc>(
      create: (context) => ContactsBloc(ContactsRepo()),
      child: const ShowContactsView()
    );
  }
}

class ShowContactsView extends StatefulWidget {
  const ShowContactsView({Key? key}) : super(key: key);

  @override
  State<ShowContactsView> createState() => _ShowContactsViewState();
}

class _ShowContactsViewState extends State<ShowContactsView> {

  late ContactsBloc contactsBloc;

  @override
  void initState() {
    contactsBloc = BlocProvider.of<ContactsBloc>(context);
    contactsBloc.add(GetContacts());
    super.initState();
  }

  @override
  void dispose() {
    contactsBloc.close();
    super.dispose();
  }

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
          child: const Icon(Icons.add, color: Colors.white,),
        ),
        body: BlocListener<ContactsBloc, ContactsState>(
          listener: (context, state) {
          },
          child: BlocBuilder<ContactsBloc, ContactsState>(
            builder: (context, state) {
              if (state is GetContactsSuccess) {
                return RefreshIndicator(
                  onRefresh: () async => contactsBloc.add(RefreshContacts()),
                  child: body(contacts: state.contacts)
                );
              } else if (state is RefreshContactsSuccess) {
                return RefreshIndicator(
                    onRefresh: () async => contactsBloc.add(RefreshContacts()),
                    child: body(contacts: state.contacts)
                );
              } else if (state is GetContactsError || state is RefreshContactsError) {
                return const Center(child: Text('Uh-oh!'));
              }
              return const Center(child: CircularProgressIndicator(color: AppDesign.primaryColor));
            }
          ),
        )
    );
  }

  Widget body({required List<ContactsModel> contacts}) {
    return ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context, CupertinoPageRoute(builder: (context) => EditContacts(contact: contacts[index]))
              ),
              child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppDesign.primaryColor
                    ),
                    child: Center(
                        child: Text(
                            '${contacts[index].firstName?[0]}${contacts[index].lastName?[0]}',
                            style: const TextStyle(color: Colors.white)
                        )
                    ),
                  ),
                  title: Text('${contacts[index].firstName} ${contacts[index].lastName}'),
                  contentPadding: const EdgeInsets.symmetric(vertical: 4)
              ),
            ),
          );
        }
    );
  }
}

