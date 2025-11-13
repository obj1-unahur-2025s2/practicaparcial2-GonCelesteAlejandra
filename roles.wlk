class Personaje {
  const property fuerza
  const property inteligencia
  var rol

  method cambiarRol(unRol) {
    rol = unRol
  }

  method potencialOfensivo() {
    return 
    fuerza * 10 + rol.extra()
  }

  method esInteligente()

  method esGroso() = self.esInteligente() || 
                     rol.esGroso(self)
}

object rolGuerrero {
  method extra() = 100
  method brutalidadInnata(unValor) = 0
  method esGroso(unPersonaje) {
    return
    unPersonaje.fuerza() > 50
  }
}

class RolCazador {
  var mascota = new Mascota (fuerza=0, edad=0, tieneGarras=false)
  
  method cambiarMascota(unaMascota) {
    mascota = unaMascota
  }

  method naceNuevaMascota(fuerza, edad, tieneGarras) {
    mascota = new Mascota (fuerza=fuerza, edad=edad, tieneGarras=tieneGarras)
  }

  method extra() = mascota.potencial()

  method brutalidadInnata(unValor) = 0

  method esGroso(unPersonaje) = mascota.esLongeva()
}

class Mascota {
  const fuerza
  const edad 
  const tieneGarras

  method initialize() {
    if(fuerza > 100){
      self.error("la mascota no puede tener una fuerza mayor a 100")
    }
  }

  method esLongeva() = edad > 10
  method potencial() = if(tieneGarras) fuerza * 2 else fuerza
}

object rolBrujo {
  method extra() = 0
  method brutalidadInnata(unValor) = unValor * 0.1
  method esGroso(unPersonaje) = true
}

class Orco inherits Personaje {
  override method potencialOfensivo() {
    return 
    super() + rol.brutalidadInnata(super())
  }

  override method esInteligente() = false
}

class Humano inherits Personaje {

  override method esInteligente() = inteligencia > 50

}