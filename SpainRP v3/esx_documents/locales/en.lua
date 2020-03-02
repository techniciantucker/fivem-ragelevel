Locales['en'] = {
    ['document_deleted'] = "El documento ha sido ~g~eliminado~w~.",
    ['document_delete_failed'] = "Ha ocurrido un problema a la hora de borrar.",

}
Config.Documents['en'] = {
      ["public"] = {
        {
          headerTitle = "Contrato de mutuo acuerdo",
          headerSubtitle = "Contrato donde dos personas quedan de acuerdo sobre algo.",
          elements = {
            { label = "Acuerdo", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "Contrato de matrimonio",
          headerSubtitle = "Documento donde se autoriza que se ha contraido matrimonio.",
          elements = {
            { label = "Dia de lo ocurrido", type = "input", value = "", can_be_emtpy = false },
            { label = "Testimonio", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "Contrato de renta de vehiculo",
          headerSubtitle = "Rentar el vehiculo a otro ciudadano.",
          elements = {
            { label = "Matricula", type = "input", value = "", can_be_emtpy = false },
            { label = "Nombre del ciudadano", type = "input", value = "", can_be_emtpy = false },
            { label = "Precio acordado", type = "input", value = "", can_be_empty = false },
            { label = "Otra informacion", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        {
          headerTitle = "Parte a la aseguradora de automovil ",
          headerSubtitle = "Declaracion de un choque de un vehiculo con otro ciudadano",
          elements = {
            { label = "Nombre del Sujeto 1", type = "input", value = "", can_be_emtpy = false },
            { label = "Nombre del Sujeto 2", type = "input", value = "", can_be_emtpy = false },
            { label = "Fecha de lo sucedido", type = "input", value = "", can_be_empty = false },
            { label = "Informacion de lo sucedido", type = "textarea", value = "Iba conduciendo con el coche cuando el otro sujeto me ha chocado", can_be_emtpy = false, can_be_edited = false },
          } 
        }
      },
      ["police"] = {
        {
          headerTitle = "Aparcamiento Especial",
          headerSubtitle = "Poder aparcar donde quieras",
          elements = {
            { label = "Nombre", type = "input", value = "", can_be_emtpy = false },
            { label = "Apellido", type = "input", value = "", can_be_emtpy = false },
            { label = "Valido Hasta", type = "input", value = "", can_be_empty = false },
            { label = "Informacion", type = "textarea", value = "El sujeto tiene derecho a aparcar en una zona como quiera y sin preocuparse del tiempo hasta la validez del documento.", can_be_emtpy = false },
          } 
        },
        {
          headerTitle = "Permiso de armas",
          headerSubtitle = "Permiso de armas",
          elements = {
            { label = "Nombre", type = "input", value = "", can_be_emtpy = false },
            { label = "Apellidos", type = "input", value = "", can_be_emtpy = false },
            { label = "Valido hasta", type = "input", value = "", can_be_empty = false },
            { label = "Informacion", type = "textarea", value = "El sujeto mencionado tiene derecho a su permiso de armas hasta el dia que se aclara", can_be_emtpy = false },
          } 
        },
        {
          headerTitle = "Limpiar registro",
          headerSubtitle = "Limpiar registro de antepasados.",
          elements = {
            { label = "Nombre del ciudadano", type = "input", value = "", can_be_emtpy = false },
            { label = "Apellidos del Ciudadano", type = "input", value = "", can_be_emtpy = false },
            { label = "Valido hasta", type = "input", value = "", can_be_empty = false },
            { label = "Antepasados", type = "textarea", value = "El policia declara la limpieza de todos los antepasados desde la fecha que se genero este documento", can_be_emtpy = false, can_be_edited = false },
          }         }
      },
      ["ambulance"] = {
        {
          headerTitle = "Asistencia Medica",
          headerSubtitle = "Documento ofrecido por un medico.",
          elements = {
            { label = "Nombre del ciudadano", type = "input", value = "", can_be_emtpy = false },
            { label = "Apellidos del ciudadano", type = "input", value = "", can_be_emtpy = false },
            { label = "Valido hasta", type = "input", value = "", can_be_empty = false },
            { label = "Notas del medico", type = "textarea", value = "El sujeto habia quedado inconsciente y ha sido reanimado mediante una RCP y vendajes.", can_be_emtpy = false },
          }
        },

      ["avocat"] = {
        {
          headerTitle = "LEGAL SERVICES CONTRACT",
          headerSubtitle = "Legal services contract provided by a lawyer.",
          elements = {
            { label = "CITIZEN FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "CITIZEN LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "INFORMATION", type = "textarea", value = "THIS DOCUMENT IS PROOF OF LEGAL REPRESANTATION AND COVERAGE OF THE AFOREMENTIONED CITIZEN. LEGAL SERVICES ARE VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          } 
        }
      }
    }
  }