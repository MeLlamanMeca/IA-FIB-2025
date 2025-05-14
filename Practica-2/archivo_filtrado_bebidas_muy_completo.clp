;;; ---------------------------------------------------------
;;; hola.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology onto1.owl
;;; :Date 12/05/2025 18:19:44

(defclass Bebida
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot alcoholica
        (type SYMBOL)
        (create-accessor read-write))
    (slot dificultad_preparacion
        (type SYMBOL)
        (create-accessor read-write))
    (slot festividad
        (type SYMBOL)
        (create-accessor read-write))
    (slot nombre
        (type STRING)
        (create-accessor read-write))
    (slot origen
        (type SYMBOL)
        (create-accessor read-write))
    (slot precio
        (type FLOAT)
        (create-accessor read-write))
    (multislot propiedades_dieteticas
        (type SYMBOL)
        (create-accessor read-write))
    (multislot temporadas
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Cerveza
    (is-a Bebida)
    (role concrete)
    (pattern-match reactive)
)

(defclass Coctel
    (is-a Bebida)
    (role concrete)
    (pattern-match reactive)
)

(defclass Refresco
    (is-a Bebida)
    (role concrete)
    (pattern-match reactive)
)

(defclass Vino
    (is-a Bebida)
    (role concrete)
    (pattern-match reactive)
)

(defclass Vino_blanco
    (is-a Vino)
    (role concrete)
    (pattern-match reactive)
)

(defclass Vino_tinto
    (is-a Vino)
    (role concrete)
    (pattern-match reactive)
)

(defclass Zumo
    (is-a Bebida)
    (role concrete)
    (pattern-match reactive)
)

(defclass Agua
    (is-a Bebida)
    (role concrete)
    (pattern-match reactive)
)

(defclass Ingrediente
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot origen_ingrediente
        (type SYMBOL)
        (create-accessor read-write))
    (multislot propiedades_ingrediente
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Menu
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot postre
        (type INSTANCE)
        (create-accessor read-write))
    (slot primer_plato
        (type INSTANCE)
        (create-accessor read-write))
    (slot primera_bebida
        (type INSTANCE)
        (create-accessor read-write))
    (slot segunda_bebida
        (type INSTANCE)
        (create-accessor read-write))
    (slot segundo_plato
        (type INSTANCE)
        (create-accessor read-write))
    (slot precio
        (type FLOAT)
        (create-accessor read-write))
)

(defclass Plato
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot compatibleCon
        (type INSTANCE)
        (create-accessor read-write))
    (multislot contiene
        (type INSTANCE)
        (create-accessor read-write))
    (slot dificultad_preparacion
        (type SYMBOL)
        (create-accessor read-write))
    (multislot festividad
        (type SYMBOL)
        (create-accessor read-write))
    (multislot metodo_preparacion
        (type SYMBOL)
        (create-accessor read-write))
    (slot nombre
        (type STRING)
        (create-accessor read-write))
    (slot origen
        (type STRING)
        (create-accessor read-write))
    (slot precio
        (type FLOAT)
        (create-accessor read-write))
    (slot presentacion
        (type SYMBOL)
        (create-accessor read-write))
    (multislot propiedades_dieteticas
        (type SYMBOL)
        (create-accessor read-write))
    (multislot sabor
        (type SYMBOL)
        (create-accessor read-write))
    (slot temperatura
        (type SYMBOL)
        (create-accessor read-write))
    (multislot temporadas
        (type SYMBOL)
        (create-accessor read-write))
    (multislot textura
        (type SYMBOL)
        (create-accessor read-write))
    (multislot tipo_plato
        (type SYMBOL)
        (create-accessor read-write))
)

(definstances instances
    (b3 of Cerveza
        (nombre "cerveza lager")
        (alcoholica true)
        (origen alemania)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio nut-free sin-lactosa vegano vegetariano)
        (precio 3.00)
    )

    (b4 of Refresco
        (nombre "cocacola")
        (alcoholica false)
        (origen eeuu)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas halal kosher nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 2.00)
    )

    (b5 of Agua
        (nombre "agua")
        (alcoholica false)
        (origen españa)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio diabetico dieta-saludable halal kosher nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 1.50)
    )
)





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
    (slot OrigenComida
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
    (printout t "----BIENVENIDO AL SISTEMA DE REMENDACIONES ----" crlf)
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

(defrule PREGUNTAS::askWhen
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?when (ask-question "En que temporada se celebrará el evento?  (verano/otoño/invierno/primavera) " verano otoño invierno primavera))
    (send ?x put-Temporada ?when)
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

(defrule PREGUNTAS::askRestrictions
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?restr (ask-question "Quieres aplicar algun tipo de restricción dietetica, alergica o religiosa?  (si/no) " si no))
    (if (eq ?restr si) then
        (bind ?diab (ask-question "Quieres un menú para diabeticos?  (si/no) " si no))
        (if (eq ?diab si) then (slot-insert$ ?x restrictions 1 diabetico))
        (bind ?salud (ask-question "Quieres un menú saludable?  (si/no) " si no))
        (if (eq ?salud si) then (slot-insert$ ?x restrictions 1 saludable))
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
        (bind ?restr2 (ask-question "Quieres algún tipo de condición especial en la comida?  (blanda/liquida/no) " blanda liquida no))
        (if (eq ?restr2 blanda) then (slot-insert$ ?x restrictions 1 blanda))
        (if (eq ?restr2 liquida) then (slot-insert$ ?x restrictions 1 liquida))
    ) 
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

(deftemplate bebida_filtrada
    (slot nombre)
    (slot origen)
    (slot precio)
    (slot alcoholica)
    (slot dificultad)
    (slot festividad)
    (multislot propiedades)
    (multislot temporadas)
)
(deffunction filtrarBebida (?bebida)
   (assert (bebida_filtrada 
      (nombre (send ?bebida get-nombre))
      (origen (send ?bebida get-origen))
      (precio (send ?bebida get-precio))
      (alcoholica (send ?bebida get-alcoholica))
      (dificultad (send ?bebida get-dificultad_preparacion))
      (festividad (send ?bebida get-festividad))
      (propiedades (send ?bebida get-propiedades_dieteticas))
      (temporadas (send ?bebida get-temporadas))))
)

(deffunction bebidaCumpleCondiciones (?b ?x ?tipo)
 (return 
    (and
        (or(eq (send ?x get-DrinkType) ?tipo)(eq (send ?x get-DrinkType) NULL)) ;;; TIPO DE BEBIDA
        (or(eq (send ?x get-Alcohol) (send ?b get-alcoholica))(eq (send ?x get-Alcohol) NULL)) ;;; ALCOHOL
        (member$ (send ?x get-Temporada) (send ?b get-temporadas)) ;;;TEMPORADA
        (subsetp (send ?x get-restrictions) (send ?b get-propiedades_dieteticas)) ;;; RESTRICCIONES DIETETICAS
        (or (eq (send ?x get-OrigenBebida) (send ?b get-origen)) (eq (send ?x get-OrigenBebida) NULL)) ;;; ORIGEN
    )
 )
)

(defrule FILTRADO::FiltrarCerveza
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Cerveza))
   =>
   (if (bebidaCumpleCondiciones ?b ?x cerveza) then (filtrarBebida ?b))
)

(defrule FILTRADO::FiltrarCoctel
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Coctel))
   =>
   (if (bebidaCumpleCondiciones ?b ?x coctel) then (filtrarBebida ?b))
)

(defrule FILTRADO::FiltrarRefresco
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Refresco))
   =>
   (if (bebidaCumpleCondiciones ?b ?x refresco) then (filtrarBebida ?b))
)

(defrule FILTRADO::FiltrarVino
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Vino))
   =>
   (if (bebidaCumpleCondiciones ?b ?x vino) then (filtrarBebida ?b))
)

(defrule FILTRADO::FiltrarZumo
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Zumo))
   =>
   (if (bebidaCumpleCondiciones ?b ?x zumo) then (filtrarBebida ?b))
)

(defrule FILTRADO::FiltrarAgua
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (object (is-a Agua))
   =>
    (if (bebidaCumpleCondiciones ?b ?x agua) then (filtrarBebida ?b))
)

(defrule FILTRADO::FiltroDebuggFunction
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (bebida_filtrada (nombre ?name))
   =>
    (printout t "Bebida aceptada: " ?name crlf)
)