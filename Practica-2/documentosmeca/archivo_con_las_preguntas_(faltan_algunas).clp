;;; ---------------------------------------------------------
;;; hola.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology onto1.owl
;;; :Date 12/05/2025 18:19:44

(defclass Bebida
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot alcoholica
        (type SYMBOL)
        (create-accessor read-write))
    (slot dificultad_preparacion
        (type SYMBOL)
        (create-accessor read-write))
    (multislot festividad
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
)

(defclass Prefs
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot Nombre
        (type STRING)
        (create-accessor read-write))
    (slot Evento
        (type STRING)
        (create-accessor read-write))
    (slot Temporada
        (type STRING)
        (create-accessor read-write))
    (slot Asistentes
        (type SYMBOL)
        (create-accessor read-write))
    (slot Tipo
        (type STRING)
        (create-accessor read-write))
    (slot Hora
        (type STRING)
        (create-accessor read-write))
    (slot Alcohol
        (type STRING)
        (create-accessor read-write))
    (slot MinMoney
        (type STRING)
        (create-accessor read-write))
    (slot MaxMoney
        (type STRING)
        (create-accessor read-write))
    (slot DrinkType
        (type STRING)
        (create-accessor read-write))
    (slot PresentacionImportante
        (type STRING)
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

(defrule initial
    (initial-fact)
    =>
    (printout t "----inicio ----" crlf)
    (printout t crlf)
    (assert(newPrefs))
    (focus PREGUNTAS)
)


(defmodule PREGUNTAS (export ?ALL) (import MAIN ?ALL))


(defrule PREGUNTAS::askName
	(newPrefs)
	=>
	(bind ?name (stringg-question "Como te llamas? "))
	(bind ?x (make-instance ?name of Prefs))
	(send ?x put-Nombre ?name)
)

(defrule PREGUNTAS::askEventType
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?event (ask-question "Que tipo de evento es?  (boda/comunion/bautizo/corporativo/otro) " boda comunion bautizo corporativo otro))
    (send ?x put-Evento ?event)
)

(defrule PREGUNTAS::askWhen
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?when (ask-question "En que temporada se celebrará el evento?  (verano/otoño/invierno/primavera) " verano otoño invierno primavera))
    (send ?x put-Temporada ?when)
)

(defrule PREGUNTAS::askHowMany
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?pers (ask-int "Cuantas personas asistirán? " ))
    (send ?x put-Asistentes ?pers)
)

(defrule PREGUNTAS::askFormality
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?type (ask-question "Que tipo de evento es?  (formal/informal/casual) " formal informal casual))
    (send ?x put-Tipo ?type)
)

(defrule PREGUNTAS::askTime
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?time (ask-question "Cuando será?  (comida/cena) " comida cena))
    (send ?x put-Hora ?time)
)

(defrule PREGUNTAS::askAlcohol
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?alcohol (ask-question "Te gustaria que el menú tuviera alcohol?  (si/no/indiferente) " si no indiferente))
    (if (eq ?alcohol si) then
        (send (send ?x put-Alcohol true))
    (if (eq ?alcohol no) then
        (send (send ?x put-Alcohol false))
    )
    (if (eq ?alcohol indiferente) then
        (send (send ?x put-Alcohol NULL))
    ) 
)

(defrule PREGUNTAS::askRestrictions
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?restr (ask-question "Quieres aplicar algun tipo de restricción dietetica, alergica o religiosa?  (si/no) " si no))
    (if (eq ?restr si) then
        (bind ?vegetarian (ask-question "Quieres un menú vegetariano?  (si/no) " si no))
        (if (eq ?vegetarian si) then (slot-insert$ ?x restrictions 1 [vegetariano]))
        (bind ?vegan (ask-question "Quieres un menú vegano?  (si/no) " si no))
        (if (eq ?vegan si) then (slot-insert$ ?x restrictions 1 [vegano]))
        (bind ?gluten (ask-question "Quieres un menú sin gluten?  (si/no) " si no))
        (if (eq ?gluten si) then (slot-insert$ ?x restrictions 1 [sin-gluten]))
        (bind ?lactosa (ask-question "Quieres un menú sin lactosa?  (si/no) " si no))
        (if (eq ?lactosa si) then (slot-insert$ ?x restrictions 1 [sin-lactosa]))
        (bind ?nuts (ask-question "Quieres un menú sin frutos secos?  (si/no) " si no))
        (if (eq ?nuts si) then (slot-insert$ ?x restrictions 1 [nut-free]))
        (bind ?sodium (ask-question "Quieres un menú bajo en sodio?  (si/no) " si no))
        (if (eq ?sodium si) then (slot-insert$ ?x restrictions 1 [bajo-en-sodio]))
        (bind ?religiosa (ask-question "Quieres un menú con restricciones religiosas?  (si/no) " si no))
        (if (eq ?religiosa si) then
            (bind ?religion (ask-question "Que religión?  (musulmana/judía/otra) " musulmana judía otra))
            (if (eq ?religion musulmana) then (slot-insert$ ?x restrictions 1 [halal]))
            (if (eq ?religion judía) then (slot-insert$ ?x restrictions 1 [kosher]))
        )
        (bind ?restr2 (ask-question "Quieres algún tipo de condición especial en la comida?  (blanda/liquida/no) " blanda liquida no))
        (if (eq ?restr2 blanda) then (slot-insert$ ?x restrictions 1 [blanda]))
        (if (eq ?restr2 liquida) then (slot-insert$ ?x restrictions 1 [liquida]))
    else
        (printout t "De acuerdo, no aplicaremos restricciones dietéticas." crlf)
    ) 
)

(defrule PREGUNTAS::askRegionComida
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?restr (ask-question "Te gustaria que la comida fuera de una región en especifico?  (si/no) " si no))
    (if (eq ?restr si) then
    
        (bind ?region (ask-question "Que región?  (española/italiana/mexicana/asiatica) " española italiana mexicana asiatica))
        (if (eq ?region española) then (slot-insert$ ?x restrictions 1 [españa]))
        (if (eq ?region italiana) then (slot-insert$ ?x restrictions 1 [italia]))
        (if (eq ?region mexicana) then (slot-insert$ ?x restrictions 1 [mexico]))
        (if (eq ?region asiatica) then (slot-insert$ ?x restrictions 1 [asia]))
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
            (slot-insert$ ?x ingredientes_necesarios 1 [?ing])
            (bind ?i (+ ?i 1))
        )
    )

    (bind ?ingred (ask-question "Te gustaria que el menú no tuviera algún ingrediente concreto?  (si/no) " si no))
    (if (eq ?ingred si) then
        (bind ?q (ask-int "Cuantos? "))
        (bind ?i 0)
        (while (< ?i ?q) do
            (bind ?ing (stringg-question "Que ingrediente? "))
            (slot-insert$ ?x ingredientes_prohibidos 1 [?ing])
            (bind ?i (+ ?i 1))
        )
    )
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

(defrule PREGUNTAS::askDrink
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?beb (ask-question "¿Quieres algun tipo de bebida en especifico? (cerveza/coctel/refresco/vino/zumo/no) " cerveza coctel refresco vino zumo no ))
    (if(neq ?beb no) then
        (send ?x put-DrinkType ?beb)
    )
    
)

(defrule PREGUNTAS::askPresentation
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?tf (ask-question "¿La presentación/estilo es importante para ti? (si/no) " si no ))
    (send ?x put-PresentacionImportante ?tf)
    
)

(defrule PREGUNTAS::endAsking
	(declare (salience -10))
	(newPrefs)
	?p <- (object(is-a Prefs))
	=>
	(printout t "Por favor, permítenos un momento para calcular tu menú personalizado. " crlf)
	(assert (endAsking))
)

(defmodule FILTRADO (export ?ALL) (import MAIN ?ALL) (import PREGUNTAS ?ALL))

(deffunction guardarBebida(?bebida)
    (bind ?drinkName (send ?bebida get-nombre))
    (bind ?origen (send ?bebida get-origen))
    (bind ?precio (send ?bebida get-precio))
    (bind ?alcoholica (send ?bebida get-alcoholica))
    (bind ?dificultad (send ?bebida get-dificultad_preparacion))
    (bind ?festividad (send ?bebida get-festividad))
    (bind ?propiedades (send ?bebida get-propiedades_dieteticas))
    (bind ?temporadas (send ?bebida get-temporadas))

    (assert (bebida_filtrada 
        (nombre ?nombre)
        (origen ?origen)
        (precio ?precio)
        (alcoholica ?alcoholica)
        (dificultad ?dificultad)
        (festividad ?festividad)
        (propiedades ?propiedades)
        (temporadas ?temporadas))
    )
)

(defrule FILTRADO::FiltrarBebida
    (endAsking)
    ?x <- (object(is-a Prefs))
    ?drink <- (object(is-a Bebida))
    =>
    (bind ?drinkType (send ?x get-DrinkType))
    (if (and(eq ?drinkType cerveza) (is-a? ?bebida Cerveza)) then
        guardarBebida(?bebida)
    )
    (if (and(eq ?drinkType coctel) (is-a? ?bebida Coctel)) then
        guardarBebida(?bebida)
    )
    (if (and(eq ?drinkType refresco) (is-a? ?bebida Refresco)) then
        guardarBebida(?bebida)
    )
    (if (and(eq ?drinkType vino) (is-a? ?bebida Vino)) then
        guardarBebida(?bebida)
    )
    (if (and(eq ?drinkType zumo) (is-a? ?bebida Zumo)) then
        guardarBebida(?bebida)
    )
    (if (eq ?drinkType no) then
        guardarBebida(?bebida)
    )
)
