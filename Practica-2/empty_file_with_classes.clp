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
