abstract class ProductStates {}

class ProductInitialState extends ProductStates {}
class ProductDetailsLoadingState extends ProductStates {}
class ProductDetailsSuccessState extends ProductStates {}
class ProductDetailsErrorState extends ProductStates {}
class IndexState extends ProductStates {}
class ChangeIndexState extends ProductStates {}