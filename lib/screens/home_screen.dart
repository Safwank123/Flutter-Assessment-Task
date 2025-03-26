import 'package:assessment/API/api_service.dart';
import 'package:assessment/models/user_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UserModel> futureServices;
  List<Service> allServices = [];
  List<Service> filteredServices = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureServices = ApiService.fetchServices();
  }

  void filterServices(String query) {
    setState(() {
      filteredServices = allServices.where((service) {
        final nameLower = service.serviceName.toLowerCase();
        final descLower = service.description.toLowerCase();
        final searchLower = query.toLowerCase();
        return nameLower.contains(searchLower) || descLower.contains(searchLower);
      }).toList();
    });
  }

  String getServiceIdText(ServiceId serviceId) {
    switch (serviceId) {
      case ServiceId.LSA_ONLINE:
        return "Real Estate Notarization";
      case ServiceId.LSA_OFFLINE:
        return "Real Estate Offline Notarization";
      case ServiceId.LSA_OFFLINE_INHOUSE:
        return "Real Estate In-House Notarization";
      case ServiceId.GEN_ONLINE:
        return "General Online Notarization";
      case ServiceId.GEN_OFFLINE:
        return "General Offline Notarization";
      default:
        return serviceId.toString().split('.').last;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search services...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onChanged: filterServices,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<UserModel>(
              future: futureServices,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  if (allServices.isEmpty) {
                    allServices = snapshot.data!.data.availableServices.services;
                    filteredServices = allServices;
                  }

                  return filteredServices.isEmpty
                      ? const Center(child: Text('No services found'))
                      : ListView.builder(
                          itemCount: filteredServices.length,
                          itemBuilder: (context, index) {
                            final service = filteredServices[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.serviceName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "\$${service.cost}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    getServiceIdText(service.serviceId),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
