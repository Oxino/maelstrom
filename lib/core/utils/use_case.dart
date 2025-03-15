///{@category core}
///{@category Use Cases}

///All use case implements this abstract class
abstract class UseCase<Type, Params> {
  Future<Type> call({required Params params});
}
