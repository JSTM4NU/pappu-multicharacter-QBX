local Translations = {
    ui = {
        -- Main
        male = "Maschio",
        female = "Femmina",
        error_title = "Errore!",
        characters_header = "Selettore personaggio",
        characters_count = "personaggi",
      
         --Setup Characters
       default_image = 'image/action_dot.gif',
       create_new_character = "Crea un nuovo personaggio",
       default_right_image = 'image/action_key.png',

        --Create character
        create_header = "Crea l'identità",
        header_detail = "Inserisci le generalià",
        gender_marker = "Selezione genere",
        
        missing_information = "Mancano delle informazioni",
        badword = "Linguaggio inappropriato",
       
        create_firstname = "Nome",
        create_lastname = "Cognome",
        create_nationality = "Nazionalità",
        create_birthday = "Data di nascita",

        -- Buttons
        select = "Seleziona",
        create = "Crea",
        spawn = "Spawna",
        delete = "Cancella",
        cancel = "Indietro",
        confirm = "Conferma",
        close = "Chiudi",
    },

    notifications = {
        ["char_deleted"] = "Personaggio cancellato!",
        ["deleted_other_char"] = "Hai cancellato con successo il personaggio %{citizenid}.",
        ["forgot_citizenid"] = "Non hai inserito il citizenid",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "Cancella un altro personaggio",
        ["citizenid"] = "Citizen ID",
        ["citizenid_help"] = "Il Citizen ID del personaggio da cancellare",

        --Loaded
       
        -- /logout
        ["logout_description"] = "Ritorna alla selezione del personaggio",

        -- /closeNUI
        ["closeNUI_description"] = "Chiudi Multi NUI"
    },

    misc = {
        ["succes_loaded"] = '^2[qb-core]^7 %{value} has succesfully loaded!',
        ["droppedplayer"] = "Sei stato disconnesso"
    },


}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
