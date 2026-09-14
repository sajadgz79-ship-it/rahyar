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

  final List<String> savedRoutes = [];

  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;

      if (isRecording) {
        savedRoutes.add(
          'مسیر جدید - ${DateTime.now().hour}:${DateTime.now().minute}',
        );
      }
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

  void showCurrentLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('در نسخه بعدی، موقعیت GPS شما روی نقشه نمایش داده می‌شود.'),
      ),
    );
  }

  void showRouteMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('انتخاب مقصد و محاسبه مسیر در مرحله بعد اضافه می‌شود.'),
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

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    aiAssistant
                        ? 'دستیار هوشمند فعال شد'
                        : 'دستیار هوشمند غیرفعال شد',
                  ),
                ),
              );
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
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blueGrey.shade100,
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.map,
                      size: 120,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
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
                            IconButton(
                              onPressed: showCurrentLocation,
                              icon: const Icon(Icons.my_location),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: showRouteMessage,
                                icon: const Icon(Icons.search),
                                label: const Text('انتخاب مقصد'),
                              ),
                            ),
                            const SizedBox(height: 8),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Card(
              child: ListTile(
                leading: Icon(
                  aiAssistant
                      ? Icons.psychology
                      : Icons.psychology_outlined,
                ),
                title: const Text('دستیار هوشمند راهیار'),
                subtitle: Text(
                  aiAssistant
                      ? 'فعال است و آماده کمک به شماست'
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
        if (savedRoutes.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: const [
                  Icon(
                    Icons.route,
                    size: 60,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'هنوز مسیری ذخیره نشده است.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'با شروع ثبت مسیر، مسیرهای شما در این قسمت نمایش داده می‌شوند.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        else
          ...savedRoutes.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final route = entry.value;

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(route),
                  subtitle: const Text(
                    'مسیر ثبت‌شده توسط راهیار',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'جزئیات مسیر در مرحله بعد اضافه می‌شود.',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.history),
            title: const Text('تاریخچه سفرها'),
            subtitle: const Text(
              'مسیر، زمان و مسافت سفرها در این بخش ذخیره خواهد شد.',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'تاریخچه کامل سفرها در مرحله بعد فعال می‌شود.',
                  ),
                ),
              );
            },
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
                  'راهیار می‌تواند در نسخه‌های بعدی شرایط مسیر و اطلاعات سفر را تحلیل کند.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'دستیار هوشمند آماده توسعه است.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('تحلیل مسیر'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: SwitchListTile(
            value: aiAssistant,
            onChanged: (value) {
              setState(() {
                aiAssistant = value;
              });
            },
            title: const Text('دستیار هوشمند راهیار'),
            subtitle: Text(
              aiAssistant ? 'فعال است' : 'غیرفعال است',
            ),
          ),
        ),
      ],
    );
  }
}
