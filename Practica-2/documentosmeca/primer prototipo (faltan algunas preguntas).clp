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
    (p1 of Plato
        (nombre "ensalada de aguacate y tomate")
        (tipo_plato primero)
        (contiene aguacate tomate cebolla aceite-oliva sal vinagre)
        (metodo_preparacion crudo)
        (origen "españa")
        (dificultad_preparacion facil)
        (presentacion tradicional)
        (sabor suave salado)
        (temperatura frio)
        (textura cremoso crujiente)
        (temporadas verano)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio diabetico dieta-saludable halal kosher nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 6.00)
        (compatibleCon)
    )

    (p2 of Plato
        (nombre "gazpacho andaluz")
        (tipo_plato primero)
        (contiene tomate pepino pimiento cebolla ajo aceite-oliva vinagre agua sal)
        (metodo_preparacion crudo)
        (origen "españa")
        (dificultad_preparacion facil)
        (presentacion tradicional)
        (sabor suave salado)
        (temperatura frio)
        (textura liquido)
        (temporadas verano)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio dieta-saludable halal kosher nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 8.00)
        (compatibleCon)
    )

    (p3 of Plato
        (nombre "sopa de cebolla francesa")
        (tipo_plato primero)
        (contiene cebolla caldo-de-carne pan queso-gruyere aceite-oliva mantequilla sal pimienta)
        (metodo_preparacion hervido)
        (origen "francia")
        (dificultad_preparacion normal)
        (presentacion tradicional)
        (sabor salado fuerte)
        (temperatura caliente)
        (textura cremoso liquido)
        (temporadas invierno)
        (festividad false)
        (propiedades_dieteticas carne nut-free)
        (precio 10.00)
        (compatibleCon)
    )

    (p4 of Plato
        (nombre "croquetas de jamon")
        (tipo_plato primero)
        (contiene jamon-serrano leche harina mantequilla cebolla aceite-oliva huevo pan sal pimienta)
        (metodo_preparacion frito)
        (origen "españa")
        (dificultad_preparacion normal)
        (presentacion tradicional)
        (sabor salado fuerte)
        (temperatura caliente)
        (textura cremoso crujiente)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas carne nut-free)
        (precio 9.00)
        (compatibleCon)
    )

    (p5 of Plato
        (nombre "risotto de setas y parmesano")
        (tipo_plato primero)
        (contiene arroz setas cebolla caldo-de-verdura mantequilla parmesano sal)
        (metodo_preparacion hervido)
        (origen "italia")
        (dificultad_preparacion dificil)
        (presentacion sibarita)
        (sabor suave salado)
        (temperatura caliente)
        (textura cremoso)
        (temporadas otoño invierno)
        (festividad false)
        (propiedades_dieteticas halal nut-free sin-gluten vegetariano)
        (precio 12.00)
        (compatibleCon)
    )

    (p6 of Plato
        (nombre "canelones rellenos de espinacas y ricotta")
        (tipo_plato primero)
        (contiene canelones espinacas ricotta cebolla tomate parmesano leche harina aceite-oliva sal)
        (metodo_preparacion horno)
        (origen "italia")
        (dificultad_preparacion normal)
        (presentacion tradicional)
        (sabor suave salado)
        (temperatura caliente)
        (textura cremoso tierno)
        (temporadas otoño invierno)
        (festividad false)
        (propiedades_dieteticas carne halal nut-free vegetariano)
        (precio 10.00)
        (compatibleCon)
    )

    (p7 of Plato
        (nombre "pasta fresca con pesto de albahaca y piñones")
        (tipo_plato primero)
        (contiene pasta albahaca piñones parmesano aceite-oliva ajo sal)
        (metodo_preparacion hervido)
        (origen italia)
        (dificultad_preparacion normal)
        (presentacion moderno)
        (sabor suave salado)
        (temperatura caliente)
        (textura tierno)
        (temporadas primavera verano)
        (festividad false)
        (propiedades_dieteticas halal vegetariano)
        (precio 9.00)
        (compatibleCon)
    )

    (p8 of Plato
        (nombre "tacos de carnitas")
        (tipo_plato primero)
        (contiene cerdo cebolla cilantro chile tortilla-de-maiz lima ajo comino laurel)
        (metodo_preparacion hervido horno)
        (origen "mexico")
        (dificultad_preparacion normal)
        (presentacion tradicional)
        (sabor salado fuerte picante)
        (temperatura caliente)
        (textura tierno jugoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas carne nut-free sin-lactosa)
        (precio 10.00)
        (compatibleCon)
    )

    (p9 of Plato
        (nombre "empanadas de carne")
        (tipo_plato primero)
        (contiene carne-picada cebolla aceitunas huevo pasas comino pimenton masa)
        (metodo_preparacion horno)
        (origen "argentina")
        (dificultad_preparacion normal)
        (presentacion tradicional)
        (sabor salado)
        (temperatura caliente)
        (textura crujiente jugoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas carne kosher nut-free sin-lactosa)
        (precio 8.00)
        (compatibleCon)
    )

    (p10 of Plato
        (nombre "ramen de pollo")
        (tipo_plato primero)
        (contiene fideos caldo-de-pollo pollo cebollino huevo salsa-de-soja aceite-sesamo alga-nori)
        (metodo_preparacion hervido)
        (origen "japon")
        (dificultad_preparacion normal)
        (presentacion moderna)
        (sabor salado)
        (temperatura caliente)
        (textura suave tierno)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas carne halal kosher nut-free sin-lactosa)
        (precio 11.00)
        (compatibleCon)
    )

    (p11 of Plato
        (nombre "crema templada de calabaza y coco")
        (tipo_plato primero)
        (contiene calabaza leche-coco cebolla jengibre aceite-oliva curcuma sal)
        (metodo_preparacion hervido)
        (origen "internacional")
        (dificultad_preparacion facil)
        (presentacion moderna)
        (sabor suave dulce)
        (temperatura templado)
        (textura cremoso liquido)
        (temporadas otoño invierno)
        (festividad false)
        (propiedades_dieteticas baja-en-sodio diabetico dieta-saludable halal kosher nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 7.00)
        (compatibleCon)
    )

    (p12 of Plato
        (nombre "ensalada de quinoa con verduras al vapor")
        (tipo_plato primero)
        (contiene quinoa brocoli zanahoria calabacin aceite-oliva sal pimienta limon)
        (metodo_preparacion vapor)
        (origen "internacional")
        (dificultad_preparacion facil)
        (presentacion moderna)
        (sabor suave)
        (temperatura frio)
        (textura firme crujiente)
        (temporadas primavera verano)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio diabetico dieta-saludable halal kosher nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 8.00)
        (compatibleCon)
    )

    (p13 of Plato
        (nombre "vieiras a la plancha con pure de coliflor")
        (tipo_plato primero)
        (contiene vieiras coliflor mantequilla aceite-oliva sal pimienta nuez-moscada leche)
        (metodo_preparacion plancha)
        (origen "francia")
        (dificultad_preparacion dificil)
        (presentacion sibarita)
        (sabor suave)
        (temperatura caliente)
        (textura tierno cremoso)
        (temporadas invierno)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio diabetico dieta-saludable marisco sin-gluten)
        (precio 15.00)
        (compatibleCon)
    )

    (p14 of Plato
        (nombre "berenjenas rellenas de bonito")
        (tipo_plato primero)
        (contiene berenjena bonito tomate cebolla queso)
        (metodo_preparacion horno)
        (origen "españa")
        (dificultad_preparacion normal)
        (presentacion tradicional)
        (sabor suave salado)
        (temperatura caliente)
        (textura jugoso cremoso)
        (temporadas verano)
        (festividad false)
        (propiedades_dieteticas diabetico dieta-saludable halal nut-free pescado sin-gluten)
        (precio 8.00)
        (compatibleCon)
    )

    (p15 of Plato
        (nombre "gambas al ajillo")
        (tipo_plato primero)
        (contiene gambas ajo guindilla aceite-oliva perejil sal)
        (metodo_preparacion plancha)
        (origen "españa")
        (dificultad_preparacion facil)
        (presentacion regional)
        (sabor picante sal)
        (temperatura caliente)
        (textura tierno jugoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas diabetico nut-free marisco sin-gluten sin-lactosa)
        (precio 10.00)
        (compatibleCon)
    )

    ; Segundos

    (p21 of Plato
        (nombre "paella de marisco")
        (tipo_plato primero segundo)
        (contiene arroz gambas mejillones calamares tomate pimiento cebolla aceite-oliva azafran caldo-de-pescado sal)
        (metodo_preparacion hervido horno)
        (origen "españa")
        (dificultad_preparacion normal)
        (presentacion regional)
        (sabor salado fuerte)
        (temperatura caliente)
        (textura tierno jugoso)
        (temporadas verano otoño)
        (festividad false)
        (propiedades_dieteticas halal kosher nut-free marisco pescado sin-gluten sin-lactosa)
        (precio 18.00)
        (compatibleCon)
    )

    (p22 of Plato
        (nombre "lomo de cerdo a la barbacoa")
        (tipo_plato segundo)
        (contiene lomo-de-cerdo salsa-barbacoa ajo cebolla aceite-oliva sal pimienta)
        (metodo_preparacion barbacoa asado)
        (origen "eeuu")
        (dificultad_preparacion normal)
        (presentacion sibarita)
        (sabor salado fuerte)
        (temperatura caliente)
        (textura tierno jugoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas carne nut-free sin-gluten sin-lactosa)
        (precio 20.00)
        (compatibleCon)
    )

    (p23 of Plato
        (nombre "rabo de toro estofado")
        (tipo_plato segundo)
        (contiene rabo-de-toro cebolla zanahoria vino-tinto caldo-de-carne laurel aceite-oliva sal)
        (metodo_preparacion hervido estofado)
        (origen "españa")
        (dificultad_preparacion dificil)
        (presentacion tradicional)
        (sabor fuerte salado)
        (temperatura caliente)
        (textura tierno jugoso)
        (temporadas otoño invierno)
        (festividad false)
        (propiedades_dieteticas carne nut-free sin-gluten sin-lactosa)
        (precio 25.00)
        (compatibleCon)
    )

    (p24 of Plato
        (nombre "bacalao al horno con pimientos")
        (tipo_plato segundo)
        (contiene bacalao pimiento cebolla ajo aceite-oliva sal pimienta)
        (metodo_preparacion horno)
        (origen "españa")
        (dificultad_preparacion normal)
        (presentacion tradicional)
        (sabor salado fuerte)
        (temperatura caliente)
        (textura tierno jugoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas diabetico dieta-saludable halal kosher nut-free pescado sin-gluten sin-lactosa)
        (precio 15.00)
    )

    (p25 of Plato
        (nombre "sushi de atun")
        (tipo_plato primero segundo)
        (contiene arroz atun alga-nori aguacate vinagre-de-arroz salsa-de-soja wasabi)
        (metodo_preparacion crudo)
        (origen "japon")
        (dificultad_preparacion normal)
        (presentacion sibarita)
        (sabor suave salado picante)
        (temperatura frio)
        (textura firme jugoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas dieta-saludable halal kosher nut-free pescado sin-lactosa)
        (precio 12.00)
        (compatibleCon)
    )

    (p26 of Plato
        (nombre "magret de pato con salsa de frutos rojos y pure de boniato")
        (tipo_plato segundo)
        (contiene pato frutos-rojos boniato vino-tinto aceite-oliva sal pimienta)
        (metodo_preparacion plancha horno)
        (origen "francia")
        (dificultad_preparacion normal)
        (presentacion sibarita)
        (sabor dulce fuerte)
        (temperatura caliente)
        (textura tierno jugoso)
        (temporadas otoño invierno)
        (festividad false)
        (propiedades_dieteticas carne nut-free sin-gluten sin-lactosa)
        (precio 16.00)
        (compatibleCon)
    )

    (p27 of Plato
        (nombre "carrillera de ternera al vino tinto con cremoso de patata")
        (tipo_plato segundo)
        (contiene carrillera vino-tinto cebolla zanahoria patata leche aceite-oliva sal pimienta)
        (metodo_preparacion estofado)
        (origen "españa")
        (dificultad_preparacion dificil)    
        (presentacion tradicional)
        (sabor fuerte salado)
        (temperatura caliente)
        (textura tierno jugoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas carne nut-free sin-gluten)
        (precio 14.00)
        (compatibleCon)
    )

    (p28 of Plato
        (nombre "pechuga de pollo al limon con arroz integral")
        (tipo_plato segundo)
        (contiene pollo arroz limon ajo aceite-oliva sal pimienta)
        (metodo_preparacion plancha hervido)
        (origen "internacional")
        (dificultad_preparacion facil)
        (presentacion tradicional)
        (sabor suave)
        (temperatura caliente)
        (textura tierno jugoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio carne diabetico dieta-saludable halal kosher nut-free sin-gluten sin-lactosa)
        (precio 8.00)
        (compatibleCon)
    )

    (p29 of Plato
        (nombre "tortilla de patatas con cebolla caramelizada")
        (tipo_plato segundo)
        (contiene huevo patata cebolla aceite-oliva sal azucar)
        (metodo_preparacion frito)
        (origen "españa")
        (dificultad_preparacion normal)
        (presentacion tradicional)
        (sabor suave salado)
        (temperatura caliente)
        (textura tierno cremoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas halal kosher nut-free sin-gluten sin-lactosa vegetariano)
        (precio 9.00)
        (compatibleCon)
    )

    (p30 of Plato
        (nombre "chili con carne")
        (tipo_plato segundo)
        (contiene carne-picada frijoles tomate cebolla ajo chile pimiento comino cilantro sal)
        (metodo_preparacion hervido estofado)
        (origen "mexico")
        (dificultad_preparacion normal)
        (presentacion tradicional)
        (sabor fuerte picante)
        (temperatura caliente)
        (textura tierno jugoso)
        (temporadas otoño invierno)
        (festividad false)
        (propiedades_dieteticas carne nut-free sin-gluten sin-lactosa)
        (precio 12.00)
        (compatibleCon)
    )

    (p31 of Plato
        (nombre "asado de tira")
        (tipo_plato segundo)
        (contiene costillas-de-res cebolla vino-tinto romero laurel aceite-oliva sal pimienta)
        (metodo_preparacion barbacoa)
        (origen "argentina")
        (dificultad_preparacion dificil)
        (presentacion tradicional)
        (sabor fuerte salado)
        (temperatura caliente)
        (textura tierno jugoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas carne diabetico halal kosher nut-free sin-gluten sin-lactosa)
        (precio 18.00)
        (compatibleCon)
    )

    (p32 of Plato
        (nombre "tempura de gambas y verduras")
        (tipo_plato segundo)
        (contiene gambas harina huevo agua cebollino aceite-oliva)
        (metodo_preparacion frito)
        (origen "japon")
        (dificultad_preparacion normal)
        (presentacion moderna)
        (sabor suave)
        (temperatura caliente)
        (textura crujiente)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio halal kosher nut-free marisco sin-lactosa)
        (precio 9.00)
        (compatibleCon)
    )

    (p33 of Plato
        (nombre "pollo teriyaki con arroz integral")
        (tipo_plato segundo)
        (contiene pollo salsa-teriyaki arroz cebollino jengibre ajo aceite-oliva sal)
        (metodo_preparacion plancha marinado)
        (origen "japon")
        (dificultad_preparacion normal)
        (presentacion moderna)
        (sabor dulce salado)
        (temperatura caliente)
        (textura tierno jugoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas carne dieta-saludable halal kosher nut-free sin-lactosa)
        (precio 14.00)
        (compatibleCon)
    )

    (p34 of Plato
        (nombre "salmon al horno con verduras asadas")
        (tipo_plato segundo)
        (contiene salmon zanahoria calabacin esparrago aceite-oliva limon romero sal pimienta)
        (metodo_preparacion horno)
        (origen "internacional")
        (dificultad_preparacion facil)
        (presentacion moderna)
        (sabor suave salado)
        (temperatura caliente)
        (textura tierno jugoso)
        (temporadas primavera verano)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio dieta-saludable halal kosher nut-free pescado sin-gluten sin-lactosa)
        (precio 17.00)
        (compatibleCon)
    )

    (p35 of Plato
        (nombre "chuletillas de cordero rebozadas con patatas fritas")
        (tipo_plato segundo)
        (contiene cordero ajo huevo pan-rallado perejil sal pimienta aceite-oliva patata cebolla)
        (metodo_preparacion frito horno)
        (origen "españa") 
        (dificultad_preparacion normal)
        (presentacion regional)
        (sabor salado fuerte)
        (temperatura caliente)
        (textura tierno crujiente)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas carne nut-free sin-lactosa)
        (precio 17.00)
        (compatibleCon)
    )


    ; Postres

    (p51 of Plato
        (nombre "tarta de manzana")
        (tipo_plato postre)
        (contiene manzana azucar harina mantequilla huevo canela nuez-moscada)
        (metodo_preparacion horno)
        (origen "francia")
        (dificultad_preparacion normal)
        (presentacion tradicional)
        (sabor dulce suave)
        (temperatura templado)
        (textura crujiente tierno)
        (temporadas otoño invierno)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio vegetariano)
        (precio 5.00)
    )

    (p52 of Plato
        (nombre "helado de vanilla")
        (tipo_plato postre)
        (contiene leche azucar vainilla huevo nata)
        (metodo_preparacion crudo)
        (origen "italia")
        (dificultad_preparacion facil)
        (presentacion moderno)
        (sabor dulce suave)
        (temperatura frio)
        (textura cremoso)
        (temporadas verano)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio halal kosher nut-free sin-gluten vegetariano)
        (precio 3.00)
    )

    (p53 of Plato
        (nombre "flan de huevo")
        (tipo_plato postre)
        (contiene huevo leche azucar vainilla caramelo)
        (metodo_preparacion horno)
        (origen "españa")
        (dificultad_preparacion facil)
        (presentacion tradicional)
        (sabor dulce suave)
        (temperatura frio)
        (textura cremoso tierno)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas halal kosher nut-free sin-gluten vegetariano)
        (precio 4.00)
    )

    (p54 of Plato
        (nombre "mousse de chocolate con frutos rojos")
        (tipo_plato postre)
        (contiene chocolate-negro nata huevo azucar frambuesa mora)
        (metodo_preparacion crudo)
        (origen "francia")
        (dificultad_preparacion normal)
        (presentacion moderna)
        (sabor dulce fuerte)
        (temperatura frio)
        (textura cremoso)
        (temporadas otoño invierno)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio halal nut-free sin-gluten vegetariano)
        (precio 5.50)
        (compatibleCon)
    )

    (p55 of Plato
        (nombre "tiramisu clasico")
        (tipo_plato postre)
        (contiene queso huevo azucar cafe bizcocho-de-soletilla cacao)
        (metodo_preparacion crudo)
        (origen "italia")
        (dificultad_preparacion normal)
        (presentacion sibarita)
        (sabor dulce)
        (temperatura frio)
        (textura cremoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas nut-free vegetariano)
        (precio 5.00)
        (compatibleCon)
    )

    (p56 of Plato
        (nombre "fruta fresca laminada con sirope de maracuya")
        (tipo_plato postre)
        (contiene mango piña papaya maracuya lima menta)
        (metodo_preparacion crudo)
        (origen "internacional")
        (dificultad_preparacion facil)
        (presentacion moderna)
        (sabor dulce)
        (temperatura frio)
        (textura jugoso)
        (temporadas primavera verano)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio diabetico dieta-saludable halal kosher nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 3.50)
        (compatibleCon)
    )

    (p57 of Plato
        (nombre "arroz con leche")
        (tipo_plato postre)
        (contiene arroz leche azucar canela limon)
        (metodo_preparacion hervido)
        (origen "españa")
        (dificultad_preparacion facil)
        (presentacion tradicional)
        (sabor dulce)
        (temperatura templado)
        (textura cremoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio halal nut-free sin-gluten vegetariano)
        (precio 3.00)
        (compatibleCon)
    )

    (p58 of Plato
        (nombre "brownie de chocolate con nueces y helado de vainilla")
        (tipo_plato postre)
        (contiene chocolate-negro mantequilla azucar huevo nuez harina vainilla leche)
        (metodo_preparacion horno)
        (origen "eeuu")
        (dificultad_preparacion normal)
        (presentacion sibarita)
        (sabor dulce fuerte)
        (temperatura templado)
        (textura tierno cremoso)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas vegetariano)
        (precio 6.00)
        (compatibleCon)
    )

    (b1 of Vino_tinto
        (nombre "vino tinto rioja")
        (alcoholica true)
        (origen españa)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad true)
        (propiedades_dieteticas bajo-en-sodio nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 15.00)
    )

    (b2 of Vino_tinto
        (nombre "vino tinto ribera del duero")
        (alcoholica true)
        (origen españa)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad true)
        (propiedades_dieteticas bajo-en-sodio nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 20.00)
    )

    (b3 of Vino_tinto
        (nombre "vino tinto crianza")
        (alcoholica true)
        (origen españa)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad true)
        (propiedades_dieteticas bajo-en-sodio nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 25.00)
    )

    (b4 of Vino_blanco
        (nombre "vino blanco")
        (alcoholica true)
        (origen españa)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad true)
        (propiedades_dieteticas bajo-en-sodio nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 18.00)
    )

    (b5 of Vino_blanco
        (nombre "vino blanco verdejo")
        (alcoholica true)
        (origen españa)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad true)
        (propiedades_dieteticas bajo-en-sodio nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 22.00)
    )

    (b6 of Cerveza
        (nombre "cerveza lager")
        (alcoholica true)
        (origen alemania)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio nut-free sin-lactosa vegano vegetariano)
        (precio 3.00)
    )

    (b7 of Cerveza
        (nombre "cerveza ale")
        (alcoholica true)
        (origen belgica)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio nut-free sin-lactosa vegano vegetariano)
        (precio 4.00)
    )

    (b8 of Cerveza
        (nombre "cerveza stout")
        (alcoholica true)
        (origen irlanda)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio nut-free sin-lactosa vegano vegetariano)
        (precio 5.00)
    )

    (b9 of Refresco
        (nombre "cocacola")
        (alcoholica false)
        (origen eeuu)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas halal kosher nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 2.50)
    )

    (b10 of Refresco
        (nombre "fanta")
        (alcoholica false)
        (origen eeuu)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas halal kosher nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 2.50)
    )

    (b11 of Refresco
        (nombre "sprite")
        (alcoholica false)
        (origen eeuu)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas halal kosher nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 2.00)
    )

    (b12 of Agua
        (nombre "agua")
        (alcoholica false)
        (origen españa)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio diabetico dieta-saludable halal kosher nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 1.50)
    )

    (b13 of Zumo
        (nombre "zumo de naranja")
        (alcoholica false)
        (origen españa)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio dieta-saludable halal kosher nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 2.50)
    )

    (b14 of Zumo
        (nombre "zumo de manzana")
        (alcoholica false)
        (origen españa)
        (dificultad_preparacion facil)
        (temporadas primavera verano otoño invierno)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio dieta-saludable halal kosher nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 2.50)
    )

    (b15 of Coctel
        (nombre "mojito")
        (alcoholica true)
        (origen cuba)
        (dificultad_preparacion facil)
        (temporadas primavera verano)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 8.00)
    )

    (b16 of Coctel
        (nombre "margarita")
        (alcoholica true)
        (origen mexico)
        (dificultad_preparacion facil)
        (temporadas primavera verano)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 7.00)
    )

    (b17 of Coctel
        (nombre "piña colada")
        (alcoholica true)
        (origen puerto-rico)
        (dificultad_preparacion facil)
        (temporadas primavera verano)
        (festividad false)
        (propiedades_dieteticas bajo-en-sodio nut-free sin-gluten sin-lactosa vegano vegetariano)
        (precio 9.00)
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

(deffunction empty-intersection (?list1 ?list2)
  (foreach ?item ?list1
    (if (neq (member$ ?item ?list2) FALSE) then
       (return FALSE)
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
   (slot dificultad_preparacion   (type SYMBOL))
   (slot nombre                   (type STRING))
   (slot origen                   (type STRING))
   (slot precio                   (type FLOAT))
   (slot presentacion             (type SYMBOL))
   (slot temperatura              (type SYMBOL))
   (multislot compatibleCon       (type INSTANCE))
   (multislot contiene            (type INSTANCE))
   (multislot festividad          (type SYMBOL))
   (multislot metodo_preparacion  (type SYMBOL))
   (multislot propiedades_dieteticas (type SYMBOL))
   (multislot sabor               (type SYMBOL))
   (multislot temporadas          (type SYMBOL))
   (multislot textura             (type SYMBOL))
   (multislot tipo_plato          (type SYMBOL))
)
(deffunction filtrarPlato (?plato)
   (assert (plato_filtrado 
      (dificultad_preparacion   (send ?plato get-dificultad_preparacion))
      (nombre                   (send ?plato get-nombre))
      (origen                   (send ?plato get-origen))
      (precio                   (send ?plato get-precio))
      (presentacion             (send ?plato get-presentacion))
      (temperatura              (send ?plato get-temperatura))
      (compatibleCon            (send ?plato get-compatibleCon))
      (contiene                 (send ?plato get-contiene))
      (festividad               (send ?plato get-festividad))
      (metodo_preparacion       (send ?plato get-metodo_preparacion))
      (propiedades_dieteticas   (send ?plato get-propiedades_dieteticas))
      (sabor                    (send ?plato get-sabor))
      (temporadas               (send ?plato get-temporadas))
      (textura                  (send ?plato get-textura))
      (tipo_plato               (send ?plato get-tipo_plato))
   ))
)

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



(deffunction PlatoCumpleCondiciones (?p ?x)
 (return 
    (and
        (member$ (send ?x get-Temporada) (send ?p get-temporadas)) ;;;TEMPORADA
        (subsetp (send ?x get-restrictions) (send ?p get-propiedades_dieteticas)) ;;; RESTRICCIONES DIETETICAS
        (subsetp (send ?x get-ingredientes_necesarios) (send ?p get-contiene)) ;;; INGREDIENTES NECESARIOS
        (empty-intersection (send ?x get-ingredientes_prohibidos) (send ?p get-contiene)) ;;; INGREDIENTES PROHIBIDOS
        (or (eq (send ?x get-OrigenPlato) (send ?p get-origen)) (eq (send ?x get-OrigenPlato) NULL)) ;;; ORIGEN
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
   =>
    (printout t "Bebida aceptada: " ?name crlf)
)

(defrule FILTRADO::FiltroPlatoDebuggFunction
   (endAsking)
   ?x <- (object (is-a Prefs))
   ?b <- (plato_filtrado (nombre ?name))
   =>
    (printout t "Plato aceptado: " ?name crlf)
)

;;; --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;; GENERATION
;;; --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(defmodule GENERATION (export ?ALL) (import MAIN ?ALL) (import PREGUNTAS ?ALL) (import FILTRADO ?ALL))

(defrule GENERATION::generationTest
	?p1 <- (plato_filtrado (nombre ?p1nombre) (precio ?p1precio) (tipo_plato $?p1tipo_plato))
    ?p2 <- (plato_filtrado (nombre ?p2nombre) (precio ?p2precio) (tipo_plato $?p2tipo_plato))
    ?p3 <- (plato_filtrado (nombre ?p3nombre) (precio ?p3precio) (tipo_plato $?p3tipo_plato))
    ?b1 <- (bebida_filtrada (nombre ?b1nombre) (precio ?b1precio))
    ?b2 <- (bebida_filtrada (nombre ?b2nombre) (precio ?b2precio))
    ?p <- (object (is-a Prefs))
    (test (member$ primero ?p1tipo_plato))
    (test (member$ segundo ?p2tipo_plato))
    (test (member$ postre ?p3tipo_plato))
    (test (> (+ ?p1precio ?p2precio ?p3precio ?b1precio ?b2precio)
            (send ?p get-MinMoney)))
    (test (< (+ ?p1precio ?p2precio ?p3precio ?b1precio ?b2precio)
            (send ?p get-MaxMoney)))
	=>
	(printout t "Menú válido: " ?p1nombre ", " ?p2nombre ", " ?p3nombre
     ", " ?b1nombre ", " ?b2nombre ". Precio: "(+ ?p1precio ?p2precio ?p3precio ?b1precio ?b2precio) crlf)
)