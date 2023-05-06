import 'package:bloc/bloc.dart';
import 'package:cafeteria_app/views/home/service/i_home_service.dart';
import 'package:intl/intl.dart';
import '../../model/items_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeService) : super(HomeInitial());
  final IHomeService homeService;

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
      final list = await homeService.fetchProductItems(index);
      allProduct = list;
      emit(HomeLoaded(allProduct, index));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  String checkDay() {
    final DateTime now = DateTime.now();
    final String today = DateFormat('EEEEE', 'en_US').format(now);
    return today;
  }
}
