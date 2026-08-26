import glob, importlib.util, sys

def validar():
    archivos = [f for f in glob.glob("*.py") if f != "validador_python.py"]
    if not archivos:
        return
    spec = importlib.util.spec_from_file_location("entrega", archivos[0])
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    attrs = {k.upper(): getattr(m, k) for k in dir(m) if not k.startswith("__")}
    
    for req in ["NOMBRE", "NUMERO_CUENTA", "CORREO", "CARRERA", "SEMESTRE"]:
        assert req in attrs, f"Falta definir la variable {req}"
    
    cuenta = str(attrs["NUMERO_CUENTA"]).strip().replace("-", "").replace(" ", "")
    assert len(cuenta) == 9 and cuenta.isdigit(), f"NUMERO_CUENTA ({cuenta}) debe tener 9 digitos."
    assert len(str(attrs["NOMBRE"]).strip()) >= 5, "NOMBRE demasiado corto."
    assert "@" in str(attrs["CORREO"]) and "." in str(attrs["CORREO"]), "CORREO invalido."
    assert int(attrs["SEMESTRE"]) > 0, "SEMESTRE invalido."

if __name__ == "__main__":
    try:
        validar()
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)