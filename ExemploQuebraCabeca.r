source("QuebraCabeca.R")
source("buscaDesinformada.R")
source("buscaInformada.R")


inicial <- QuebraCabeca(desc = c(1,-1,3,2,4,5,6,7,8)) ## 8 peças e 1 lugar vazio     
print(inicial)

objetivo <- QuebraCabeca(desc =c(-1,1,2,3,4,5,6,7,8))
print(objetivo$desc)



cat("====\tBusca de Custo Uniforme\t=====\n")
print(buscaCustoUniforme(inicial, objetivo))

cat("====\tBusca Best-First (Gulosa)\t=====\n")
print(buscaBestFirst(inicial, objetivo, "Gulosa"))

cat("====\tBusca Best-First (A*)\t=====\n")
print(buscaBestFirst(inicial, objetivo, "AEstrela"))
