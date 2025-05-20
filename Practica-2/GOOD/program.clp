;;; ---------------------------------------------------------
;;; hola.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology onto1.owl
;;; :Date 12/05/2025 18:19:44


;;; ---------------------------------------------------------
;;; INTERACCIONES
;;; ---------------------------------------------------------

(deffacts inicio
	(initial-fact)
)

(deffunction ask-int (?question)
	(printout t ?question)
	(bind ?answer (read))
	(while (lexemep ?answer) do
		(printout t ?question)
		(bind ?answer (read))
		)
	(integer ?answer))

(deffunction ask-question (?question $?allowed-values)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer)
       then (bind ?answer (lowcase ?answer)))
   (while (not (member$ ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer)
          then (bind ?answer (lowcase ?answer))))
   ?answer
)

(deffunction stringg-question (?question)
	(format t "%s" ?question)
	(bind ?answer (read))
	?answer
)

(deffunction empty-intersection (?list1 ?list2)
  (foreach ?item ?list1
    (if (neq (member$ ?item ?list2) FALSE) then
       (return FALSE)
    )
  )
  (return TRUE)
)

(deffunction check-badcomp (?e1 ?e2 ?lpp1 ?lpp2)
  (loop-for-count (?i 0 (length$ ?e1)) do
    (bind ?item1 (nth$ ?i ?e1))
    (bind ?item2 (nth$ ?i ?e2))
    (if 
        (or
        (and (member$ ?item1 ?lpp1) (member$ ?item2 ?lpp2))
        (and (member$ ?item2 ?lpp1) (member$ ?item1 ?lpp2))
        ) then (return FALSE)
    )
  )
  (return TRUE)
)


(defmodule MAIN (export ?ALL))

(defclass MAIN::Prefs
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot Nombre
        (type STRING)
        (create-accessor read-write))
    (slot OrigenBebida
        (type SYMBOL)
        (create-accessor read-write))
    (slot OrigenPlato
        (type SYMBOL)
        (create-accessor read-write))
    (slot Evento
        (type SYMBOL)
        (create-accessor read-write))
    (slot Temporada
        (type SYMBOL)
        (create-accessor read-write))
    (slot Asistentes
        (type INTEGER)
        (create-accessor read-write))
    (slot Tipo
        (type SYMBOL)
        (create-accessor read-write))
    (slot Hora
        (type SYMBOL)
        (create-accessor read-write))
    (slot Formalidad
        (type SYMBOL)
        (create-accessor read-write))
    (slot Alcohol
        (type SYMBOL)
        (create-accessor read-write))
    (slot MinMoney
        (type FLOAT)
        (create-accessor read-write))
    (slot MaxMoney
        (type FLOAT)
        (create-accessor read-write))
    (slot DrinkType
        (type SYMBOL)
        (create-accessor read-write))
    (slot BebidaUnica
        (type SYMBOL)
        (create-accessor read-write))
    (slot PresentacionImportante
        (type SYMBOL)
        (create-accessor read-write))
    (multislot restrictions
        (type INSTANCE)
        (create-accessor read-write))
    (multislot ingredientes_necesarios
        (type INSTANCE)
        (create-accessor read-write))
    (multislot ingredientes_prohibidos
        (type INSTANCE)
        (create-accessor read-write))
)



(defrule initial
    (initial-fact)
    =>
    (printout t "----BIENVENIDO AL SISTEMA DE RECOMENDACIONES ----" crlf)
    (printout t crlf)
    (assert(newPrefs))
    (focus PREGUNTAS)
)

;;; --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;; PREGUNTAS
;;; --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(defmodule PREGUNTAS (export ?ALL) (import MAIN ?ALL))

(defrule PREGUNTAS::askName
   (newPrefs)
   =>
   ;; Preguntar por el nombre
   (bind ?name (stringg-question "¿Cómo te llamas? "))

   ;; Crear la instancia de Prefs
   (bind ?x (make-instance ?name of Prefs))

   ;; Asignar valores a los slots de Prefs
   (send ?x put-Nombre ?name)
)

(defrule PREGUNTAS::askHowMany
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?pers (ask-int "Cuantas personas asistirán? " ))
    (send ?x put-Asistentes ?pers)
)

(defrule PREGUNTAS::askWhen
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?when (ask-question "En que temporada se celebrará el evento?  (verano/otoño/invierno/primavera) " verano otoño invierno primavera))
    (send ?x put-Temporada ?when)
)

(defrule PREGUNTAS::askMoney
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?min (ask-int "¿Cuanto estas dispuesto a gastar como mínimo? "))
    (send ?x put-MinMoney ?min)
    (bind ?max (ask-int "¿Cuanto estas dispuesto a gastar como máximo? "))
    (send ?x put-MaxMoney ?max)
)

(defrule PREGUNTAS::askMenuInfo
	(newPrefs)                                                                                                  
    ?x <- (object(is-a Prefs))
	=>
    (bind ?type1 (ask-question "Que tipo de evento es?  (boda/comunion/bautizo/evento/otro) " boda comunion bautizo evento otro))
    (if (eq ?type1 boda)
        then (send ?x put-Formalidad formal)
    )
    (if (eq ?type1 comunion)
        then (send ?x put-Formalidad informal)
    )
    (if (eq ?type1 bautizo)
        then (send ?x put-Formalidad informal)
    )
    (if (eq ?type1 evento)
        then (send ?x put-Formalidad formal)
    )
    (if (eq ?type1 otro)
        then (bind ?type (ask-question "Como te gustaria que fuese el menu?  (clasico/moderno/sibarita) " clasico moderno sibarita))
        (if (eq ?type clasico)
            then (send ?x put-Formalidad informal)
            else (send ?x put-Formalidad formal)
        )
    )
	
)

(defrule PREGUNTAS::askRestrictions
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?restr (ask-question "Quieres aplicar algun tipo de restricción dietetica, alergica o religiosa?  (si/no) " si no))
    (if (eq ?restr si) then
        (bind ?carn (ask-question "Puedes comer carne?  (si/no) " si no))
        (if (eq ?carn no) then (slot-insert$ ?x restrictions 1 carne-free))
        (bind ?pescado (ask-question "Puedes comer pescado?  (si/no) " si no))
        (if (eq ?pescado no) then (slot-insert$ ?x restrictions 1 pescado-free))
        (bind ?marisco (ask-question "Puedes comer marisco?  (si/no) " si no))
        (if (eq ?marisco no) then (slot-insert$ ?x restrictions 1 marisco-free))
        (bind ?diab (ask-question "Quieres un menú para diabeticos?  (si/no) " si no))
        (if (eq ?diab si) then (slot-insert$ ?x restrictions 1 diabetico))
        (bind ?salud (ask-question "Quieres un menú saludable?  (si/no) " si no))
        (if (eq ?salud si) then (slot-insert$ ?x restrictions 1 dieta-saludable))
        (bind ?vegetarian (ask-question "Quieres un menú vegetariano?  (si/no) " si no))
        (if (eq ?vegetarian si) then (slot-insert$ ?x restrictions 1 vegetariano))
        (bind ?vegan (ask-question "Quieres un menú vegano?  (si/no) " si no))
        (if (eq ?vegan si) then (slot-insert$ ?x restrictions 1 vegano))
        (bind ?gluten (ask-question "Quieres un menú sin gluten?  (si/no) " si no))
        (if (eq ?gluten si) then (slot-insert$ ?x restrictions 1 sin-gluten))
        (bind ?lactosa (ask-question "Quieres un menú sin lactosa?  (si/no) " si no))
        (if (eq ?lactosa si) then (slot-insert$ ?x restrictions 1 sin-lactosa))
        (bind ?nuts (ask-question "Quieres un menú sin frutos secos?  (si/no) " si no))
        (if (eq ?nuts si) then (slot-insert$ ?x restrictions 1 nut-free))
        (bind ?sodium (ask-question "Quieres un menú bajo en sodio?  (si/no) " si no))
        (if (eq ?sodium si) then (slot-insert$ ?x restrictions 1 bajo-en-sodio))
        (bind ?religiosa (ask-question "Quieres un menú con restricciones religiosas?  (si/no) " si no))
        (if (eq ?religiosa si) then
            (bind ?religion (ask-question "Que religión?  (musulmana/judía/otra) " musulmana judía otra))
            (if (eq ?religion musulmana) then (slot-insert$ ?x restrictions 1 halal))
            (if (eq ?religion judía) then (slot-insert$ ?x restrictions 1 kosher))
        )
        (bind ?restr2 (ask-question "Quieres una dieta blanda?  (si/no) " si no))
        (if (eq ?restr2 blanda) then (slot-insert$ ?x restrictions 1 blanda))
    ) 
)

(defrule PREGUNTAS::askRegionPlato
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?restr (ask-question "Te gustaria que el plato fuera de alguna región en especifico?  (si/no) " si no))
    (if (eq ?restr si) then
    
        (bind ?region (ask-question "Que región?  (española/italiana/mexicana/asiatica/americana/alemana) " española italiana mexicana asiatica americana alemana))
        (if (eq ?region española) then (send ?x put-OrigenPlato españa))
        (if (eq ?region italiana) then (send ?x put-OrigenPlato italia))
        (if (eq ?region mexicana) then (send ?x put-OrigenPlato mexico))
        (if (eq ?region asiatica) then (send ?x put-OrigenPlato asia))
        (if (eq ?region americana) then (send ?x put-OrigenPlato eeuu))
        (if (eq ?region alemana) then (send ?x put-OrigenPlato alemania))
    else (send ?x put-OrigenPlato NULL)

    )
)

(defrule PREGUNTAS::askIngredients
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?ingred (ask-question "Te gustaria que el menú tuviera algún ingrediente concreto?  (si/no) " si no))
    (if (eq ?ingred si) then
        (bind ?q (ask-int "Cuantos? "))
        (bind ?i 0)
        (while (< ?i ?q) do
            (bind ?ing (stringg-question "Que ingrediente? "))
            (slot-insert$ ?x ingredientes_necesarios 1 ?ing)
            (bind ?i (+ ?i 1))
        )
    )

    (bind ?ingred (ask-question "Te gustaria que el menú no tuviera algún ingrediente concreto?  (si/no) " si no))
    (if (eq ?ingred si) then
        (bind ?q (ask-int "Cuantos? "))
        (bind ?i 0)
        (while (< ?i ?q) do
            (bind ?ing (stringg-question "Que ingrediente? "))
            (slot-insert$ ?x ingredientes_prohibidos 1 ?ing)
            (bind ?i (+ ?i 1))
        )
    )
)



(defrule PREGUNTAS::askDrink
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?beb (ask-question "¿Quieres algun tipo de bebida en especifico? (agua/cerveza/coctel/refresco/vino/zumo/no) " agua cerveza coctel refresco vino zumo no ))
    (if (eq ?beb no)
        then (send ?x put-DrinkType NULL)
    else (send ?x put-DrinkType ?beb)
    )
    
)

(defrule PREGUNTAS::askUniqueDrink
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?bebun (ask-question "¿Quieres tener una bebida distinta por plato? (si/no/indiferente) " si no indiferente ))
    (if (eq ?bebun si)
        then (send ?x put-BebidaUnica no)
        else (send ?x put-BebidaUnica si)
    )
)

(defrule PREGUNTAS::askAlcohol
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?alcohol (ask-question "Te gustaria que el menú tuviera alcohol?  (si/no/indiferente) " si no indiferente))
    (if (eq ?alcohol si) then
        (send ?x put-Alcohol true))
    (if (eq ?alcohol no) then
        (send ?x put-Alcohol false))
    (if (eq ?alcohol indiferente) then
        (send ?x put-Alcohol NULL)) 
)

(defrule PREGUNTAS::askRegionBebida
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?restr (ask-question "Te gustaria que la bebida fuera de alguna región en especifico?  (si/no) " si no))
    (if (eq ?restr si) then
    
        (bind ?region (ask-question "Que región?  (española/italiana/mexicana/asiatica/americana/alemana) " española italiana mexicana asiatica americana alemana))
        (if (eq ?region española) then (send ?x put-OrigenBebida españa))
        (if (eq ?region italiana) then (send ?x put-OrigenBebida italia))
        (if (eq ?region mexicana) then (send ?x put-OrigenBebida mexico))
        (if (eq ?region asiatica) then (send ?x put-OrigenBebida asia))
        (if (eq ?region americana) then (send ?x put-OrigenBebida eeuu))
        (if (eq ?region alemana) then (send ?x put-OrigenBebida alemania))
    else (send ?x put-OrigenBebida NULL)

    )
)

(defrule PREGUNTAS::endAskingRule
	(declare (salience -10))
	(newPrefs)
	?p <- (object(is-a Prefs))
	=>
	(printout t "Por favor, permítenos un momento para calcular tu menú personalizado. " crlf)
	(assert (endAsking))
    (focus FILTRADO)
)


;;; --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;; FILTRADO
;;; --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(defmodule FILTRADO (export ?ALL) (import MAIN ?ALL) (import PREGUNTAS ?ALL))


(deftemplate plato_filtrado
   (slot nombre                   (type STRING))
   (slot precio                    (type FLOAT))
   (multislot propiedades_generales         (type SYMBOL))
   (multislot tipo_plato          (type SYMBOL))
   (multislot bebidas_recomendadas (type SYMBOL))
)
(deffunction filtrarPlato (?plato)
   (assert (plato_filtrado 
      (nombre                   (send ?plato get-nombre))
      (precio                   (send ?plato get-precio))
      (propiedades_generales   (send ?plato get-propiedades_generales))
      (tipo_plato               (send ?plato get-tipo_plato))
      (bebidas_recomendadas               (send ?plato get-bebidas_recomendadas))
   ))
)

(deftemplate bebida_filtrada
    (slot nombre)
    (slot precio)
    (slot tipo)
)
(deffunction filtrarBebida (?bebida ?tipo)
   (assert (bebida_filtrada 
      (nombre (send ?bebida get-nombre))
      (precio (send ?bebida get-precio))
      (tipo ?tipo)
      ))
)



(deffunction PlatoCumpleCondiciones (?p ?x)
 (return 
    (and
        (eq (send ?x get-Formalidad) (send ?p get-presentacion)) ;;; FORMALIDAD
        (member$ (send ?x get-Temporada) (send ?p get-temporadas)) ;;;TEMPORADA
        (subsetp (send ?x get-restrictions) (send ?p get-propiedades_dieteticas)) ;;; RESTRICCIONES DIETETICAS
        (subsetp (send ?x get-ingredientes_necesarios) (send ?p get-contiene)) ;;; INGREDIENTES NECESARIOS
        (empty-intersection (send ?x get-ingredientes_prohibidos) (send ?p get-contiene)) ;;; INGREDIENTES PROHIBIDOS
        (or (eq (send ?x get-OrigenPlato) (send ?p get-origen)) (eq (send ?x get-OrigenPlato) NULL) (eq (send ?p get-origen) internacional)) ;;; ORIGEN
        (or ;;; NUMERO DE PERSONAS
            (<= (send ?x get-Asistentes) 30)
            (and 
                (<= (send ?x get-Asistentes) 50)
                (or 
                    (eq (send ?p get-dificultad_preparacion) media)
                    (eq (send ?p get-dificultad_preparacion) facil)))
            (and 
                (> (send ?x get-Asistentes) 50)
                (eq (send ?p get-dificultad_preparacion) facil)))
    )
 )
)

(deffunction bebidaCumpleCondiciones (?b ?x ?tipo)
 (return 
    (and
        (or(eq (send ?x get-DrinkType) ?tipo)(eq (send ?x get-DrinkType) NULL)) ;;; TIPO DE BEBIDA
        (or(eq (send ?x get-Alcohol) (send ?b get-alcoholica))(eq (send ?x get-Alcohol) NULL)) ;;; ALCOHOL
        (member$ (send ?x get-Temporada) (send ?b get-temporadas)) ;;;TEMPORADA
        (subsetp (send ?x get-restrictions) (send ?b get-propiedades_dieteticas)) ;;; RESTRICCIONES DIETETICAS
        (or (eq (send ?x get-OrigenBebida) (send ?b get-origen)) (eq (send ?x get-OrigenBebida) NULL) (eq ?tipo agua)) ;;; ORIGEN
        (or ;;; NUMERO DE PERSONAS
            (<= (send ?x get-Asistentes) 30)
            (and 
                (<= (send ?x get-Asistentes) 50)
                (or 
                    (eq (send ?b get-dificultad_preparacion) media)
                    (eq (send ?b get-dificultad_preparacion) facil)))
            (and 
                (> (send ?x get-Asistentes) 50)
                (eq (send ?b get-dificultad_preparacion) facil)))
    )
 )
)

(defrule FILTRADO::FiltrarPlato
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Plato))
   =>
   (if (PlatoCumpleCondiciones ?b ?x) then (filtrarPlato ?b))
)

(defrule FILTRADO::FiltrarAgua
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Agua))
   =>
    (if (bebidaCumpleCondiciones ?b ?x agua) then (filtrarBebida ?b agua))
)

(defrule FILTRADO::FiltrarCerveza
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Cerveza))
   =>
   (if (bebidaCumpleCondiciones ?b ?x cerveza) then (filtrarBebida ?b cerveza))
)

(defrule FILTRADO::FiltrarCoctel
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Coctel))
   =>
   (if (bebidaCumpleCondiciones ?b ?x coctel) then (filtrarBebida ?b coctel))
)

(defrule FILTRADO::FiltrarRefresco
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Refresco))
   =>
   (if (bebidaCumpleCondiciones ?b ?x refresco) then (filtrarBebida ?b refresco))
)

(defrule FILTRADO::FiltrarVinoblanco
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Vino))
   =>
   (if (bebidaCumpleCondiciones ?b ?x vino) then (filtrarBebida ?b vino_blanco))
)

(defrule FILTRADO::FiltrarVinotinto
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Vino))
   =>
   (if (bebidaCumpleCondiciones ?b ?x vino) then (filtrarBebida ?b vino_tinto))
)

(defrule FILTRADO::FiltrarZumo
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Zumo))
   =>
   (if (bebidaCumpleCondiciones ?b ?x zumo) then (filtrarBebida ?b zumo))
)

(defrule FILTRADO::endFiltradoRule
	(declare (salience -10))
	(endAsking)
	=>
	(assert (endFiltrado))
    (focus GENERATION)
)

(defrule FILTRADO::FiltroBebidaDebuggFunction
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (bebida_filtrada (nombre ?name))
   ?b1 <- (object (is-a Bebida) (nombre ?name) (origen ?origen) (alcoholica ?alcoholica) (dificultad_preparacion ?dificultad_preparacion) (precio ?precio) (propiedades_dieteticas $?propiedades_dieteticas) (temporadas $?temporadas))
   =>
    (printout t "Bebida aceptada: " ?name ", " ?origen ", " ?alcoholica ", " ?dificultad_preparacion ", " ?precio ", " ?propiedades_dieteticas ", " ?temporadas crlf)
)

(defrule FILTRADO::FiltroPlatoDebuggFunction
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (plato_filtrado (nombre ?name))
   ?b1 <- (object (is-a Plato) (nombre ?name) (origen ?origen) (precio ?precio) (presentacion ?presentacion) (dificultad_preparacion ?dificultad_preparacion) (propiedades_dieteticas $?propiedades_dieteticas) (temporadas $?temporadas) (propiedades_generales $?propiedades_generales) (tipo_plato $?tipo_plato) (bebidas_recomendadas $?bebidas_recomendadas) (contiene $?contiene))
   =>
    (printout t "Plato aceptado: " ?name ", " ?origen ", " ?dificultad_preparacion ", " ?precio ", " ?propiedades_dieteticas ", " ?temporadas ", " ?presentacion ", " ?propiedades_generales ", " ?tipo_plato ", " ?bebidas_recomendadas ", " ?contiene crlf)
)

;;; --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;; GENERATION
;;; --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(defmodule GENERATION (export ?ALL) (import MAIN ?ALL) (import PREGUNTAS ?ALL) (import FILTRADO ?ALL))

(deftemplate combinaciones_malas
    (slot propiedad (type SYMBOL))
    (multislot malas_sinergias (type SYMBOL))
)

(deffacts combinaciones 
    (combinaciones_malas (propiedad cremoso) (malas_sinergias crujiente))
    (combinaciones_malas (propiedad crujiente) (malas_sinergias vapor estofado))
    (combinaciones_malas (propiedad firme) (malas_sinergias estofado))
    (combinaciones_malas (propiedad jugoso) (malas_sinergias crujiente))
    (combinaciones_malas (propiedad caliente) (malas_sinergias frio))
    (combinaciones_malas (propiedad frio) (malas_sinergias estofado frito horno))
    (combinaciones_malas (propiedad templado) (malas_sinergias ninguno))
    (combinaciones_malas (propiedad dulce) (malas_sinergias picante fuerte salado))
    (combinaciones_malas (propiedad fuerte) (malas_sinergias dulce suave))
    (combinaciones_malas (propiedad picante) (malas_sinergias dulce))
    (combinaciones_malas (propiedad salado) (malas_sinergias dulce))
    (combinaciones_malas (propiedad suave) (malas_sinergias fuerte))
    (combinaciones_malas (propiedad barbacoa) (malas_sinergias crudo vapor))
    (combinaciones_malas (propiedad crudo) (malas_sinergias barbacoa estofado frito horno))
    (combinaciones_malas (propiedad frito) (malas_sinergias vapor))
    (combinaciones_malas (propiedad hervido) (malas_sinergias frito))
    (combinaciones_malas (propiedad horno) (malas_sinergias crudo))
    (combinaciones_malas (propiedad marinado) (malas_sinergias estofado))
    (combinaciones_malas (propiedad plancha) (malas_sinergias estofado))
    (combinaciones_malas (propiedad vapor) (malas_sinergias frito barbacoa))
    (combinaciones_malas (propiedad estofado) (malas_sinergias crudo plancha marinado))
)

(deffunction append (?l1$ ?l2$)
   (bind ?result$ (create$))
   (loop-for-count (?i 1 (length$ ?l1$))
     do (bind ?result$
               (create$
                  ?result$
                  (nth$ ?i ?l1$))))
   (loop-for-count (?j 1 (length$ ?l2$))
     do (bind ?result$
               (create$
                  ?result$
                  (nth$ ?j ?l2$))))
   (return ?result$))


(deffunction GENERATION::bad_propiedades (?cualidades)
    (bind ?result (create$))
    (foreach ?item ?cualidades
        (do-for-fact ((?comb combinaciones_malas)) (eq ?comb:propiedad ?item)
            (bind ?result (append ?result ?comb:malas_sinergias))
        )
    )
    ?result
)

(deftemplate menu
(slot p1 (type SYMBOL))
(slot p2 (type SYMBOL))
(slot p3 (type SYMBOL))
(slot b1 (type SYMBOL))
(slot b2 (type SYMBOL))
(slot precio (type FLOAT))
)

(defglobal
  ?*menu-barato* = NULL
  ?*precio-barato* = 1000000

  ?*menu-caro* = NULL
  ?*precio-caro* = -1

  ?*menu-promedio* = NULL
  ?*precio-promedio* = 0

  ?*precio-total* = 0
  ?*num-menus* = 0
)

(deffunction registrar-menu
  (?p1nombre ?p2nombre ?nombrepostre ?nombrebebida1 ?nombrebebida2 ?total)

  (bind ?*precio-total* (+ ?*precio-total* ?total))
  (bind ?*num-menus* (+ ?*num-menus* 1))

  (bind ?menu-string (str-cat "P1: " ?p1nombre ", P2: " ?p2nombre ", P3: " ?nombrepostre ", B1: " ?nombrebebida1 ", B2: " ?nombrebebida2 ", precio: " ?total "$"))

  ;; actualizar menú más barato
  (if (< ?total ?*precio-barato*) then
    (bind ?*precio-barato* ?total)
    (bind ?*menu-barato* ?menu-string)
  )

  ;; actualizar menú más caro
  (if (> ?total ?*precio-caro*) then
    (bind ?*precio-caro* ?total)
    (bind ?*menu-caro* ?menu-string)
  )

  ;; actualizar menú promedio
  (bind ?promedio (/ ?*precio-total* ?*num-menus*))
  (bind ?diferencia-promedio (abs (- ?total ?promedio)))
  (bind ?diferencia-anterior (abs (- ?*precio-promedio* ?promedio)))

  (if (or (eq ?*menu-promedio* NULL) (< ?diferencia-promedio ?diferencia-anterior)) then
    (bind ?*precio-promedio* ?total)
    (bind ?*menu-promedio* ?menu-string)
  )
)

(defrule GENERATION::getCompatibleMenus
    (endFiltrado)
    ?x <- (object (is-a Prefs))
    ?p2 <- (plato_filtrado (nombre ?p2nombre) (precio ?p2precio) (tipo_plato $?p2tipo_plato) (propiedades_generales $?p2cualidades) (bebidas_recomendadas $?p2bebidas))
    (test(member$ segundo ?p2tipo_plato))
    ?p1 <- (plato_filtrado (nombre ?p1nombre) (precio ?p1precio) (tipo_plato $?p1tipo_plato) (propiedades_generales $?p1cualidades) (bebidas_recomendadas $?p1bebidas))
    (test(member$ primero ?p1tipo_plato))
    (test (empty-intersection (bad_propiedades ?p2cualidades) ?p1cualidades))
    
    ?postre <- (plato_filtrado (nombre ?nombrepostre) (precio ?preciopostre) (tipo_plato $?tipopostre))
    (test(member$ postre ?tipopostre))

    ?b1 <- (bebida_filtrada (nombre ?nombrebebida1 )(precio ?pb1) (tipo ?tipo1))
    ?b2 <- (bebida_filtrada (nombre ?nombrebebida2 )(precio ?pb2) (tipo ?tipo2))
    (test (member$ ?tipo2 ?p2bebidas))
    (test (or
           (and (eq  (send ?x get-BebidaUnica) no) (not(eq ?nombrebebida1 ?nombrebebida2)) (member$ ?tipo1 ?p1bebidas))
           (and (eq  (send ?x get-BebidaUnica) si) (eq ?nombrebebida1 ?nombrebebida2))
        )
    )
    =>
    (bind ?total (+ ?p1precio ?p2precio ?preciopostre ?pb1 ?pb2))
    (if (and (<= (send ?x get-MinMoney) ?total) (>= (send ?x get-MaxMoney) ?total)) then
        (registrar-menu ?p1nombre ?p2nombre ?nombrepostre ?nombrebebida1 ?nombrebebida2 ?total)
    )
)

(defrule mostrar-mejores-menus 
    (endFiltrado)
    =>
  (printout t crlf)
  (printout t "🥇 Menú más barato: " ?*menu-barato* crlf)
  (printout t "🥈 Menú promedio: " ?*menu-promedio* crlf)
  (printout t "🥉 Menú más caro: " ?*menu-caro* crlf)
)

