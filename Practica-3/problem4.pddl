(define (problem planificador-comidas)
    (:domain generador)

    (:objects
         sopa ensalada arroz pasta gazpacho tortilla crepes crema macarrones hummus cus_cus brocoli 
        pescado carne pollo ternera cerdo salmon merluza atun tofu hamburguesa huevo_frito gambas cordero - plato
        lunes martes miercoles jueves viernes end - dia
        tipo1 tipo2 tipo3 - tipo
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
        (es-primero crema)
        (es-primero macarrones)
        (es-primero hummus)
        (es-primero cus_cus)
        (es-primero brocoli)

        ;; Segundos
        (es-segundo pescado)
        (es-segundo carne)
        (es-segundo pollo)
        (es-segundo ternera)
        (es-segundo cerdo)
        (es-segundo salmon)
        (es-segundo merluza)
        (es-segundo atun)
        (es-segundo tofu)
        (es-segundo hamburguesa)
        (es-segundo huevo_frito)
        (es-segundo gambas)
        (es-segundo cordero)

        ;; Tipos
        (tiene-tipo sopa tipo1)
        (tiene-tipo ensalada tipo1)
        (tiene-tipo arroz tipo2)
        (tiene-tipo pasta tipo2)
        (tiene-tipo gazpacho tipo1)
        (tiene-tipo tortilla tipo1)
        (tiene-tipo crepes tipo2)        
        (tiene-tipo crema tipo3)
        (tiene-tipo macarrones tipo3)
        (tiene-tipo hummus tipo3)
        (tiene-tipo cus_cus tipo2)
        (tiene-tipo brocoli tipo1)

        (tiene-tipo pescado tipo2)
        (tiene-tipo carne tipo1)
        (tiene-tipo pollo tipo2)
        (tiene-tipo ternera tipo1)
        (tiene-tipo cerdo tipo1)
        (tiene-tipo salmon tipo2)
        (tiene-tipo merluza tipo2)
        (tiene-tipo atun tipo3)
        (tiene-tipo tofu tipo3)
        (tiene-tipo hamburguesa tipo3)
        (tiene-tipo huevo_frito tipo2)
        (tiene-tipo gambas tipo3)
        (tiene-tipo cordero tipo1)

        ;; Platos pre asignados (para el correcto funcionamiento se asume que la asignación es válida, respetando el número de calorías y los tipos)
        (asignado-segundo pollo martes)
        (asignado-primero hummus jueves)
        (utilizado pollo)
        (utilizado hummus)

        ;; Incompatibilidades
        (incompatible sopa pollo)
        (incompatible arroz carne)
        (incompatible tortilla salmon)

        ;; Calorías de primeros
        (= (calorias sopa) 200)
        (= (calorias ensalada) 150)
        (= (calorias arroz) 300)
        (= (calorias pasta) 350)
        (= (calorias gazpacho) 180)
        (= (calorias tortilla) 250)
        (= (calorias crepes) 300)
        (= (calorias crema) 220)
        (= (calorias macarrones) 320)
        (= (calorias hummus) 210)
        (= (calorias cus_cus) 300)
        (= (calorias brocoli) 180)

        ;; Calorías de segundos
        (= (calorias pescado) 700)
        (= (calorias carne) 800)
        (= (calorias pollo) 1200)
        (= (calorias ternera) 750)
        (= (calorias cerdo) 1050)
        (= (calorias salmon) 1250)
        (= (calorias merluza) 1000)
        (= (calorias atun) 1020)
        (= (calorias tofu) 900)
        (= (calorias hamburguesa) 1100)
        (= (calorias huevo_frito) 980)
        (= (calorias gambas) 950)
        (= (calorias cordero) 1150)

        ;; Inicializar total-calorias de cada día a 0
        (= (total-calorias lunes) 0)
        (= (total-calorias martes) 0)
        (= (total-calorias miercoles) 0)
        (= (total-calorias jueves) 0)
        (= (total-calorias viernes) 0)

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