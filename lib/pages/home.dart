import 'package:flutter/material.dart';
import 'package:metro_mart/pages/login.dart';
import 'package:metro_mart/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
            icon: Icons.home,
            text: 'Home',
            // onTap: () => Navigator.pushReplacementNamed(context, '/home'),
          ),
          _createDrawerItem(
            icon: Icons.person,
            text: 'Profile',
            // onTap: () => Navigator.pushReplacementNamed(context, '/profile'),
          ),
          _createDrawerItem(
            icon: Icons.shopping_cart,
            text: 'My Orders',
            // onTap: () => Navigator.pushReplacementNamed(context, '/orders'),
          ),
          _createDrawerItem(
              icon: Icons.notifications, text: 'Notifications', onTap: () => ()
              // Navigator.pushReplacementNamed(context, '/notifications'),
              ),
          _createDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            // onTap: () => Navigator.pushReplacementNamed(context, '/settings'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              context.read<AuthProvider>().logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Search action
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
                height:
                    20), // Add some space between the search bar and the grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 11, // Number of items
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    alignment: Alignment.center,
                    child: Text(
                      'Item $index',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createHeader() {
    return const DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(
              "Welcome, Vijay!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            top: 12.0,
            left: 16.0,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/vijay.jpeg'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      GestureTapCallback? onTap}) {
    return ListTile(
      title: Text(text),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
