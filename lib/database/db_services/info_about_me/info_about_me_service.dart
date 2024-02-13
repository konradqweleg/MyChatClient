abstract class InfoAboutMeService{
  Future<void> setName(String name);
  Future<void> setSurname(String surname);
  Future<void> setId(int id);
  Future<String> getName();
  Future<String> getSurname();
  Future<int> getId();


}