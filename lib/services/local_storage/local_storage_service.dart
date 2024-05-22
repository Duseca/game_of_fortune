import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  // Private constructor
  LocalStorageService._privateConstructor();

  // Singleton instance variable
  static LocalStorageService? _instance;

  // Getter to access the singleton instance
  static LocalStorageService get instance {
    _instance ??= LocalStorageService._privateConstructor();
    return _instance!;
  }

  // Initializing Get Storage instance
  final _box = GetStorage();

  // Method to writeList into local storage
  Future<void> writeList({required String key, required List value}) async {
    await _box.write(key, value);
  }

  Future<void> write({required String key, required dynamic value}) async {
    await _box.write(key, value);
  }

  // Method to read from local storage
  Future<dynamic> read({required String key}) async {
    return await _box.read(key);
  }

  // Method to delete a key from the local storage service
  Future<void> deleteKey({required String key}) async {
    await _box.remove(key);
  }

  // Function to add an item to a specific list and save it to local storage
  Future<void> addItemToList(
      {required String listKey, required dynamic item}) async {
    // Read the current list from local storage
    List? currentList = await read(key: listKey);
    // If the list is null, initialize it as an empty list
    currentList ??= [];
    // Add the new item to the list
    currentList.add(item);
    // Save the updated list back to local storage
    await writeList(key: listKey, value: currentList.cast());
  }
}
