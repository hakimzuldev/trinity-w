import 'package:flutter/material.dart';
import 'package:trinity_w/helper/design.dart';

class EditContacts extends StatelessWidget {
  const EditContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EditContactsView();
  }
}
class EditContactsView extends StatefulWidget {
  const EditContactsView({Key? key}) : super(key: key);

  @override
  State<EditContactsView> createState() => _EditContactsViewState();
}

class _EditContactsViewState extends State<EditContactsView> {

  TextEditingController? firstName;
  TextEditingController? lastName;
  TextEditingController? email;
  TextEditingController? phone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white
            ),
            title: const Text('Edit Contact', style: TextStyle(color: Colors.white)),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                    onTap: () {},
                    onLongPress: () {},
                    child: const Center(
                        child: Text(
                            'Save',
                            style: TextStyle(fontSize: 16, color: Colors.white)
                        )
                    )
                ),
              )
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppDesign.primaryColor
                        ),
                        child: const Center(
                            child: Text('H', style: TextStyle(fontSize: 40, color: Colors.white))
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    titleInfo('Main Information'),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          formField(title: 'First Name', controller: firstName, isRequired: true),
                          const SizedBox(height: 24),
                          formField(title: 'Last Name', controller: lastName, isRequired: true),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    titleInfo('Sub Information'),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          formField(title: 'Email', controller: firstName),
                          const SizedBox(height: 24),
                          formField(title: 'Phone', controller: lastName, isNext: false),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          )
      ),
    );
  }

  Widget formField({
    required String title, required TextEditingController? controller,
    bool isRequired = false, bool isNext = true,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1, child: Text(title)
        ),
        Expanded(
            flex: 2,
            child: SizedBox(
              // height: 40,
              child: TextField(
                controller: controller,
                style: const TextStyle(height: 1),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    )
                ),
                textInputAction: isNext ? TextInputAction.next : TextInputAction.done,
              ),
            )
        ),
      ],
    );
  }

  Widget titleInfo(String title) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: const TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ),
        ),
      ],
    );
  }

}

