import 'package:tzwad_mobile/core/local_data/app_hive_adapter_enum.dart';
import 'package:tzwad_mobile/core/local_data/app_local_data.dart';
import 'package:tzwad_mobile/features/auth/models/user_model.dart';

String keyUserInfo = "KEY_USER_INFO";

class UserLocalData extends AppLocalData<UserModel> {
  UserLocalData()
      : super(
          boxName: AppHiveAdapterEnum.userAdapter.boxName,
        );

  void setUser(UserModel user) {
    insert(user.id, user);
  }

  UserModel? getUser(String id) {
    return getByKey(id);
  }

  void setUserInfo(UserModel user) {
    insert(keyUserInfo, user);
  }

  UserModel? getUserInfo() {
    return getByKey(keyUserInfo);
  }

  void removeUser(int id) {
    delete(id);
  }

  void clearBoxUser() {
    box.clear();
  }
}
