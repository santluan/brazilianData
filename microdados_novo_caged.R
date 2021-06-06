# Script para download dos dados do Novo CAGED

# Definir caminho para download
setwd('D:/Downloads')

# Pelo browser, verifique o ultimo mes disponivel no link
link <- "ftp://ftp.mtps.gov.br/pdet/microdados/NOVO%20CAGED/"

# funcao p/ download dos dados de Estabelecimentos
microdados.novo.caged <- function(tipo, dt, ultimo_mes) {
  
  # tipo - argumento para especificar o tipo de dados a ser extraido
  # dt - recebe um vetor de data para o mes desejado
  # ultimo_mes - argumento de tipo 'character' que recebe o ultimo mes disponível no link
  
  link = "ftp://ftp.mtps.gov.br/pdet/microdados/NOVO%20CAGED/"
  
  # Não executa caso não sejam satisfeitas as condições
  stopifnot(is(dt, "Date"), length(dt) == 1,
            is(ultimo_mes, "character"), length(ultimo_mes) == 1,
            tipo %in% c("Estabelecimentos", "Movimentações"))
  
  if(tipo == 'Movimentações'){
    url = paste0(link, 'Movimenta%E7%F5es/', format(dt, '%Y/'), ultimo_mes, format(dt, '/CAGEDMOV%Y%m.7z'))
    filename = format(dt, "CAGEDMOV%Y%m.7z")
  } else {
    if(format(dt, '%Y') == 2020) {
      url = paste0(link, 'Estabelecimentos/', ultimo_mes, format(dt, '/CAGEDESTAB%Y%m.7z'))
      filename = format(dt, "CAGEDESTAB%Y%m.7z")
    } else {
      url = paste0(link, 'Estabelecimentos/', format(dt, '%Y/'), ultimo_mes, format(dt, '/CAGEDESTAB%Y%m.7z'))
      filename = format(dt, "CAGEDESTAB%Y%m.7z")
      }
  }
  
  # Download dos dados
  download.file(url = url, destfile = filename, mode = "wb")
  
}

# teste
microdados.novo.caged("Movimentações", as.Date("2021-04-01"), "Abril")
microdados.novo.caged("Estabelecimentos", as.Date("2021-04-01"), "Abril")

