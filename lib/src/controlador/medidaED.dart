class MedidaED {
  int _numMedidaED;
  bool _valor;
  String _descripcion;
  String _fechaInicio;
  String _fechaFinal;
  MedidaED();

  setNumeroMedidaED(int n) {
    _numMedidaED = n;
  }

  setDescripcion(String n) => _descripcion = n;

  setFechaInicio(String n) => _fechaInicio = n;

  setFechaFinal(String n) => _fechaFinal = n;

  setValor(bool n) => _valor = n;

  int getNumeroMedidaED() => _numMedidaED;

  String getDescripcion() => _descripcion;

  String getFechaInicio() => _fechaInicio;

  String getFechaFinal() => _fechaFinal;

  bool getValor() => _valor;
}
