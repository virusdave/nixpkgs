{ stdenv, fetchFromGitHub
, pkgconfig, bison, flex
, tcl, readline, libffi, python3
, protobuf, zlib
}:

with builtins;

stdenv.mkDerivation rec {
  pname = "yosys";
  version = "2019.08.13";

  srcs = [
    (fetchFromGitHub {
      owner  = "yosyshq";
      repo   = "yosys";
      rev    = "19d6b8846f55b4c7be705619f753bec86deadac8";
      sha256 = "185sbkxajx3k9j03n0cxq2qvzwfwdbcxp19h8vnk7ghd5y9gp602";
      name   = "yosys";
    })

    # NOTE: the version of abc used here is synchronized with
    # the one in the yosys Makefile of the version above;
    # keep them the same for quality purposes.
    (fetchFromGitHub {
      owner  = "berkeley-abc";
      repo   = "abc";
      rev    = "5776ad07e7247993976bffed4802a5737c456782";
      sha256 = "1la4idmssg44rp6hd63sd5vybvs3vr14yzvwcg03ls37p39cslnl";
      name   = "yosys-abc";
    })
  ];
  sourceRoot = "yosys";

  enableParallelBuilding = true;
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ tcl readline libffi python3 bison flex protobuf zlib ];

  makeFlags = [ "ENABLE_PROTOBUF=1" ];

  patchPhase = ''
    substituteInPlace ../yosys-abc/Makefile \
      --replace 'CC   := gcc' ""
    substituteInPlace ./Makefile \
      --replace 'CXX = clang' "" \
      --replace 'ABCMKARGS = CC="$(CXX)"' 'ABCMKARGS =' \
      --replace 'echo UNKNOWN' 'echo ${substring 0 10 (elemAt srcs 0).rev}'
  '';

  preBuild = ''
    chmod -R u+w ../yosys-abc
    ln -s ../yosys-abc abc
    make config-${if stdenv.cc.isClang or false then "clang" else "gcc"}
    echo 'ABCREV := default' >> Makefile.conf
    makeFlags="PREFIX=$out $makeFlags"

    # we have to do this ourselves for some reason...
    (cd misc && ${protobuf}/bin/protoc --cpp_out ../backends/protobuf/ ./yosys.proto)
  '';

  meta = {
    description = "Framework for RTL synthesis tools";
    longDescription = ''
      Yosys is a framework for RTL synthesis tools. It currently has
      extensive Verilog-2005 support and provides a basic set of
      synthesis algorithms for various application domains.
      Yosys can be adapted to perform any synthesis job by combining
      the existing passes (algorithms) using synthesis scripts and
      adding additional passes as needed by extending the yosys C++
      code base.
    '';
    homepage    = http://www.clifford.at/yosys/;
    license     = stdenv.lib.licenses.isc;
    maintainers = with stdenv.lib.maintainers; [ shell thoughtpolice ];
    platforms   = stdenv.lib.platforms.unix;
  };
}
