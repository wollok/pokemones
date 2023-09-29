import wollok.game.*

object juego{
	
	
	method iniciar() {
		
		game.height(15)
		game.width(22)
		
		100.times({ x =>
			game.schedule( 
				x*100, 
				{game.addVisual(new Dragon(fuerza = 10,position = self.aleatoria()))
				game.addVisual(new Agua(estado = [hidratado,seco,humedo].anyOne(),position = self.aleatoria()))
				}
			)
		})
	}
	
	method aleatoria() = 
	game.at(
		(0..game.width()-1).anyOne(),
		(0..game.height()-1).anyOne()
	)
}


class Dragon{
	var fuerza
	var nivel = 1
	var position
	
	method image() = "dragon.png"
	
	method position() = position
	
	method poder()= nivel*fuerza
	method entrenar(){} 
}

class Fuego {
	var poder = 1500
	method poder()= poder
	method entrenar(){
		poder = poder + 100
	}
}

class Electrico {
	var nombre
	var nivel = 1
	method poder() = nombre.length() * nivel * 10
	method entrenar(){
		nivel = nivel + 1
	} 
}

class Agua {
	var estado
	var cantidadAgua = 10
	var position
	method poder(){
		return estado.poder(cantidadAgua)
	}
	method entrenar(){
		estado = estado.sigEstado(cantidadAgua)
	}
	method position() = position
	method image() = "moneda" + estado.color() + ".png"
}

object hidratado{
	method poder(cantidadAgua)
	{
		return 500 + cantidadAgua * 10
	}
	method sigEstado(cantidadAgua) = self
	method color() = "Rojo"
	
	}
object humedo{
	method poder(cantidadAgua)
	{
		return cantidadAgua * 10
	}
	method sigEstado(cantidadAgua) = hidratado
	method color() = "Azul"
}
object seco{
	method poder(cantidadAgua)
	{
		return 0
	}
	method sigEstado(cantidadAgua) {
		if (cantidadAgua == 0){
			return humedo
		} else {
			return self
		}
	}
	method color() = "Amarillo"
}


class Detective {
	var misteriosResueltos
	
}


class Entrenador {
	
	var equipo = []
	
	method agregarPokemon(p){
		equipo.add(p)
	}
	
	method entrenarEquipo(){
		equipo.forEach({x => x.entrenar()})
	}
	
	method poderTotal(){
		return equipo.sum({x => x.poder()})
	}
	
}