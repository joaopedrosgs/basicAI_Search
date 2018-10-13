source("Estado.R")

Caminho <- function(desc=NULL, pai=NULL, cidades=NULL, heuristicas=NULL){
  
	e <- environment()
	
	assign("desc", desc, envir = e)
	assign("pai", pai, envir = e)
	assign("cidades", cidades, envir = e)
  	assign("heuristicas", heuristicas, envir = e)
	assign("g", 0, envir = e)
	assign("h", Inf, envir = e)
	assign("f", Inf, envir = e)
	
	class(e) <- c("Caminho", "Estado")
	
	return(e)
}

## Sobrecarregando o operador "==" para comparação entre Caminhos
Ops.Caminho = function(obj1,obj2){
 	if(.Generic == "=="){
  		return(all(obj1$desc == obj2$desc))
 	}
}

## Sobrecarga da função genérica print
print.Caminho <- function(obj){
	cat("CIDADE: ", obj$desc, "\n")
	cat("G(N): ", obj$g, "\n")
	cat("H(N): ", obj$h, "\n")
	cat("F(N): ", obj$f, "\n")
}

## Criação do método genérico "heuristica"
heuristica <- function(atual, ...) {
    return(heuristicas[1,atual$desc])
}

## Criação do método genérico "geraFilhos"
geraFilhos <- function(obj) {
    filhosDesc <- list()
	filhos <- list()

	cidades <- obj$cidades
	vizinhos <- t(cidades[obj$desc,])
	colnames(vizinhos, do.NULL=FALSE)
	colnames(vizinhos) <- colnames(cidades)
	filhosDesc <- c(
		filhosDesc,
		colnames(vizinhos)[apply(vizinhos,1,function(vizinhos){which(vizinhos != 0, arr.ind=T)})]
	)
	for(filhoDesc in filhosDesc){
		filho <- Caminho(desc=filhoDesc, pai=obj, cidades = obj$cidades, heuristicas = obj$heuristicas)
		filho$h <- filho$heuristicas[1,filhoDesc]
		filho$g <- obj$g + filho$cidades[1,filhoDesc]
		filho$f <- filho$h + filho$g
		filhos <- c(filhos, list(filho))
	}
	return(filhos)
}