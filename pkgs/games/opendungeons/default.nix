{ lib, stdenv, fetchFromGitHub, ogre, cegui, boost, sfml, openal, cmake, ois, pkg-config }:

stdenv.mkDerivation {
  pname = "opendungeons";
  version = "unstable-2023-01-09";

  src = fetchFromGitHub {
    owner = "OpenDungeons";
    repo = "OpenDungeons";
    rev = "c180ed1864eab5fbe847d1dd5c5c936c4e45444e";
    hash = "sha256-w9h36WOpWsZxrwD9Hsk9L1+UIXCSKs9TgYFS5O98x3U=";
  };

  patches = [
    ./cmakepaths.patch
    ./fix_link_date_time.patch
  ];

  # source/utils/StackTraceUnix.cpp:122:2: error: #error Unsupported architecture.
  postPatch = lib.optionalString (!stdenv.isx86_64) ''
    cp source/utils/StackTrace{Stub,Unix}.cpp
  '';

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ ogre cegui boost sfml openal ois ];

  meta = with lib; {
    description = "An open source, real time strategy game sharing game elements with the Dungeon Keeper series and Evil Genius";
    homepage = "https://opendungeons.github.io";
    license = with licenses; [ gpl3Plus zlib mit cc-by-sa-30 cc0 ofl cc-by-30 ];
    platforms = platforms.linux;
  };
}
