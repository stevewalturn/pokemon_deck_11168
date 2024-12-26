import 'package:pokemon_deck/services/pokemon_service.dart';
import 'package:pokemon_deck/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:pokemon_deck/ui/dialogs/add_to_deck/add_to_deck_dialog.dart';
import 'package:pokemon_deck/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:pokemon_deck/ui/views/deck/deck_view.dart';
import 'package:pokemon_deck/ui/views/home/home_view.dart';
import 'package:pokemon_deck/ui/views/pokemon_detail/pokemon_detail_view.dart';
import 'package:pokemon_deck/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: DeckView),
    MaterialRoute(page: PokemonDetailView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: PokemonService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: AddToDeckDialog),
  ],
)
class App {}
