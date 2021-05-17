class Parte {
  int _numeroParte;
  String _niaAlm;
  String _nombreSancionado;
  String _grupoSancioando;
  String _nombreProfesor;
  String _descripcion;
  String _fecha;
  String _hora;
  String _observacionComTel;
  String _fechaComTel;
  Parte(
      /*  
      this._numeroParte,
      this._nombreSancionado,
      this._grupoSancioando,
      this._nombreProfesor,
      this._descripcion,
      this._fecha,
      this._hora,
      this._observacionComTel,
      this._fechaComTel */
      );

  int getNumParte() => _numeroParte;

  String getNia() => _niaAlm;

  String getNombreSancionado() => _nombreSancionado;

  String getGrupoSancioando() => _grupoSancioando;

  String getNombreProfesor() => _nombreProfesor;

  String getDescripcion() => _descripcion;

  String getFecha() => _fecha;

  String getHora() => _hora;

  String getObservacionComTel() => _observacionComTel;

  String getFechaComTel() => _fechaComTel;

  setNumParte(int n) {
    _numeroParte = n;
  }

  setNombreSancionado(String n) => _nombreSancionado = n;

  setGrupoSancioando(String n) => _grupoSancioando = n;

  setNombreProfesor(String n) => _nombreProfesor = n;

  setDescripcion(String n) => _descripcion = n;

  setNiaAlumno(String n) => _niaAlm = n;

  setFecha(String n) => _fecha = n;

  setHora(String n) => _hora = n;

  setObservacionComTel(String n) => _observacionComTel = n;

  setFechaComTel(String n) => _fechaComTel = n;
}
