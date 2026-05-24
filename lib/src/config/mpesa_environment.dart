enum MpesaEnvironment {
  sandbox('api.sandbox.vm.co.mz'),
  production('api.vm.co.mz');

  const MpesaEnvironment(this.defaultHost);

  final String defaultHost;
}
