import glob, importlib.util

archivos = [f for f in glob.glob("*.py") if f != "validador_python.py"]
if archivos:
    spec = importlib.util.spec_from_file_location("mod", archivos[0])
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    for v in ["NOMBRE", "NUMERO_CUENTA", "CORREO", "CARRERA", "SEMESTRE"]:
        assert hasattr(m, v), f"Falta definir la variable {v}"
    
    cuenta = str(modulo.NUMERO_CUENTA if hasattr(modulo, "NUMERO_CUENTA") else m.NUMERO_CUENTA).strip().replace("-", "")
    assert len(cuenta) == 9 and cuenta.isdigit(), "El número de cuenta debe tener exactamente 9 dígitos numéricos."
    assert len(str(m.NOMBRE).strip()) >= 5, "Nombre demasiado corto."
    assert "@" in str(m.CORREO) and "." in str(m.CORREO), "Formato de correo inválido."
    assert isinstance(m.SEMESTRE, int) and m.SEMESTRE > 0, "Semestre inválido."