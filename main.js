
function encriptarMensaje () {
    let mensajeEntrada = document.getElementById("mensaje-entrada");
    let mensajeSalida = document.getElementById("mensaje-salida");
    let validarMensaje = document.getElementById("validar-texto");

    if (!mensajeEntrada.value){
        validarMensaje.innerHTML = "!Campo vacío, ingrese un texto valido!";
        setTimeout(function () {validarMensaje.innerHTML =""}, 3000);
    }

    let vocales = ["a", "e", "i", "o", "u"];
    // Vocales                  a      e      i      o      u
    let vocalesEncriptadas = ["ai", "enter", "imes", "ober", "ufat"];

    // Convertir los valores ingresados en un array de letras
    let arrayMensajeEntrada = mensajeEntrada.value.split("");
    console.log(arrayMensajeEntrada);
    // Recorrer el array de letras
    for (let i = 0; i < arrayMensajeEntrada.length; i++) {
        for (let j = 0; j < vocales.length; j++) {
            if (vocales[j] === arrayMensajeEntrada[i]) {
                arrayMensajeEntrada[i] = vocalesEncriptadas[j];
            }
        }
        
    }

    mensajeSalida.value = arrayMensajeEntrada.join("");
}

function desencriptarMensaje() {
    let mensajeEntrada = document.getElementById("mensaje-entrada").value;
    let mensajeSalida = document.getElementById("mensaje-salida");
    let validarMensaje = document.getElementById("validar-texto");
    
    if (!mensajeEntrada){
        validarMensaje.innerHTML = "!Campo vacío, ingrese un texto valido!";
        setTimeout(function () {validarMensaje.innerHTML =""}, 3000);
    }

    let vocales = ["a", "e", "i", "o", "u"];
    // Vocales                  a      e      i      o      u
    let vocalesEncriptadas = ["ai", "enter", "imes", "ober", "ufat"];
    
    var resultado = "";
    for (let i = 0; i < vocales.length; i++) {
        resultado = mensajeEntrada.replaceAll(vocalesEncriptadas[i], vocales[i]);   
        mensajeEntrada = resultado;
    }

    mensajeSalida.value = resultado;
    /*let resultado = "";

    for (let i = 0; i < vocalesEncriptadas.length; i++) {
        let resultado =+ mensajeEntrada.value.replaceAll(vocalesEncriptadas[i], vocales[i]);
    }
    alert(resultado); */
    
}

function copiarMensaje() {
    let mensajeSalida = document.getElementById("mensaje-salida");
    let mensajeCopiarTexto = document.getElementById("copiar-texto");

    if (mensajeSalida.value) {
        navigator.clipboard.writeText(mensajeSalida.value);
        mensajeSalida.setSelectionRange(0, mensajeSalida.value.length);
        mensajeSalida.select();
        mensajeCopiarTexto.innerHTML = "!Texto copiado con exito!";
        setTimeout(function () {mensajeCopiarTexto.innerHTML =""}, 3000);
    } else {
        mensajeCopiarTexto.innerHTML = "!Campo vacío!";
        setTimeout(function () {mensajeCopiarTexto.innerHTML =""}, 3000);
    }
}