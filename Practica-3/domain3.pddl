(define (domain generador)
    (:requirements :adl :typing :equality :strips)
    (:types plato dia tipo)

    (:predicates
        ;; Estos predicados modelan las caracteristicas de un plato
        (es-primero ?p - plato)                         ; p es un primero
        (es-segundo ?p - plato)                         ; p es un segundo
        (incompatible ?p1 - plato ?p2 - plato)          ; p1 y p2 son incompatibles


        (utilizado ?p - plato)                      ; p ha sido utilizado esta semana (Restricción extenson 2)
        (tiene-tipo ?p - plato ?t - tipo)                   ; p es del tipo t (Restricción extenson 2)

        ;; Estos predicados se utilizan para que el planificador este forzado a seguir las 3 acciones de forma ordenada y reducir la memoria utilizada.
        (primero-asignado)                       ; Se ha asignado el primer plato (toca asignar el segundo)
        (segundo-asignado)                       ; Se ha asignado el segundo plato (toca completar el dia)
        (dia-completado)                         ; Se han completado las asignaciones de un dia (toca asignar el primero)
        (dia-siguiente ?d1 - dia ?d2 - dia)             ; d2 va despues de d1
        (dia-actual ?d - dia)                               ; Toca planificar el dia d

        ;; El objetivo es completar todos los dias
        (asignado-primero ?p - plato ?d - dia)      ; El plato p esta asignado en el dia d como primero
        (asignado-segundo ?p - plato ?d - dia)          ; El plato p esta asignado en el dia d como segundo
        (completado ?d - dia)                               ; El dia d se ha completado
    )



    ;; Esta acción se encarga de saltar la asignación de segundo en caso de que ya se haya asignado desde un inicio
    (:action saltar-primero
        :parameters (?plato - plato ?dia - dia)
        :precondition (and
            (dia-completado)   

            ; El plato ya está asignado
            (dia-actual ?dia)
            (asignado-primero ?plato ?dia)

            ; Es un primer plato
            (es-primero ?plato)
        )
        :effect (and
            (not (dia-completado))
            (primero-asignado)
        )
    )

    ;; Esta acción asigna el primer plato
    (:action asignar-primero
        :parameters (?primero - plato ?dia - dia)
        :precondition (and
            ; Restricciones de dia
            (dia-completado)   
            (dia-actual ?dia)

            ; Es un primer plato
            (es-primero ?primero)

            ; No se reutiliza un plato mas de una vez por semana
            (not (utilizado ?primero))

            ; No se utiliza el mismo tipo de plato que ayer o mañana
            (not
                (exists (?otrodia - dia ?plato - plato ?tipo - tipo)
                    (and
                        (or 
                            (dia-siguiente ?otrodia ?dia)
                            (dia-siguiente ?dia ?otrodia)
                        )
                        (asignado-primero ?plato ?otrodia)
                        (tiene-tipo ?plato ?tipo)
                        (tiene-tipo ?primero ?tipo)
                    )
                )
            )

            ; No hay ningún plato asignado ya para este día
            (not (exists (?p - plato) (asignado-primero ?p ?dia)))
        )
        :effect (and
            (not (dia-completado))
            (primero-asignado)

            (asignado-primero ?primero ?dia)
            (utilizado ?primero)
        )
    )


    ;; Esta acción se encarga de saltar la asignación de segundo en caso de que ya se haya asignado desde un inicio
    (:action saltar-segundo
        :parameters (?plato - plato ?dia - dia)
        :precondition (and
            (primero-asignado)   

            ; El plato ya está asignado
            (dia-actual ?dia)
            (asignado-segundo ?plato ?dia)

            ; El plato es segundo
            (es-segundo ?plato)
        )
        :effect (and
            (not (primero-asignado))
            (segundo-asignado)
        )
    )

    ;; Esta acción asigna el segundo plato
    (:action asignar-segundo
        :parameters (?primero - plato ?segundo - plato ?dia - dia)
        :precondition (and
            ; Restricciones de dia
            (primero-asignado)   
            (dia-actual ?dia)

            ; El plato es segundo
            (es-segundo ?segundo)

            ; Son compatibles el primero y el segundo
            (asignado-primero ?primero ?dia)
            (and
                (not (incompatible ?primero ?segundo))
                (not (incompatible ?segundo ?primero))
            )

            ; No se reutiliza un plato mas de una vez por semana
            (not (utilizado ?segundo))

            ; No se utiliza el mismo tipo de plato que ayer o mañana
            (not
                (exists (?otrodia - dia ?plato - plato ?tipo - tipo)
                    (and
                        (or 
                            (dia-siguiente ?otrodia ?dia)
                            (dia-siguiente ?dia ?otrodia)
                        )
                        (asignado-segundo ?plato ?otrodia) ; No hace falta comprobar el primero porque ya está verificado por el paso anterior.
                        (tiene-tipo ?plato ?tipo)
                        (tiene-tipo ?segundo ?tipo)
                    )
                )
            )

            ; No hay ningún plato asignado ya para este día
            (not (exists (?p - plato) (asignado-segundo ?p ?dia)))
        )
        :effect (and
            (not (primero-asignado))
            (segundo-asignado)

            (asignado-segundo ?segundo ?dia)
            (utilizado ?segundo)
        )
    )

    ;; Esta acción permite avanzar un dia
    (:action avanzar-dia
        :parameters (?d1 - dia ?d2 - dia)
        :precondition (and
            (dia-actual ?d1)
            (segundo-asignado)
            (dia-siguiente ?d1 ?d2)
        )
        :effect (and
            (not (segundo-asignado))
            (dia-completado)

            (completado ?d1)
            (not (dia-actual ?d1))
            (dia-actual ?d2)
        )
    )
)
