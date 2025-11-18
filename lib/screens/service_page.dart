import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_model.dart';
import '../providers/service_provider.dart';
import '../widgets/service_card.dart';
import '../widgets/addon_option.dart';

class ServicePage extends ConsumerStatefulWidget {
  const ServicePage({super.key});

  @override
  ConsumerState<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends ConsumerState<ServicePage>
    with TickerProviderStateMixin {
  String? selectedSubscription;
  List<String> selectedAddOns = [];

  late AnimationController _listController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _listController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _listController,
      curve: Curves.easeIn,
    );
    _listController.forward();
  }

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedService = ref.watch(selectedServiceProvider);

    final services = [
      ServiceModel(
        name: 'Paket Regular',
        description: 'Membersihkan area umum seperti ruang tamu dan dapur.',
        imagePath: 'assets/images/regular.jpg',
      ),
      ServiceModel(
        name: 'Paket Premium',
        description:
            'Layanan menyeluruh termasuk setrika, jendela, dan kamar mandi.',
        imagePath: 'assets/images/premium.jpg',
      ),
    ];

    final addOns = [
      {"label": "Cuci Sofa", "icon": Icons.chair_alt},
      {"label": "Cuci Karpet", "icon": Icons.layers},
      {"label": "Berbelanja", "icon": Icons.shopping_cart},
      {"label": "Memasak", "icon": Icons.soup_kitchen},
      {"label": "Bersihkan Halaman", "icon": Icons.park},
      {"label": "Cuci Kasur", "icon": Icons.bed},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paket Layanan',
          style: TextStyle(
            color: Color(0xFF84A9BB),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF84A9BB)),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------- PILIH PAKET ----------
              const Text(
                "Pilih Paket",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6F7D8C),
                ),
              ),
              const SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return ServiceCard(
                    service: service,
                    onTap: () {
                      ref.read(selectedServiceProvider.notifier).state =
                          service;
                    },
                  );
                },
              ),

              const SizedBox(height: 24),

              // -------- PILIH LANGGANAN ----------
              const Text(
                "Pilih Langganan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6F7D8C),
                ),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildSubscriptionButton("Harian"),
                  buildSubscriptionButton("Mingguan"),
                  buildSubscriptionButton("Bulanan"),
                ],
              ),

              const SizedBox(height: 24),

              // -------- PILIH TAMBAHAN ----------
              const Text(
                "Pilih Tambahan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6F7D8C),
                ),
              ),
              const SizedBox(height: 12),

              Column(
                children: addOns.map((item) {
                  final label = item["label"] as String;
                  final icon = item["icon"] as IconData;

                  final isSelected = selectedAddOns.contains(label);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AddOnOption(
                      label: label,
                      icon: icon,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          isSelected
                              ? selectedAddOns.remove(label)
                              : selectedAddOns.add(label);
                        });
                      },
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // -------- STORY ----------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF84A9BB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  selectedService == null
                      ? 'Pilih paket layanan untuk melihat detail layanan.'
                      : 'Kamu memilih ${selectedService.name} – ${selectedSubscription ?? "Belum pilih langganan"}. '
                          'Tambahan: ${selectedAddOns.isEmpty ? "Tidak ada" : selectedAddOns.join(", ")}. '
                          'Tim kami siap membuat rumahmu bersih dan nyaman! 🧽',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF7A8A9F),
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // -------- TOMBOL ORDER ----------
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      (selectedService != null && selectedSubscription != null)
                          ? () {
                              // ACTION ORDER
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Order Berhasil!"),
                                  content: const Text(
                                      "Tim kami akan segera menghubungi Anda."),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF84A9BB),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Order Sekarang",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ------ WIDGET BUTTON LANGGANAN ------
  Widget buildSubscriptionButton(String title) {
    final isSelected = selectedSubscription == title;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedSubscription = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF84A9BB) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isSelected ? const Color(0xFF84A9BB) : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF6F7D8C),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
