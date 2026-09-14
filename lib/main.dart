import 'package:flutter/material.dart';

void main() {
  runApp(const RahyarApp());
}

class RahyarApp extends StatelessWidget {
  const RahyarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'راهیار',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const RahyarHomePage(),
    );
  }
}

class RahyarHomePage extends StatefulWidget {
  const RahyarHomePage({super.key});

  @override
  State<RahyarHomePage> createState() => _RahyarHomePageState();
}

class _RahyarHomePageState extends State<RahyarHomePage> {
  bool isRecording = false;
  bool aiAssistant = true;
  int selectedIndex = 0;

  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isRecording
              ? 'ثبت مسیر شروع شد'
              : 'ثبت مسیر متوقف شد',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'راهیار',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                aiAssistant = !aiAssistant;
              });
            },
            icon: Icon(
              aiAssistant
                  ? Icons.psychology
                  : Icons.psychology_outlined,
            ),
            tooltip: 'دستیار هوشمند',
          ),
        ],
      ),

      body: IndexedStack(
        index: selectedIndex,
        children: [
          _buildNavigationPage(),
          _buildRoutesPage(),
          _buildAssistantPage(),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.navigation_outlined),
            selectedIcon: Icon(Icons.navigation),
            label: 'مسیریابی',
          ),
          NavigationDestination(
            icon: Icon(Icons.route_outlined),
            selectedIcon: Icon(Icons.route),
            label: 'مسیرها',
          ),
          NavigationDestination(
            icon: Icon(Icons.smart_toy_outlined),
            selectedIcon: Icon(Icons.smart_toy),
            label: 'دستیار',
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationPage() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.map,
                      size: 100,
                      color: Colors.blueGrey,
                    ),
                  ),

                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'موقعیت فعلی شما',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(Icons.my_location),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: toggleRecording,
                    icon: Icon(
                      isRecording
                          ? Icons.stop
                          : Icons.fiber_manual_record,
                    ),
                    label: Text(
                      isRecording
                          ? 'توقف ثبت مسیر'
                          : 'شروع ثبت مسیر',
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Card(
                  child: ListTile(
                    leading: Icon(
                      aiAssistant
                          ? Icons.psychology
                          : Icons.psychology_outlined,
                    ),
                    title: const Text('دستیار هوشمند راهیار'),
                    subtitle: Text(
                      aiAssistant
                          ? 'فعال است'
                          : 'غیرفعال است',
                    ),
                    trailing: Switch(
                      value: aiAssistant,
                      onChanged: (value) {
                        setState(() {
                          aiAssistant = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutesPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'مسیرهای ذخیره‌شده',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),

        Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.route),
            ),
            title: const Text('مسیرهای من'),
            subtitle: const Text(
              'در نسخه بعدی مسیرهای واقعی اینجا ذخیره می‌شوند.',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),

        Card(
          child: ListTile(
            leading: const Icon(Icons.history),
            title: const Text('تاریخچه سفرها'),
            subtitle: const Text(
              'مسیر، زمان و مسافت سفرها ثبت خواهد شد.',
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildAssistantPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'دستیار هوشمند',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 20),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(
                  Icons.smart_toy,
                  size: 70,
                ),
                const SizedBox(height: 16),
                const Text(
                  'راهیار می‌تواند در نسخه‌های بعدی '
                  'شرایط مسیر و اطلاعات سفر را تحلیل کند.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('تحلیل مسیر'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
