# Teoría

1. Investiga el ciclo de vida de una app y haz el diagrama correspondiente donde se vean todos los estados.

#### Overview

Cuando no hay aplicaciones corriendo, salvo las que son del sistema operativo, nuestra app no esta corriendo, y cuando se ingresa en ella, el gestor de la pantalla del teléfono lanza la aplicación y sus librerías que serán cargadas en la memoria del teléfono. Mientras que este  proceso (llamado _springboard_)  se ejecuta, el _launch screen_ de nuestra aplicación se ejecutará y comenzará la ejecución del _application delegate_ quien recibe las notificaciones de la app y gestiona el ciclo de vida de la app. 

Es importante indicar que el manager del sistema operativo se encarga de manejar los cambios de estados de la app, sin embargo la app por si misma debe de indicar que cambios se realizaran en estas transiciones.

![Estados de un App en iOS](.\IMG\ios-app-life-cycle-state-relationship.png)

#### iOS App Life Cycle State

Existen 5 estados que una app puede tomar (Ver Imagen 1) durante su ciclo de vida, seguido se enlistan:

1. _Not running_: La aplicación no ha arrancado o ha sido parada por el sistema operativo.
2. _Inactive_: La app entra al estado _foreground_ pero no procesa eventos. Este estado se puede adoptar también cuando hay una transición entre estados, no es posible interactuar con el UI de la app en este estado. 
3. _Active_: La app entra al estado _foreground_ y puede procesar eventos, responde a  interacciones con el UI y puede ver la respuesta y resultado de las interacciones del usuario. 
4. _Background_:  La aplicación entra en el _background_, y si hay código ejecutable, lo ejecuta, en caso contrario o si la ejecución ha terminado la aplicación se suspende de inmediato. Este estado suele ser adoptado cuando hay apps suspendidas y que pasarán a los estados Active o Inactive.
5. _Suspended_:  La app suspendida va a una zona donde no puede ejecutar código, y termina si el sistema no tiene suficiente memoria, cuando entra en este estado, el sistema no notifica a la app, solo la purga para dar prioridad a las funciones en primer plano. 

#### iOS App Life Cycle State y el Método de Mapeo _AppDelegate_

Cuando el ciclo de vida de una app cambia, el método relacionado en la clase _AppDelegate_ será invocado:

1. La aplicación ha comenzado su ciclo y su método relacionado ha sido invocado, el _root view controller_ se ha instanciado en este estado:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
```

2. Cuando la app entra al _foregorund_ y esta activo, puede invocar el método mencionado abajo. Usualmente puede restaurar el estado del UI en este método o para reiniciar las tareas que se detuvieron o no han iniciado cuando la app no estaba activa:

```swift
func applicationDidBecomeActive(_ application: UIApplication)
```

3. Este método se llama y notifica cada que la app cambia de estado de activo a inactivo, usualmente guarda el estado de la información de UI en este método y pausa cualquier tarea en curso:

```swift
func applicationWillResignActive(_ application: UIApplication)
```

4. Este método se llama y notifica cuando la app entra en el _background_. En este método podemos guardar información del usuario así como liberar recursos de archivos o bases de datos. Estas tareas las realizará en 5 segundos o la menoría se  purgará. Es posible solicitar tiempo extra con el método: ```beginBackgroundTask (expirationHandler :)``` 

```swift
func applicationDidEnterBackground ( _ application: UIApplication )
```

5. Cuando a app va al _foreground_ (luego de estar en segundo plano) pero no ha sido activada podría invocar este método para deshacer cualquier cambio realizado en el background. Se puede restaurar la información del usuario en este método. Cuando este método termina, el método ```applicationDidBecomeActive``` se ejecuta para llevar la app del estado inactivo al activo. 

```swift
func applicationWillEnterForeground(_ application: UIApplication)
```

6. Este método es llamado y notificado cuando la app va a terminar. Es posible liberar recursos en este método y podemos además guardar información del usuario dentro de: 

```swift
func applicationWillTerminate(_ application: UIApplication)
```

Dadas las funciones antes vistas, podemos visualizar en la Imagen 2 una tabla de funciones que ejecuta el AppDelegate cuando tanto el dispositivo, como la app tienen condiciones especificas. En la Imagen se abordan casos en los que la app puede ser cerrada y bajo que estados:

![Tabla de funciones por estado y condiciones del dispositivo](.\IMG\1_SC6bLgPzsb52pEXlV-MdrQ.jpeg)

2. Investiga la arquitectura MVC

#### Modelo MVC en iOS

Es un patrón de desarrollo de software compuesto de tres objetos principales:

- Modelo: Es ahí donde residen los datos, hace manejo de persistencia, modelo de información, analizadores, administradores y el código de red de la app.
  - Código de red: manejo de solicitudes http, sus respuestas y el manejo de errores.
  - Código de persistencia: Aquí se conservan los datos en bases de datos o bien se almacenan datos en el dispositivo
  - Código de análisis: objetos que analizan las respuestas de red.
  - Managers y capas o clases de abstracción: clases que manejan otras clases del modelo 
  - Fuentes de datos y delegados: proporcionan formas de obtención de información y delegar tareas a componentes. 
  - Constantes: las constantes se guardan con las estructuras y variables
  - Helpers y extensiones: métodos que permiten realizar tareas con la información, como ampliar la capacidad de las cadenas. 
- Vista: nos presenta con el usuario, todos sus elementos y clases asociadas a ellos son reutilizables y extensibles.
  - Subclases ```UIView``` 
  - Clases de un kit
  - Animaciones y gráficos
- Controlador:  es un mediador entre la vista y el modelo a través del patrón de delegación. Usa protocolos para comunicarse con la vista y el modelo sin necesidad de acceder directamente a ellos, un ejemplo es el como el ```UITableview``` se comunica con su fuente de datos usando el protocolo ```UITableViewDataSource```.  
  - Contiene la lógica de negocio 
  - Determina el orden en que se ejecutarán los procesos
  - Actualización de la app
  - Cómo manejar el flujo entre vistas
  - Respuestas ante acciones del usuario 

![Diagrama del modelo MVC](.\IMG\01-MVC-Diagram.png)

Todas las capas del modelo están separadas y cumplen un rol especifico.

##### Ciclo de vida y arquitectura MVC en iOS

Cuando la app inicia, la función UIApplicationMain del objeto UIApplication, configura bjetos clave e inicia la ejecución de la app, siendo este objeto aquel que facilite las interacciones entre el sistema y otros objetos de la app.

![Elementos MVC en iOS](.\IMG\MVC-lifeCycle.png)

El objeto _UIApplication_ gestiona los eventos y comportamientos de app de alto nivel, informa de transiciones de aplicaciones clave y eventos como push notifications a el delegate.

- Main Run Loop: procesa los eventos desatados por el usuario siendo el objeto UIApplication quien lo configura al lanzar la app y lo usa para procesar eventos y manejar actualizaciones a interfaces. Como este ciclo se ejecuta en el hilo principal de la app, los eventos se procesan en serie en el orden en que se reciben.

![Main Run App](.\IMG\mainloopapp.png)

Los eventos entran en el queue y se envían uno a uno al ciclo principal de ejecución para ser atendidos .

- Ciclo de lanzamiento:

  - Ciclo de lanzamiento al primer plano

  ![Lanzar una app al primer plano](.\IMG\launchcicle.png)

  - Lanzar una app en segundo plano:

  ![Lanzar una app en segundo plano](C:\Users\garci\Documents\ECC-Laboratoria-Swift-Course\Typora files\IMG\launchcicletosecondplane.png)

  - Lanzar una app del primer plano al fondo:

  ![Pasar del primer plano al fondo](.\IMG\lauchtobackground.png)



3. Investiga las diferencias entre una clase y una estructura en Swift

Son constructores que nos permiten crear tipos de datos flexibles estableciéndoles propiedades y métodos por medio de la definición de constantes, variables y funciones. 

- Cosas en común:

  - Definen propiedades para almacenar valores
  - Definen métodos para proporcionar funcionalidad
  - Define subíndices para acceder a propiedades de una instancia
  - Usa la notación punto para ejecutar funciones sobre una instancia específica
  - Define inicializadores para configurar su estado inicial
  - Extienden su funcionalidad fuera de la predeterminada
  - Cumple con protocolos para proporcionar funcionalidad estándar de cierto tipo

- Diferencias:

  - Las clases tienen capacidades que las estructuras no:
    - La herencia permite crear clases con características de otras clases
    - La inferencia de tipo permite interpretar el tipo de una instancia de clase
    - Los des inicializadores permiten liberar recursos asignados a una clase
    - Es posible tener más de una referencia a una instancia de clase

- Comparación

  - Definición de tipos:

    > Nota:
    >
    > Siempre que defina una nueva estructura o clase, defina un nuevo tipo Swift. Dar tipos `UpperCamelCase`nombres (por ejemplo, `SomeStructure`y `SomeClass`aquí) para que coincida con la capitalización de los tipos Swift estándar (como por ejemplo `String`, `Int`y `Bool`). Proporcione `lowerCamelCase`nombres de propiedades y métodos (como `frameRate`y `incrementCount`) para diferenciarlos de los nombres de tipo.

    

  ```swift
  struct SomeStructure {
      // structure definition goes here
  }
  class SomeClass {
      // class definition goes here
  }
  
  struct Resolution {
      var width = 0
      var height = 0
  }
  class VideoMode {
      var resolution = Resolution()
      var interlaced = false
      var frameRate = 0.0
      var name: String?
  }
  ```

  - Instanciación

  ```swift
  let someResolution = Resolution()
  let someVideoMode = VideoMode()
  ```

  - Acceso a propiedades

  ```swift
  // Accede con propiedad . 
  print("The width of someResolution is \(someResolution.width)")
  // Prints "The width of someResolution is 0"
  // Accede a propiedades anidadas
  print("The width of someVideoMode is \(someVideoMode.resolution.width)")
  // Prints "The width of someVideoMode is 0"
  // Asigna propedades 
  someVideoMode.resolution.width = 1280
  print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
  // Prints "The width of someVideoMode is now 1280"
  ```

  - Inicializadores Memberwise: Las estructuras tienen un inicializador miembro que se genera de forma automática. Las instancias de clases no tienen un inicializador predeterminado como miembro si no que se tienen que definir con código

  ```swift
  let vga = Resolution(width: 640, height: 480)
  ```

  - Tipos por valor: Al igual que los enums, las estructuras son enumeraciones por tipos de valor, es decir que se hace una copia del original cuando se asigna a una variable o constante, sucede lo mismo cuando se pasa como parámetro a una función

  ```swift
  let hd = Resolution(width: 1920, height: 1080)
  var cinema = hd
  // cambiar valor a la copia
  cinema.width = 2048
  // El cambio en la copia no afecta al original
  print("cinema is now \(cinema.width) pixels wide")
  // Prints "cinema is now 2048 pixels wide"
  
  print("hd is still \(hd.width) pixels wide")
  // Prints "hd is still 1920 pixels wide"
  ```

  ![Tipos de dato por valor - Structs](.\IMG\sharedStateStruct_2x.png)

  - Tipos por referencia: Las clases usan este tipo de tipado y a diferencia de los structs, no copian cuando se asignan a una variable o constante, si no que usan la referencia en memoria de la misma instancia existente, con lo que un cambio en una instancia, afectara al original y a otras instancias que tienen referencia a la misma. 

  ```swift
  // Primer instancia
  let tenEighty = VideoMode()
  tenEighty.resolution = hd
  tenEighty.interlaced = true
  tenEighty.name = "1080i"
  tenEighty.frameRate = 25.0
  // Segunda instancia
  let alsoTenEighty = tenEighty
  alsoTenEighty.frameRate = 30.0
  
  print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
  // Prints "The frameRate property of tenEighty is now 30.0"
  ```

  ![Tipado por referencia - Class](.\IMG\sharedStateClass_2x (1).png)

  - Operadores de identidad: Se usan para averiguar si dos constantes o variables se refieren a la misma instancia de una clase, estos operadores son: Idéntico a ```===``` y No es idéntico a```!==``` 

  ```swift
  if tenEighty === alsoTenEighty {
      print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
  }
  // Prints "tenEighty and alsoTenEighty refer to the same VideoMode instance."
  ```

  Considerar que idéntico implica que además de que  tienen valores equivalentes y con el mismo tipo de dato, apuntan al  mismo espacio de memoria 

  - Punteros: es posible acceder a los punteros de memoria en clases por medio de punteros y búfer de la administración manual de memoria. 
  - Rendimiento: Una clase es un poco más lenta que un struct por su uso de memoria, ya que al estar en la pila de memoria, es más fácil crear y destruir una struct que una clase que se almacena en memoria. Además las structs no necesitan asignación de memoria dinámica o conteo de referencias

  

4. Investiga a qué se refiere que Swift sea un lenguaje orientado a protocolos.

> Paradigma de programación adoptado en Swift 2.0.

> Un protocolo es un modelo de métodos, propiedades y otros requisitos que se adaptan a una tarea particular o una funcionalidad

Swift no admite herencia múltiple, pero gracias a los protocolos es posible agregar habilidades a una clase, estructura o enumeración  con protocolos que admiten múltiples implementaciones.

Un protocolo modela la abstracción describiendo qué implementarán los tipos de implementación. Algunas características de este paradigma son:

- Los tipos pueden conformar más de un protocolo. Esto trae una flexibilidad perfecta.
- Los protocolos también pueden ser extendidos y adoptados por clases, estructuras y enumeraciones.
- Las extensiones de protocolos dan funcionalidad común a todos los tipos que conforman el protocolo
- 

Las extensiones de protocolo proporcionan la capacidad de definir el comportamiento predeterminado para los tipos de *valor* y no solo para las clases, todos esos tipos conforman el mismo protocolo.

Es una buena practica escribir pequeños protocolos que realizan una acción específica e individual. Después es posible añadir implementaciones a esas _extensiones_, lo que significa que  puedes añadir funcionalidad a tipos existentes para hacerlos parte del protocolo.

La programación orientada a protocolos de swift se puede  comparar con la herencia múltiple de otros lenguajes (como C++), pero las extensiones de protocolos no pueden incluir estados.

- Protocolo

> Un protocolo es una colección de métodos que describen un conjunto de acciones y comportamientos similares. 

## Ejercicios

```swift
// STRUCTS 
/* Estructuras
Son formas de crear nuestros propios tipos de datos, las estructuras se componen de 
constantes y variables(propiedades), así como de sus funciones(métodos)

*/
struct Sport {
    var name: String // stored property
}
// Para usarlas, se crean instancias de las estructuras
var tennis = Sport(name: "Tennis")
print(tennis.name)
// Se puede cambiar el valor de la propiedad
tennis.name = "Lawn tennis"
print(tennis.name)

// Computed properties
// Cambian de valor al correr cierto código
struct Sport2 {
    var name: String
    var isOlympicSport: Bool

    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

let chessBoxing = Sport2(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)
let swimming = Sport2(name: "Swimming", isOlympicSport: true)
print(swimming.olympicStatus)


/*
Observadores de propiedad:
Permiten correr código antes o después de que cambie una propiedad
*/
struct Progress {
    var task: String
    var amount: Int
}
// Crear una intancia y cambiar los valores
var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100
print(progress.amount)
// La propiedad didSet observa por cambios en la propiedad indicada
struct Progress2 {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}
var progress2 = Progress2(task: "Loading data", amount: 0)
progress2.amount = 30
progress2.amount = 80
progress2.amount = 100

// Con willSet puedes tomar acciones antes de cambiar la propiedad

struct Progress3 {
    var task: String
    var amount: Int {
        willSet {
            print("\(task) is change to \(amount)% complete")
        }
    }
}
var progress3 = Progress3(task: "Loading data", amount: 0)
progress3.amount = 30
progress3.amount = 80
progress3.amount = 100


/*
métodos
Funciones que pueden usar las propiedades de la estructura
*/
struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}
let london = City(population: 9_000_000)
let myLondon = london.collectTaxes()
print(myLondon)
// Mutación de métodos
// Ayudan a indicar que un método mutara de valor una 
// propiedad de la estructura

struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()
print(person.name)

// Propiedades y métodos de strings
let string = "Do or do not, there is no try."
// Número de caracteres
print(string.count)
// Identifica si un substring esta contenido en:
print(string.hasPrefix("Do"))
// Convierte a mayusculas
print(string.uppercased())
// Crea un arreglo con las letras ordenadas
print(string.sorted())

// Propiedades y métodos de los arreglos
var toys = ["Woody"]
// Número de items:
print(toys.count)
// Agrega un elemento al final
toys.append("Buzz")
print(toys)
// Encuentra el indice de un elemento
toys.firstIndex(of: "Buzz")
print(toys.firstIndex(of: "Buzz"))
// ordena el arreglo
print(toys.sorted())
// remueve un elemento
toys.remove(at: 0)
print(toys)

// Inicializadores
// Indican si se quiere crear una estructura con un valor por defecto

// Sin inicializador
struct User {
    var username: String
}
var user = User(username: "twostraws")
print(user)

// con inicializador
struct User2 {
    var username: String

    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user2 = User2()
// no es necesario usar el keyword func para inicializadores, 
// pero es obligatorio que todos los valores tengan un valor antes
// de que finalice el inicializador
user2.username = "twostraws"
print(user2.username)

// Referencia al a instancia en curso
/*
Esta propiedad ayuda a referir a las propiedades que se
encuentran dentro de la estructura y se refieren a la instancia creada
Son muy utiles al distinguir entre propiedades (self) y parámetros 
*/
struct PersonSelf {
    var name: String

    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}
var myPerson = PersonSelf(name: "Yocelin")
print(myPerson.name)

/*
Propiedades flojas xD
Ayudan a crear propiedades solo cuando es necesario
*/
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct PersonLazy {
    var name: String
    lazy  var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

var ed = PersonLazy(name: "Ed")
print(ed.familyTree)
/*
Propiedades estáticas y métodos
Cada estructura permite crear diferentes instancias de ella
*/
struct Student {
    var name: String

    init(name: String) {
        self.name = name
    }
}

let ed2 = Student(name: "Ed")
print(ed2.name)
let taylorStudent = Student(name: "Taylor")
print(taylorStudent.name)

// si se declaran propiedades o métodos como static tendrán el
// mismo valor para cada isntancia
struct StudentStatic {
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        StudentStatic.classSize += 1
    }
}
let ed3 = StudentStatic(name: "Ed")
print(StudentStatic.classSize)

/*
Control de acceso
Restringe qué código puede usar propiedades y métodos
*/
struct PersonId {
    var id: String

    init(id: String) {
        self.id = id
    }
}

let edId = PersonId(id: "12345")
print(edId.id)
struct PersonPrivate {
    private var id: String

    init(id: String) {
        self.id = id
    }
}
/* No se puede:
let edIdPriv = PersonPrivate(id: "12345")
print(edIdPriv.id)
*/

struct PersonPrivateTrue {
    private var id: String

    init(id: String) {
        self.id = id
    }

    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let edIdPriv2 = PersonPrivateTrue(id: "12345")
print(edIdPriv2.identify())

// ------

// CLASS
/*
CLASES:
Permiten crear tipos de datos con propiedades y métodos
Existen algunas diferencias entre las clases y las estructuras.
1. Las clases no tienen un inicializador (miembro), lo
cual implica que siempre se deben de crear inicializadores propios. 
*/
class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
// Al crear una instancia de la clase, se ejecuta el inicializador
let poppy = Dog(name: "Poppy", breed: "Poodle")
print(poppy.name, poppy.breed)


/* Herencia de clases
2. Puedes crear una clase con base en una clase que ya existe,
la nueva clase hereda todas las propiedades y métodos de la clase
original y puede añadir nuevos.
A este comportamiento se le denomina herencia de clases o subclassing.
La clase original se denomina padre o clase super, mientras que a la nueva
se le denomina hija.
En el ejemplo, el inicializador, puede mandar llamar al inicializador
de la clase padre
*/
class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}
let perrito = Poodle(name: "Perrito")
print(perrito.name, perrito.breed)
// Por defecto, swift siempre llama la función super.init() 
// de la clase padre, dentro de la clase hija.

/*
Métodos de anulación
Son de utilidad para reemplazar métodos de una clase padre
por su propio método hijo, este proceso se le conoce como anulación
*/
class DogNoise {
    func makeNoise() {
        print("Woof!")
    }
}
// Su clase hija hereda su comportamiento
class PoodleNoise: DogNoise {
}

let poppyNoise = PoodleNoise()
poppyNoise.makeNoise()
/*
Agregar la keyword override func antes del método a sobreescribir
se realizará el proceso, si no se agrega el keyword y se intenta 
sobre escribir la función, resultará en un error
*/
class PoodleOverride: DogNoise {
    override func makeNoise() {
        print("Yip!")
    }
}
let poppyNoiseOverride = PoodleOverride()
poppyNoiseOverride.makeNoise()

/*
Clases finales
Es posible proteger una clase para que no tenga override añadiendo 
el keyword final al principio de la declaración
De est forma, se tendrá que usar la clase tal como esta escrita
*/
final class DogFinal {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
let poppyFinal = DogFinal(name: "Patitas de coneja", breed: "Labarador")
print(poppyFinal.name, poppyFinal.breed)
/*
Copiando objetos
3. La tercer diferencia es como se copian las clases y estructuras
Las estructuras son diferentes (original y copias)
Las clases y sus copias apuntan (en dirección) al mismo lugar, si cambias una
todos lo harán
*/
class Singer {
    var name = "Taylor Swift"
}
// La insancia conserva el valor de la clase
var singer = Singer()
print(singer.name)
// Las copias nuevas apuntan a la misma dirección de memoria
var singerCopy = singer
singerCopy.name = "Justin Bieber"
print(singer.name)
/*
Desinicializadores
4. Las clases, a diferencia de las estructuras, tienen de inicializadores
Son códigos que pueden correr cuando una instancia de la clase se destruye
*/
class PersonClass {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    deinit {
        print("\(name) is no more!")
    }
}

for _ in 1...3 {
    let person = PersonClass()
    person.printGreeting()
}
/*
Mutabilidad
5. Manejo de constantes: Las propiedades de las clases pueden cambiar
aunque la clase sea constante
*/
class SingerMutate {
    var name = "Taylor Swift"
}

let taylor = SingerMutate()
taylor.name = "Ed Sheeran"
print(taylor.name)
// Variables constantes
class SingerConst {
    let name = "Taylor Swift"
}
let taylor2 = SingerConst()
// Debe ser error: taylor2.name = "Ed Sheeran"
print(taylor2.name)
// -----
 
/* OPTIONALS
Manejo de perdida de información
Se usan para dar una respuesta cuando lo que se solicita 
no tiene valor
*/
var ageOp: Int? = nil
ageOp = 38
print(ageOp)

/*
Deselvonviendo opcionales
Cuando una variable esta vacía en memoria, su valor en nil,
por lo que apesar de que este definido para tener cierto tipo de dato, no podrá acceder 
a los métodos definidos para él
El proceso de unwrapping,  es aquel que permite manejar estos casos para 
prevenir que el proceso se inseguro.
Uno de los métodos usados, es el uso de if let, en el que se crea la variable 
si existe, en caso contrario fallará
*/
var name: String? = nil
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}
/*
La variable name será un string, si se cumple la condición de existencia, entrará 
dentro del unwrapped como un string regular, y podrá usar todas las propiedades de string
en caso contrario correrá el código del else 
*/
/*
Unwrapping con guarda
Otra alternativa, es el uso de guard let, el cual manejar las variables como opcionales
y si encuentra nil, saldra de la función, ciclo o condición que lo use
Con guard let, la variable sige siendo usable fuera de la condición
*/
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}
greet("Yocelin")
greet(nil)

/*
Unwrapping forzado
Cuando un valor puede o no existir, es util usar el unwrapping, cuando esto sucede y el valor que tomará la variable tendrá
un valor especifíco, es recomendable usar el unwrapping forzado. 
*/
let str = "5"
let num = Int(str)
// Escribiendo ! después de Int(str) aseguramos que siembre se haga la asignación si el valor de str es casteable //// como Int
let num2 = Int(str)!
/* Es necesario aclarar que si no es casteable, la app romperá, por lo que solo es recomendable usar este caso cuando se este seguro
que siempre se cumplirá la condición*/

/*
OPCIONALES IMPLICITOS CON UNWRAPPING
Este tipo de opcionales, pueden tener un valor o pueden ser nil, pero no necesitan ser desenvueltas para poder usarse, se crean al agregar 
un signo de ! después del tipo de dato y se les asigna el valor nil, dado esto, se comportan como si estuvieran desenvueltos sin necesidad de 
usar if let o guard let, pero si no tienen un valor, el código fallará*/


let age: Int! = nil

/*
NIL COALESCING
Son de ayuda para proporcionar un retorno a un valor con base en una comparación, deberá asignarse un valor por defecto
*/

func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}
// Funcionalidad correcta
let userFunc = username(for: 15) ?? "Anonymous"
print(userFunc)
/*
Encadenamiento opcional
Cuando se hace una operación sobre varias variables, y alguna es opcional, es necesario añadirle el signo de ? para que si no 
existe, se ignore el resto de la linea y regrese nil, en caso contrario, se hara unwrapping y continuará el proceso
*/
let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased()
print(beatle)
let names2 = [nil, "Paul", "George", "Ringo"]
// NO corre: let beatle2 = names2.first?.uppercased()
// print(beatle2)

/*
Try opcional
*/
// Correr try catch
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}
/*
Existen otras opciones ante el uso de do, try -> catch, una de ellas usa unwrapping y es el uso de try?, que hace uso de funciones que 
retornan un opcional, si la función resulta en un error, regresa nil como resultado, en caso contrario, regresa el valor opcional
*/
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}
if let result2 = try? checkPassword("password2") {
    print("Result was \(result2)")
} else {
    print("D'oh.")
}
/*
Otra alternativa, el el uso de try!, que solo se usará cuando se sabe que la funcion resultará de forma positiva
*/
try! checkPassword("sekrit")
print("OK!")

/*
INICIALIZADORES QUE FALLAN  
Es posible hacer uso de opcionales para las funciones init de clases y estructuraas, donde en caso de fallar, inicializará las propiedades
como nil y en caso de existo, asignará un valor
*/
struct PersonFail {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}
let abril =  PersonFail(id: "123456789")
print(abril == nil) // Es falso, por que el id tiene la longitud adecuada
let abril2 =  PersonFail(id: "1234")
print(abril2 == nil) // Es true por que la longitud es menor

/*Typecasiting
Hace Un retorno opcional dependiendo del tipo de si el tipo 
de dato por el que se pregunta, cumple la condiciòn
En el ejemplo, se tiene un arreglo de mascotas que contiene 
intancias de una clase (algunas son derivadas de la calse
original, y otras son derivadas de una clase hija) 
Este arreglo serà de clase Animals (por inferencia de tipo)
y se hecharà mano del typecasting para saber en cual de 
esos conceptos, se puede invocar el método makeNoise()
*/
class Animal { }
class Fish: Animal { }

class DogTypecasting: Animal {
    func makeNoise() {
        print("Woof!")
    }
}
let pets = [Fish(), DogTypecasting(), Fish(), DogTypecasting()]
for pet in pets {
    if let dogTypecasting = pet as? DogTypecasting {
        dogTypecasting.makeNoise()
    }
}

/*
Protocolos

Describen las propiedades y métodos que algo debería tener. El proceso de adopción o de conformación de un protocolo ayuda a que swift sepa que tipos usar en un protocolo
Ej: Una función acepta algo con propiedad id: En el protocolo, conforma los tipos que debería de tener el id, en conjunto con sus acciones
*/
protocol Identifiable {
    var id: String { get set }
}
// Instancia del protocolo son descripciones pero no un tipo tal cual
// En su lugar, un tipo puede conformar el protocolo
struct UserProtocol: Identifiable {
    var id: String
}
func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}
// Herencia de protocolos
// Puedes heredar y añadir tus propias caracteristicas al principio
protocol Payable {
    // Requiere conformar tipos que implmenten esta funcion
    func calculateWages() -> Int
}

protocol NeedsTraining {
    // Requiere conformar tipos que implmenten esta funcion
    func study()
}

protocol HasVacation {
    // Requiere conformar tipos que implmenten esta funcion
    func takeVacation(days: Int)
}
// nuevo protocolo con herencia
protocol Employee: Payable, NeedsTraining, HasVacation { }
/*
Extensiones:
Nos aseguran añadir métodos que puedan modificar el comportamiento original con el que se crearon
*/
extension Int {
    func squared() -> Int {
        return self * self
    }
}
let number = 8
number.squared()
print(number.squared())
// solose añaden propiedades computadas
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}
/* Extensiones de protocolos
Los protocolos te permiten describir métodos que deberías tener, pero se debe de especificar el código que ejecutarán para cada caso, y solo afectará  a ese tipo de dato.
*/
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])
/*
El arreglo y el set conformaran un protocolo y luego se creará una extensión para añadir un método que impima la colección
*/ 
extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    
    }
}

pythons.summarize()
beatles.summarize()
/*POP
Las extensiones de protocolos proveen implementaciones por defecto para nuestros métodos de protocolos
*/
protocol IdentifiablePop {
    var id: String { get set }
    func identify()
}
// Cala tipo que conforme el protocolo deberá tener su propia funcion identify, pero la extensión del protocolo nos permite tener uno por defecto
extension IdentifiablePop {
    func identify() {
        print("My ID is \(id).")
    }
}
struct UserPop: IdentifiablePop {
    var id: String
}

let twostraws = UserPop(id: "twostraws")
twostraws.identify()

/*
- Los protocolos describen que métodos y propiedades cnforman un 
tipo, pero no proveen la implementación de esos métodos.
- Podemos escirbir protocolos basados en otros protocolos
- Las extensiones permiten añadir metodos y propiedades computadas
a tipos específicos (como int) y a otros protocolos
- POP is la practica de diseñar arquitectura de apps como
series de protocolos, luego usan extensiones para proveer métodos
por defecto a implementaciones
*/
```