import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/onboarding_models.dart';

final onboardingIndexProvider =
    NotifierProvider<OnboardingIndexNotifier, int>(
  OnboardingIndexNotifier.new,
);

class OnboardingIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void select(int index) => state = index;
}

final onboardingItemsProvider = Provider<List<OnboardingModel>>((ref) {
  return const [
    OnboardingModel(
      image: 'assets/images/onboarding1.png',
      title: 'Numerous free\ntrial courses',
      description: 'Free courses for you to\nfind your way to learning',
      showBackground: true,
      showButtons: false,
    ),
    OnboardingModel(
      image: 'assets/images/onboarding2.png',
      title: 'Quick and easy\nlearning',
      description:
          'Easy and fast learning at\nany time to help you\nimprove various skills',
      showBackground: true,
      showButtons: false,
    ),
    OnboardingModel(
      image: 'assets/images/onboarding3.png',
      title: 'Create your own\nstudy plan',
      description:
          'Study according to the\nstudy plan, make study\nmore motivated',
      showBackground: false,
      showButtons: true,
    ),
  ];
});
