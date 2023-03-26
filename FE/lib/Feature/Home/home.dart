import 'package:flutter/material.dart';

class HomePg extends StatefulWidget {
  const HomePg({Key? key}) : super(key: key);

  @override
  State<HomePg> createState() => _HomePgState();
}

class _HomePgState extends State<HomePg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          )
          //Icon(Icons.arrow_back),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          reverse: false,
          shrinkWrap: true,
          children: [
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                // CircleAvatar(
                //     radius: 100.0,
                //     Icon(Icons.verified_user),
                // ),
              ClipOval(
                child: Container(
                  width: 150,
                  height: 150, // Replace with your desired diameter
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75), // Half of the diameter
                    color: Colors.green,
                  ),
                  child: Icon(
                    Icons.verified_user,
                    size: 100, // Adjust the size of the icon as needed
                    color: Colors.white, // Replace with your desired icon color
                  ),
                ),
              ),
              ],
            ),
            Divider(),
            SizedBox(height: 25.00),
            ListTile(
              leading: CircleAvatar(child: const Icon(Icons.person), backgroundColor: Colors.grey,),
              title: const Text('Your Queen Samantha'),
              subtitle: const Text('Drop your like'),
              trailing: const Text('1M'),
              onTap: (){},
              tileColor: Colors.blueAccent,
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Press back Button to logout')
            )
          ],
        ),
      ),
    );
  }
}
