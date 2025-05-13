;;; ---------------------------------------------------------
;;; ontologia.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology onto1.owl
;;; :Date 12/05/2025 18:19:44

(defclass Bebida
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot alcoholica
        (type SYMBOL)
        (allowed-values true false)
        (create-accessor read-write))
    (slot dificultad_preparacion
        (type SYMBOL)
        (allowed-values facil normal dificil)
        (create-accessor read-write))
    (multislot festividad
        (type SYMBOL)
        (allowed-values true false)
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
        (allowed-values bajo-en-sodio carne diabetico dieta-saludable halal koshur nut-free marisco pescado sin-gluten sin-lactosa vegano vegetariano)
        (create-accessor read-write))
    (multislot temporadas
        (type SYMBOL)
        (allowed primavera verano otoño invierno)
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
    (slot origen
        (type STRING)
        (create-accessor read-write))
    (multislot origen_ingrediente
        (type SYMBOL)
        (allowed-values extranjero local)
        (create-accessor read-write))
    (multislot propiedades_ingrediente
        (type SYMBOL)
        (allowed-values carbohidratos fibra lipidos proteina vegetal vitaminas)
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
        (allowed-values facil normal dificil)
        (create-accessor read-write))
    (multislot festividad
        (type SYMBOL)
        (allowed-values true false)
        (create-accessor read-write))
    (multislot metodo_preparacion
        (type SYMBOL)
        (allowed-values barbacoa crudo frito hervido horno marinado plancha vapor estofado)
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
        (allowed-values moderno regional rustica sibarita tradicional)
        (create-accessor read-write))
    (multislot propiedades_dieteticas
        (type SYMBOL)
        (allowed-values bajo-en-sodio carne diabetico dieta-saludable halal kosher nut-free marisco pescado sin-gluten sin-lactosa vegano vegetariano)
        (create-accessor read-write))
    (multislot sabor
        (type SYMBOL)
        (allowed-values dulce fuerte picante salado suave)
        (create-accessor read-write))
    (slot temperatura
        (type SYMBOL)
        (allowed-values caliente frio templado)
        (create-accessor read-write))
    (multislot temporadas
        (type SYMBOL)
        (allowed primavera verano otoño invierno)
        (create-accessor read-write))
    (multislot textura
        (type SYMBOL)
        (allowed-values cremoso crujiente firme jugoso liquido tierno)
        (create-accessor read-write))
    (multislot tipo_plato
        (type SYMBOL)
        (allowed-values postre primero segundo)
        (create-accessor read-write))
)
