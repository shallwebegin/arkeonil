import 'package:arkeonil/discover/repository/discover_repository.dart';
import 'package:arkeonil/models/archae_category_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final discoverControllerProvider = Provider((ref) {
  final discoverRepository = ref.watch(discoverRepositoryProvider);
  return DiscoverController(discoverRepository: discoverRepository);
});

class DiscoverController {
  final DiscoverRepository discoverRepository;

  DiscoverController({required this.discoverRepository});

  Stream<List<ArchaeCategory>> getProfilePhotos() {
    return discoverRepository.getProfilePhotos();
  }
}
