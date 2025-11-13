import roles.*

class Localidad {
    var ejercito = new Ejercito()

    method enlistar(unPersonaje) {ejercito.agregar(unPersonaje)}

    method poderDefensivo() = ejercito.potencial()

    method serOcupada(unEjercito) 
}

class Aldea inherits Localidad {
    const cantMaxima

    override method enlistar(unPersonaje) {
        if(ejercito.personajes().size() >= cantMaxima){
            self.error("Se alcanzo el limite maximo - ejercito completo")
        }
        super(unPersonaje)
    }

    override method serOcupada(unEjercito){
        ejercito.clear()
        unEjercito.los10MasPoderosos().forEach({p =>
            self.enlistar(p)
        })
        unEjercito.quitarLosMasFuertes(cantMaxima.min(10))
    }
}

class Ciudad inherits Localidad {
    override method poderDefensivo() = super() + 300

    override method serOcupada(unEjercito){
        ejercito = unEjercito
    }
}


class Ejercito {
    const property personajes = #{}

    method potencial() = personajes.sum({p => p.potencialOfensivo()})

    method agregar(unPersonaje) {personajes.add(unPersonaje)}

    method invadir(unaLocalidad) {
        if(self.puedeInvadir(unaLocalidad)){
            unaLocalidad.serOcupada(self)
        }
    }

    method puedeInvadir(unaLocalidad){
        return 
        self.potencial() > unaLocalidad.poderDefensivo()
    }

    method los10MasPoderosos() = self.listaOrdenadaPorPoder().take(10) //toma los primeros diez

    method listaOrdenadaPorPoder(){
        return personajes.asList().sortBy({p1, p2 => p1.potencialOfensivo() > p2.potencialOfensivo()}) //ordena
    }

    method quitarLosMasFuertes(cantQuitar) {
        personajes.removeAll(self.los10MasPoderosos().take(cantQuitar))
    } 
}