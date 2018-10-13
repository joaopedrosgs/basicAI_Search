NomeCidades <- c(
    "A", "B", "C", "D",
    "F", "G", "L", "M",
    "O", "P", "R", "S",
    "T", "U", "Z"
)
Heuristicas <- t(c(366,0,160,242,178,77,244,241,380,98,193,253,329,80,374))
colnames(Heuristicas, do.NULL=FALSE)
colnames(Heuristicas) = NomeCidades


PesosArestas <- matrix(c(
    0,0,0,0,0,0,0,0,0,0,0,140,118,0,75
    ,0,0,0,0,211,90,0,0,0,101,0,0,0,85,0
    ,0,0,0,120,0,0,0,0,0,138,146,0,0,0,0
    ,0,0,120,0,0,0,0,75,0,0,0,0,0,0,0
    ,0,211,0,0,0,0,0,0,0,0,0,99,0,0,0
    ,0,90,0,0,0,0,0,0,0,0,0,0,0,0,0
    ,0,0,0,0,0,0,0,70,0,0,0,0,111,0,0
    ,0,0,0,75,0,0,70,0,0,0,0,0,0,0,0
    ,0,0,0,0,0,0,0,0,0,0,0,151,0,0,71
    ,0,101,138,0,0,0,0,0,0,0,97,0,0,0,0
    ,0,0,146,0,0,0,0,0,0,97,0,80,0,0,0
    ,140,0,0,0,99,0,0,0,151,0,80,0,0,0,0
    ,118,0,0,0,0,0,111,0,0,0,0,0,0,0,0
    ,0,0,85,0,0,0,0,0,0,0,0,0,0,0,0
    ,75,0,0,0,0,0,0,0,71,0,0,0,0,0,0
    ), nrow=15, ncol=15)
rownames(PesosArestas, do.NULL = FALSE)
colnames(PesosArestas, do.NULL = FALSE)
rownames(PesosArestas) <- NomeCidades
colnames(PesosArestas) <- NomeCidades

source("Cidades.R")
source("buscaDesinformada.R")
source("buscaInformada.R")

inicial <- Caminho(desc = "A", cidades = PesosArestas, heuristicas = Heuristicas)
objetivo <- Caminho(desc = "U", cidades = PesosArestas, heuristicas = Heuristicas)

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