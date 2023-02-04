abstract class LoginStates {}

class LoginInitialState extends LoginStates {}
class ChangeIconState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginFailureState extends LoginStates {}
class LoginSuccessState extends LoginStates {}