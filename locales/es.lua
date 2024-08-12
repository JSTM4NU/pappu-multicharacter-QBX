local Translations = {
    ui = {
        -- Main
        male = "Hombre",
        female = "Hembra",
        error_title = "Error!",
        characters_header = "Selector de personaje",
        characters_count = "personajes",
      
         --Setup Characters
       default_image = 'image/action_dot.gif',
       create_new_character = "Crea un nuevo personaje",
       default_right_image = 'image/action_key.png',

        --Create character
        create_header = "Crea la identidad",
        header_detail = "Introduzca las generalidades",
        gender_marker = "Selección de género",
        
        missing_information = "Faltan unas informaciones",
        badword = "Lenguaje inapropiado",
       
        create_firstname = "Nombre",
        create_lastname = "Apellido",
        create_nationality = "Nacionalidad",
        create_birthday = "Fecha de nacimiento",

        -- Buttons
        select = "Selecciona",
        create = "Crea",
        spawn = "Espawna",
        delete = "Elimina",
        cancel = "Atrás",
        confirm = "Confirma",
        close = "Cierra",
    },

    notifications = {
        ["char_deleted"] = "Personaje eliminado!",
        ["deleted_other_char"] = "Has eliminado con éxito el personaje %{citizenid}.",
        ["forgot_citizenid"] = "No has introducido el citizenid",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "Elimina otro personaje",
        ["citizenid"] = "Citizen ID",
        ["citizenid_help"] = "El Citizen ID del personaje de eliminar",

        --Loaded
       
        -- /relog
        ["logout_description"] = "Volver a la selección de personaje",

        -- /closeNUI
        ["closeNUI_description"] = "Cierra Multi NUI"
    },

    misc = {
        ["succes_loaded"] = '^2[qb-core]^7 %{value} has succesfully loaded!',
        ["droppedplayer"] = "Fuistes desconectado"
    },


}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
