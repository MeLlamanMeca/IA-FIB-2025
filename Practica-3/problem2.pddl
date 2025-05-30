(define (problem planificador-comidas)
    (:domain generador)

    (:objects
        sopa ensalada arroz pasta gazpacho tortilla crepes pescado carne pollo ternera cerdo salmon merluza atun - plato
        lunes martes miercoles jueves viernes end - dia
        tipo1 tipo2 - tipo
    )

    (:init
        ;; Comenzamos a lunes
        (dia-actual lunes)

        ;; Toca asignar el primer plato
        (not (primero-asignado))
        (not (segundo-asignado))
        (dia-completado)

        ;; Ningún dia está completado
        (not (completado lunes))
        (not (completado martes))
        (not (completado miercoles))
        (not (completado jueves))
        (not (completado viernes))

        ;; Primeros
        (es-primero sopa)
        (es-primero ensalada)
        (es-primero arroz)
        (es-primero pasta)
        (es-primero gazpacho)
        (es-primero tortilla)
        (es-primero crepes)

        ;; Segundos
        (es-segundo pescado)
        (es-segundo carne)
        (es-segundo pollo)
        (es-segundo ternera)
        (es-segundo cerdo)
        (es-segundo salmon)
        (es-segundo merluza)
        (es-segundo atun)

        ;; Tipos
        (tiene-tipo sopa tipo1)
        (tiene-tipo ensalada tipo1)
        (tiene-tipo arroz tipo2)
        (tiene-tipo pasta tipo2)
        (tiene-tipo gazpacho tipo1)
        (tiene-tipo tortilla tipo1)
        (tiene-tipo crepes tipo2)

        (tiene-tipo pescado tipo2)
        (tiene-tipo carne tipo1)
        (tiene-tipo pollo tipo2)
        (tiene-tipo ternera tipo1)
        (tiene-tipo cerdo tipo1)
        (tiene-tipo salmon tipo2)
        (tiene-tipo merluza tipo2)
        (tiene-tipo atun tipo2)

        ;; Incompatibilidades
        (incompatible sopa pollo)
        (incompatible arroz carne)
        (incompatible tortilla salmon)

        ;; Relación de días consecutivos
        (dia-siguiente lunes martes)
        (dia-siguiente martes miercoles)
        (dia-siguiente miercoles jueves)
        (dia-siguiente jueves viernes)
        (dia-siguiente viernes end)
    )

    (:goal
        (and
            ;; El objetivo es completar todos los dias
            (completado lunes)
            (completado martes)
            (completado miercoles)
            (completado jueves)
            (completado viernes)

            ;; Acabamos el dia end
            (dia-actual end)
        )
    )
)