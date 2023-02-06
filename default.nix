{ lib, buildPythonPackage, pybind11, poetry }:

buildPythonPackage rec {
  pname = "cnest";
  version = "1.0.4";

  src = ./.;

  format = "pyproject";

  buildInputs = [
    pybind11
    poetry
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/HorizonRobotics/alf/tree/pytorch/alf/nest";
    description = "C++ implementation of several key nest functions that are preformance critical";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
