abstract class BaseModel<T> {
  //Creates an object from the Map data structure
  T fromJson(Map<String, dynamic> json);
  // Create a new Object T type
  T createObject();
}
