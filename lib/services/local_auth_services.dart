final LocalAuthentication localAuth = LocalAuthentication();
final List<BiometricType> availableBiometrics = [];

class BioMatrics {
  Future<bool> authenticateBio() async {
    bool authenticated = false;
    try {
      if (await hasBioMetrics()) {
        authenticated = await localAuth.authenticate(
          localizedReason: 'Authenticate to access the app',
          options: AuthenticationOptions(
            biometricOnly: true,
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    return authenticated;
  }

  Future<bool> hasBioMetrics() async {
    bool hasBioMetrics = false;
    try {
      hasBioMetrics = await localAuth.canCheckBiometrics;
    } catch (e) {
      print(e);
    }
    return hasBioMetrics;
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics = [];
    try {
      availableBiometrics = await localAuth.getAvailableBiometrics();
    } catch (e) {
      print(e);
    }
    return availableBiometrics;
  }
}
