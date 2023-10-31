abstract class BaseDTOObject<T> {
  void validate();

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
