class Tipificacion {
  int _numTipificacion;
  String _descripcion;
  bool _valor;
  Tipificacion();

  setNumeroTipificacion(int n) {
    _numTipificacion = n;
  }

  setDescripcion(String n) => _descripcion = n;

  setValor(bool n) => _valor = n;

  int getNumeroTipificacion() => _numTipificacion;

  String getDescripcion() => _descripcion;

  bool getValor() => _valor;
}
