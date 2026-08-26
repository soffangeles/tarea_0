suppressPackageStartupMessages(library(digest))

hashes_validos <- c(
  "9f41ef4aa8d8d386407db3bb7d9039641fbcf0773d52670e3dfb52b2f63f538e",
  "c8a005086d34e6d4212ec828d5d4d6233cfcbbdfbfbeba8ebba3a79d3cb5cbfa",
  "e9c56ca59e9842f4fa815e065bf1ce45bb5625fbca027c62bb95f54fcba231b1",
  "485d45d6cfd506d86016e45f94b3017a4261da4ca380e227a94d8050e82845c4",
  "73229b4e803c58b4491ba63013d3170e7046ae45b14f828a2a89326f582f3273",
  "7d162cb08a9f464010373e91eb704bc7a5c613e51aeeaa780e922b79e2730ca7",
  "9ba90ebc1da7361bbdcba15cb38db3ca4b449c28ea9fbfae0370642fbb1c7a82",
  "44ae39f993d9b0dc9860c23c213426eefb4081c3dfb867c2957b4200fc00f274",
  "06ea49a1752df71ff6d21798363ae168a2bf6132dafa49be4b360f03fa55b8eb",
  "fe2bb3d5966eb81561f55a15324d06a9ca8b991be263d91cf3e03102377484aa",
  "1d2797e88b8f2d5e2361cfd33d9fa9fce05f42c11ee36d6be499a0e6988dc82f",
  "670498eb752efc1592c34bc14d60da5490bc89e3a6119fe29f6b9c9f7a42142e",
  "dff8751db55d14dfb0ae24dd78cb372579dfd9ea4c45b850dbda1365313a0781",
  "b84178619bcbb9d6a36d2e67303c73496bc43c16dd19920ef11bcbf6d31bbfae",
  "3f39a4897f2231bf315f20ba8a7c2d1b7cfebc3bfae68e4a9042b36e4f16b251",
  "e9d5ca254c2596be7f56641e786b51bf128d58aeb9dc23cfb8964d420aa2a373",
  "eec248232959846313b28b7e283ba4ebad0391f6dbe9042e4745778a541624c9",
  "c5e0325d742b6a9bc272f2dc705ca65d2146e27aa07a0494df9fcf785bc0b299",
  "00eb25c7e11f185ef3f87c8846c48e895be984643501a35122e3eaee6e54f0a0",
  "eb9d115e5bcfecb7aa72d579fdf55998aeb3d15448b1fc5581e289bf655da909",
  "b1e9c20a9a4639d67b2d56a3e29f074d3d81b37699ca108bc0a5bcf4ce6bbf20",
  "4756598c0b25e7eaefd3f820250df7a6b0c2a297e6153a51fefeb244b7d03612",
  "9c1df8ae2d36eb8b50f7575218d6e353597c413b9423c9213bc54df2fb2167d4",
  "4d547fecf310f88b0fefaf15f5c35da24c03b1e7790b8f108d172e2762a49b06",
  "734a9ef1c9b68c96ba1e843eeb2957b4cbaef52d19f2a969fba75f73d639b75a",
  "2669e46a7ceee52e259e495204fc3d18e803c4f9bc2ee5c8cbca8cce2632b620",
  "993fef6dc5ba8d7c489b4f0b2f5b61b7f038676d1e4eb4cf84860714eb6db9cb",
  "4b93db0ec9a4195159fc5db029cfaf98889980d21a221434cb2c8d57579f1db1"
)

archivos <- list.files(pattern = "\\.[rR]$")
archivos_alumno <- archivos[archivos != "validador_r.R"]

if (length(archivos_alumno) > 0) {
  source(archivos_alumno[1])

  if (!exists("nombre") || !exists("numero_cuenta") || !exists("correo") || 
      !exists("carrera") || !exists("semestre")) {
    stop("Error: Faltan variables por definir.")
  }

  cuenta_limpia <- gsub("-", "", trimws(as.character(numero_cuenta)))
  cuenta_hash <- digest::digest(cuenta_limpia, algo = "sha256", serialize = FALSE)

  if (!cuenta_hash %in% hashes_validos) {
    stop("Error: El número de cuenta no coincide con la lista oficial.")
  }

  if (nchar(trimws(nombre)) < 5) stop("Error: Nombre demasiado corto.")
  if (!grepl("@", correo) || !grepl("\\.", correo)) stop("Error: Correo inválido.")
  if (!is.numeric(semestre) || semestre <= 0) stop("Error: Semestre inválido.")
}
