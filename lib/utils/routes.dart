class Routes {
  static const login = "login";
  static const signup = "signup";
  static const home = "home";
  static const main = "main";
  static const code = "code";
  static const agents = "agents";
  static const subscriptions = "subscriptions";

  static const homeRoute = "/$home";
  static const agentsRoute = "/$agents";
  static const subscriptionsRoute = "/$subscriptions";

  static const mainRoute = "/$main";
  static const loginRoute = "$mainRoute/$login";
  static const signupRoute = "$mainRoute/$signup";
  static const codeRoute = "$signupRoute/$code";
}
