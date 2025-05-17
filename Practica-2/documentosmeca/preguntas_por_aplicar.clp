
(defmodule PREGUNTAS (export ?ALL) (import MAIN ?ALL))


(defrule PREGUNTAS::askEventType
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?event (ask-question "Que tipo de evento es?  (boda/comunion/bautizo/corporativo/otro) " boda comunion bautizo corporativo otro))
    (send ?x put-Evento ?event)
)

(defrule PREGUNTAS::askFormality
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?type (ask-question "Que tipo de evento es?  (formal/informal/casual) " formal informal casual))
    (send ?x put-Tipo ?type)
)

(defrule PREGUNTAS::askPresentation
	(newPrefs)
    ?x <- (object(is-a Prefs))
	=>
	(bind ?tf (ask-question "¿La presentación/estilo es importante para ti? (si/no) " si no ))
    (send ?x put-PresentacionImportante ?tf) 
)
