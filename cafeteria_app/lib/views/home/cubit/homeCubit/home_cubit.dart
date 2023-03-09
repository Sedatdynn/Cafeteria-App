import 'package:bloc/bloc.dart';
import '../../model/items_model.dart';
import '../../service/items_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.generalService) : super(HomeInitial());
  final IGeneralService generalService;

  List<Foods?> allProduct = [];
  int index = 0;
  int totalPay = 0;
  List isSelectFood = [];
  List eachFoodPrice = [];
  void changeIndex(int editI) {
    index = editI;
    fetchAllProduct();
    emit(HomeLoaded(allProduct, index));
  }

  Future<void> fetchAllProduct() async {
    try {
      emit(HomeLoading());
      final list = await generalService.fetchProductItems(index);
      allProduct = list;
      emit(HomeLoaded(allProduct, index));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
