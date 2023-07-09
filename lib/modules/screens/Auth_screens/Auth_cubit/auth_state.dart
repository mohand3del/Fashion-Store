abstract class AuthStates {

}
class AuthInitialState extends AuthStates {

}
class RegisterLoadingState extends AuthStates{

}
class RegisterSuccessState extends AuthStates{

}
class FieldToRegisterState extends AuthStates{
   String message;
   FieldToRegisterState({required this.message});
}

class LoginLoadingState extends AuthStates{

}
class LoginSuccessState extends AuthStates{

}
class FieldToLoginState extends AuthStates{
   String message;
   FieldToLoginState({required this.message});
}