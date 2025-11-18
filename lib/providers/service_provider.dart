import 'package:flutter_application_4/widgets/addon_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_model.dart';

final selectedServiceProvider = StateProvider<ServiceModel?>((ref) => null);

final selectedSubscriptionProvider = StateProvider<String?>((ref) => null);

final selectedAddOnsProvider = StateProvider<List<AddOnModel>>((ref) => []);
