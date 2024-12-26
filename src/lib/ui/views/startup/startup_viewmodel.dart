import 'package:pokemon_deck/app/app.locator.dart';
import 'package:pokemon_deck/app/app.router.dart';
import 'package:pokemon_deck/services/pokemon_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _pokemonService = locator<PokemonService>();

  Future runStartupLogic() async {
    try {
      await _pokemonService.initializePokemon();
      await Future.delayed(const Duration(seconds: 2));
      await _navigationService.replaceWithHomeView();
    } catch (e) {
      setError('Failed to initialize the application. Please try again.');
    }
  }
}
