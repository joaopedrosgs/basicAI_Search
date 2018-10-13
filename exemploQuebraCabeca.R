source("QuebraCabeca.R")
source("buscaDesinformada.R")
source("buscaInformada.R")

inicial <- QuebraCabeca(desc = c(1,0,3,2,4,5,6,7,8))
objetivo <- QuebraCabeca()
objetivo$desc <- c(0,1, 2, 3, 4, 5, 6, 7, 8)

cat("====\tBusca em Largura\t====\n")
print(unlist(buscaEmLargura(inicial, objetivo)))

cat("====\tBusca em Profundidade\t=====\n")
print(buscaEmProfundidade(inicial, objetivo))

cat("====\tBusca de Custo Uniforme\t=====\n")
print(buscaCustoUniforme(inicial, objetivo))

cat("====\tBusca Best-First (Gulosa)\t=====\n")
print(buscaBestFirst(inicial, objetivo, "Gulosa"))
 
cat("====\tBusca Best-First (A*)\t=====\n")
print(buscaBestFirst(inicial, objetivo, "AEstrela"))