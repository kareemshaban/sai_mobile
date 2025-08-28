import 'package:new_sai/data/data_source/store_data_source/store_remote_data_source.dart';
import 'package:new_sai/data/repository/store_repository_impl.dart';
import 'package:new_sai/domain/repository/store_repository.dart';
import 'package:new_sai/domain/use_case/store_use_case/add_address_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/add_order_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/add_remove_favorite_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/apply_coupon_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/cancel_order_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/delete_address_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_delivery_price_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_home_data_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_my_addresses_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_my_favorite_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_order_details_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_product_details_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/get_product_filter_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/search_product_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/update_address_use_case.dart';

import '../../domain/use_case/store_use_case/get_orders_use_case.dart';
import 'basic_di.dart';

initStoreModule() {
  instance.registerLazySingleton<StoreRemoteDataSource>(
      () => StoreRemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<StoreRepository>(() => StoreRepositoryImpl(
        instance(),
        instance(),
      ));

  instance.registerLazySingleton<GetHomeDataUseCase>(
      () => GetHomeDataUseCase(instance()));

  instance.registerLazySingleton<GetMyAddressesUseCase>(
      () => GetMyAddressesUseCase(instance()));

  instance.registerLazySingleton<AddRemoveFavoriteUseCase>(
    () => AddRemoveFavoriteUseCase(instance()),
  );

  instance.registerLazySingleton<GetMyFavoriteUseCase>(
    () => GetMyFavoriteUseCase(instance()),
  );

  instance.registerLazySingleton<AddAddressUseCase>(
    () => AddAddressUseCase(instance()),
  );

  instance.registerLazySingleton<UpdateAddressUseCase>(
    () => UpdateAddressUseCase(instance()),
  );

  instance.registerLazySingleton<DeleteAddressUseCase>(
    () => DeleteAddressUseCase(instance()),
  );

  instance.registerLazySingleton<GetOrdersUseCase>(
    () => GetOrdersUseCase(instance()),
  );

  instance.registerLazySingleton<GetProductDetailsUseCase>(
    () => GetProductDetailsUseCase(instance()),
  );

  instance.registerLazySingleton<ApplyCouponUseCase>(
    () => ApplyCouponUseCase(instance()),
  );

  instance.registerLazySingleton<AddOrderUseCase>(
    () => AddOrderUseCase(instance()),
  );

  instance.registerLazySingleton<SearchProductUseCase>(
    () => SearchProductUseCase(instance()),
  );

  instance.registerLazySingleton<GetProductFilterUseCase>(
    () => GetProductFilterUseCase(instance()),
  );

  instance.registerLazySingleton<GetDeliveryPriceUseCase>(
    () => GetDeliveryPriceUseCase(instance()),
  );

  instance.registerLazySingleton<GetOrderDetailsUseCase>(
    () => GetOrderDetailsUseCase(instance()),
  );

  instance.registerLazySingleton<CancelOrderUseCase>(
    () => CancelOrderUseCase(instance()),
  );
}
