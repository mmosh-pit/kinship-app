class Routes {
  static const login = "login";
  static const signup = "signup";
  static const home = "home";
  static const main = "main";
  static const code = "code";

  static const homeRoute = "/$home";

  static const mainRoute = "/$login";
  static const loginRoute = "/$login";
  static const signupRoute = "$mainRoute/$signup";
  static const codeRoute = "$signupRoute/$code";
}
