import random


numero_aleatorio = random.randint(25, 500) # Cambiar indices al gusto
print("(define (problem planificador-comidas)\n(:domain generador)\n")
print("(:objects", end=" ")
for i in range(numero_aleatorio + 1):
    print(f"p{i}", end=" ")
print("- plato")
print(" lunes martes miercoles jueves viernes end - dia\n)")

print("""(:init
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
    (not (completado viernes))""")

for i in range(numero_aleatorio + 1):
    if random.random() < 0.5:
        print(f"    (es-primero p{i})")
    else:
        print(f"    (es-segundo p{i})")

for i in range(numero_aleatorio + 1):
    for j in range(i + 1, numero_aleatorio + 1):
        if random.random() < 0.05:  # Ajusta la probabilidad al gusto
            print(f"    (incompatible p{i} p{j})")


print("""   (dia-siguiente lunes martes)
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
)""")