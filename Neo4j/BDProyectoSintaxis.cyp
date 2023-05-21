// Creamos las estructuras
CREATE (personal:Estructura {desEstructura: "Personal"})
CREATE (impersonal:Estructura {desEstructura: "Impersonal"})

// Creamos las naturalezas del predicado
CREATE (n1:NaturalezaPredicado {vozVerbo: "Pasiva", verboCopulativo: "Atributiva", transitividad: "Transitiva"})
CREATE (n2:NaturalezaPredicado {vozVerbo: "Activa", verboCopulativo: "Predicativa", transitividad: "Intransitiva"})
CREATE (n3:NaturalezaPredicado {vozVerbo: "Pasiva", verboCopulativo: "Predicativa", transitividad: "Transitiva"})
CREATE (n4:NaturalezaPredicado {vozVerbo: "Pasiva", verboCopulativo: "Atributiva", transitividad: "Transitiva"})
CREATE (n5:NaturalezaPredicado {vozVerbo: "Activa", verboCopulativo: "Atributiva", transitividad: "Transitiva"})
CREATE (n6:NaturalezaPredicado {vozVerbo: "Pasiva", verboCopulativo: "Predicativa", transitividad: "Intransitiva"})
CREATE (n7:NaturalezaPredicado {vozVerbo: "Activa", verboCopulativo: "Predicativa", transitividad: "Transitiva"})
CREATE (n8:NaturalezaPredicado {vozVerbo: "Activa", verboCopulativo: "Atributiva", transitividad: "Intransitiva"})

// Creamos las actitudes del hablante
CREATE (negativa:ActitudHablante {desActitud: "Negativa"})
CREATE (afirmativa:ActitudHablante {desActitud: "Afirmativa"})
CREATE (exclamativa:ActitudHablante {desActitud: "Exclamativa"})
CREATE (interrogativa:ActitudHablante {desActitud: "Interrogativa"})
CREATE (desiderativa:ActitudHablante {desActitud: "Desiderativa"})
CREATE (dubitativa:ActitudHablante {desActitud: "Dubitativa"})
CREATE (exhortativa:ActitudHablante {desActitud: "Exhortativa o de orden"})

// Creamos los enunciados
CREATE (o1:Enunciado {texto: "Me seco la cara con una toalla muy suave", tipo: "Oración"})
CREATE (o2:Enunciado {texto: "¡Que tengas suerte!", tipo: "Oración"})
CREATE (o3:Enunciado {texto: "El tabaco perjudica la salud", tipo: "Oración"})
CREATE (o4:Enunciado {texto: "Se alquila apartamento grande y silencioso", tipo: "Oración"})

// Relacionamos los enunciados con su estructura
CREATE (o1)-[:ES]->(personal)
CREATE (o2)-[:ES]->(personal)
CREATE (o3)-[:ES]->(personal)
CREATE (o4)-[:ES]->(impersonal)

// Relacionamos los enunciados con su naturaleza
CREATE (o1)-[:NATURALEZA]->(n7)
CREATE (o2)-[:NATURALEZA]->(n7)
CREATE (o3)-[:NATURALEZA]->(n7)
CREATE (o4)-[:NATURALEZA]->(n6)

// Relacionamos los enunciados con su actitud del hablante
CREATE (o1)-[:ACTITUD]->(afirmativa)
CREATE (o2)-[:ACTITUD]->(desiderativa)
CREATE (o3)-[:ACTITUD]->(afirmativa)
CREATE (o4)-[:ACTITUD]->(afirmativa)

// Para ver todo
MATCH (n) RETURN n

// Para actualizar uno de los datos
MATCH (personal:Estructura {desEstructura: "Personal"})
SET personal.descripcion = "Tiene el sujeto explícito (presente en la oración) o implícito (sobreentendido)"
RETURN personal

// Para eliminar un dato
// MATCH (personal:Estructura {desEstructura: "Personal"})
// DETACH DELETE personal

// Para agregar datos nuevos con relaciones
// create (enunciativa:ActitudHablante {desActitud: "Enunciativa"})
// match (enunciativa:ActitudHablante, o2:enunciados)
// where enunciativa.desActitud = "Enunciativa" and o2.texto = "¡Que tengas suerte!"
// create (o2)-[:ACTITUD]->(enunciativa)