
class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}


class ForgetRequestRequest {
  String email;
  ForgetRequestRequest(this.email);
}


class RegisterRequest {
   String userName;
   String email ;
   String password ;
   RegisterRequest(this.userName, this.email, this.password);
}

