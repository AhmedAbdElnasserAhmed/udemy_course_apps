abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates
{
  final String uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates
{
  final String error;

  SocialLoginErrorState(this.error);
}

class SocialChangePasswordVisibilityState extends SocialLoginStates {}

class SocialGetUserLoadingState extends SocialLoginStates {}

class SocialGetUserSuccessState extends SocialLoginStates {}

class SocialGetUserErrorState extends SocialLoginStates
{
  final String error;

  SocialGetUserErrorState(this.error);
}