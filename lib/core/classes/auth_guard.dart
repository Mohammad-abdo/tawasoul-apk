class AuthGuard {
  static bool canAccess(int index, bool isLoggedIn) {
    if (index == 0) return true;
    return isLoggedIn;
  }

}
