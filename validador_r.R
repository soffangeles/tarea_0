archs <- list.files(pattern = "\.[rR]$")
arch_al <- archs[archs != "validador_r.R"]
if (length(arch_al) > 0) {
  source(arch_al[1])
  if (!exists("nombre") || !exists("numero_cuenta") || !exists("correo") || !exists("carrera") || !exists("semestre")) {
    stop("Faltan variables por definir.")
  }
  cuenta <- gsub("-", "", trimws(as.character(numero_cuenta)))
  if (nchar(cuenta) != 9 || !grepl("^[0-9]+$", cuenta)) {
    stop("El número de cuenta debe tener exactamente 9 dígitos numéricos.")
  }
  if (nchar(trimws(nombre)) < 5) stop("Nombre demasiado corto.")
  if (!grepl("@", correo) || !grepl("\.", correo)) stop("Correo inválido.")
  if (!is.numeric(semestre) || semestre <= 0) stop("Semestre inválido.")
}