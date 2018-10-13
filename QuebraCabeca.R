source("Estado.R")

QuebraCabeca <- function(desc=NULL, pai=NULL){
  e <- environment()
  assign("desc", desc, envir = e)
  assign("pai", pai, envir = e)
  assign("g", 0, envir = e)
  assign("h", Inf, envir = e)
  assign("f", Inf, envir = e)
  class(e) <- c("QuebraCabeca", "Estado")
  
  return(e)
}

Ops.QuebraCabeca = function(obj1,obj2){
  if(.Generic == "=="){
    return(all(obj1$desc == obj2$desc))
  }
}

print.QuebraCabeca <- function(obj){
  matrix_print <- t(matrix(obj$desc,nrow=3,ncol=3))
  print(matrix_print)
  cat("G(n):",obj$g, "\n")
  cat("H(n):",obj$h, "\n")
  cat("F(n):",obj$f, "\n")
}
heuristica <- function(atual, ...) {
	if(is.null(atual$desc))
    	return(Inf)

   matrizObjetivo = matrix(c(0, 1, 2, 3, 4, 5, 6, 7, 8),nrow = 3,ncol = 3)
   matrizAtual = matrix(atual$desc,nrow = 3,ncol = 3)
   distanciaManhattan = 0  

   for (i in 1:3) {
    for (j in 1:3) {
        elemento = matrizAtual[i,j]
        localCorreto = which(matrizObjetivo == elemento,arr.ind=T) # achar local correto do elemento
        distanciaElemento = localCorreto - c(i,j) # sutrai local atual do local correto para obter a distancia
        distanciaManhattan = distanciaManhattan + abs(distanciaElemento[1]) + abs(distanciaElemento[2])
    }
   }
	return(distanciaManhattan)
}

geraFilhos <- function(obj) {
	desc <- obj$desc
	matrizOriginal <- t(matrix(desc, nrow=3, ncol=3))
	filhosDesc <- list()
	filhos <- list()
  nroElementos <- 0
  operadores <- rbind(c(0,1), c(1,0), c(0,-1), c(-1,0))
	localZero<- which(matrizOriginal == 0, arr.ind=T)
  
  for (i in 1:nrow(operadores)) {

    novoLocalZero = localZero+operadores[i,]

    if(novoLocalZero[1] > 3 
    || novoLocalZero[1] < 1 
    || novoLocalZero[2] > 3 
    || novoLocalZero[2] < 1) next # posições que estrapolam a matriz

    novaMatriz <- matrizOriginal
    novaMatriz[localZero] <- novaMatriz[novoLocalZero]
    novaMatriz[novoLocalZero] <- 0

    filhosDesc <- c(filhosDesc, unlist(c(t(novaMatriz))))
    nroElementos <- nroElementos +1
  }



	filhosDesc = matrix(c(filhosDesc), ncol=nroElementos, nrow=length(desc))
	for(j in 1:ncol(filhosDesc)){
		filhoDesc <- unlist(filhosDesc[,j])
		filho <- QuebraCabeca(desc=filhoDesc, pai=obj)
		filho$h <- heuristica(filho)
		filho$g <- filho$pai$g+1
		filho$f <- filho$h
		filhos <- c(filhos, filho)
	}

	return(filhos)
}