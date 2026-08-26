archivos <- list.files(pattern = "\.[rR]$")
arch_al <- archivos[archivos != "validador_r.R"]
if (length(arch_al) > 0) {
  entorno <- new.env()
  sys.source(arch_al[1], envir = entorno)
  vars <- ls(entorno)
  vars_upper <- toupper(vars)
  
  for (req in c("NOMBRE", "NUMERO_CUENTA", "CORREO", "CARRERA", "SEMESTRE")) {
    if (!req %in% vars_upper) stop(paste("Falta definir la variable", tolower(req)))
  }
  
  get_val <- function(v) get(vars[which(vars_upper == v)[1]], envir = entorno)
  cuenta <- gsub("[- ]", "", trimws(as.character(get_val("NUMERO_CUENTA"))))
  if (nchar(cuenta) != 9 || !grepl("^[0-9]+$", cuenta)) stop("numero_cuenta debe tener 9 digitos.")
  if (nchar(trimws(as.character(get_val("NOMBRE")))) < 5) stop("nombre demasiado corto.")
  if (!grepl("@", as.character(get_val("CORREO"))) || !grepl("\.", as.character(get_val("CORREO")))) stop("correo invalido.")
  if (as.numeric(get_val("SEMESTRE")) <= 0) stop("semestre invalido.")
}