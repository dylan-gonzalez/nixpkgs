{ lib
, bcrypt
, buildPythonPackage
, cryptography
, fetchPypi
, invoke
, mock
, pyasn1
, pynacl
, pytest-relaxed
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "paramiko";
  version = "2.9.1";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-of3e07VfYdIzieT+UtmuQolgrJWNLt9QNz+qXYkm7dA=";
  };

  propagatedBuildInputs = [
    bcrypt
    cryptography
    pyasn1
    pynacl
  ];

  checkInputs = [
    invoke
    mock
    pytest-relaxed
    pytestCheckHook
  ];

  # with python 3.9.6+, the deprecation warnings will fail the test suite
  # see: https://github.com/pyinvoke/invoke/issues/829
  doCheck = false;

  disabledTestPaths = [
    "tests/test_sftp.py"
    "tests/test_config.py"
  ];

  pythonImportsCheck = [
    "paramiko"
  ];

  __darwinAllowLocalNetworking = true;

  meta = with lib; {
    homepage = "https://github.com/paramiko/paramiko/";
    description = "Native Python SSHv2 protocol library";
    license = licenses.lgpl21Plus;
    longDescription = ''
      Library for making SSH2 connections (client or server). Emphasis is
      on using SSH2 as an alternative to SSL for making secure connections
      between python scripts. All major ciphers and hash methods are
      supported. SFTP client and server mode are both supported too.
    '';
    maintainers = with maintainers; [ ];
  };
}
