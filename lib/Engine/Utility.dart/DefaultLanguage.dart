class DefaultLanguage {
  static String en = """{
    "artist": {
        "type": "{1} DJ|{2} Produttore|{3} Band|{4} Cantante|{5} Orchestra|{6} Strumentista",
        "dj": "DJ",
        "producer": "Produttore",
        "band": "Band",
        "singer": "Cantante",
        "orchestra": "Orchestra",
        "instrumentalist": "Strumentista"
    },
    "auth": {
        "failed": "These credentials do not match our records.",
        "password": "The provided password is incorrect.",
        "throttle": "Too many login attempts. Please try again in :seconds seconds."
    },
    "cookie": {
        "content_text": "Questo sito web memorizza dati come i cookie per abilitare la funzionalità del sito, tra cui analisi e personalizzazione. Utilizzando questo sito web, accetti automaticamente che utilizziamo i cookie.",
        "deny": "Rifiuta",
        "accept": "Accetta"
    },
    "event": {
        "organizer_primary": "Evento organizzato da",
        "and": "e",
        "others": "others",
        "from_hours": "Dalle ore",
        "to_hours": "alle",
        "from_day": "Da",
        "to_day": "fino a",
        "save": "Salva",
        "remove": "Rimuovi",
        "show_more": "Mostra altro",
        "show_less": "Nascondi",
        "digital_place_event": "L'evento si svolge nel luogo indicato, ed è inoltre trasmesso in streaming",
        "organizer": "Organizzatori",
        "terminated": "Evento terminato",
        "now": "In corso",
        "event_saved_success": "Evento salvato con successo! Puoi vedere tutti i tuoi eventi salvati nel tuo profilo.",
        "event_remove_success": "Evento rimosso con successo"
    },
    "needfy": {
        "organizer": "Organizzatore di eventi",
        "club": "Locale notturno",
        "artist": "Artista musicale",
        "skip": "Salta"
    },
    "notifications": {
        "alt_image_notification": "Immagine della notifica",
        "new": "Nuove",
        "other": "Precedenti",
        "all": "Tutte",
        "no_notification": "Non hai nessuna notifica"
    },
    "organizer": {
        "follower": "follower",
        "follow": "Segui",
        "unfollow": "Segui già",
        "follow_success": "seguito con successo! Puoi vedere tutti gli elementi seguiti nel tuo profilo",
        "unfollow_success": "Rimosso dagli elementi seguii"
    },
    "pagination": {
        "previous": "« Previous",
        "next": "Next »"
    },
    "passwords": {
        "reset": "La tua password è stata resettata!",
        "sent": "Abbiamo inviato una mail per il reset mail!",
        "throttled": "Per favore, aspetti prima di riprovare.",
        "token": "Questo token di reimpostazione password non è valido.",
        "user": "Non riusciamo a trovare un utente con quell'indirizzo email.",
        "forgot": "Password dimenticata?"
    },
    "profile": {
        "reviewed": "Recensioni",
        "following": "Seguiti",
        "saved": "Eventi",
        "organizers": "Organizzatori",
        "clubs": "Club",
        "artists": "Artisti"
    },
    "review": {
        "vote": "{0} Nessun voto|{1} :value voto|{2,*} :value voti",
        "voted": "Hai votato",
        "review": "Recensisci",
        "modify_review": "Modifica recensione",
        "new_review": "Nuova recensione",
        "response": "risposta",
        "modify": "Modifica",
        "delete": "Elimina",
        "post": "Posta",
        "update": "Aggiorna",
        "textarea_placeholder": "Motiva la tua recensione"
    },
    "showcase": {
        "digital_event": "Evento digitale",
        "now": "In corso",
        "today": "Oggi",
        "showmore": "Mostra altro",
        "empty_showcase": "Nessun risultato"
    },
    "validation": {
        "accepted": "The :attribute must be accepted.",
        "active_url": "The :attribute is not a valid URL.",
        "after": "The :attribute must be a date after :date.",
        "after_or_equal": "The :attribute must be a date after or equal to :date.",
        "alpha": "The :attribute may only contain letters.",
        "alpha_dash": "The :attribute may only contain letters, numbers, dashes and underscores.",
        "alpha_num": "The :attribute may only contain letters and numbers.",
        "array": "The :attribute must be an array.",
        "before": "The :attribute must be a date before :date.",
        "before_or_equal": "The :attribute must be a date before or equal to :date.",
        "between": {
            "numeric": "The :attribute must be between :min and :max.",
            "file": "The :attribute must be between :min and :max kilobytes.",
            "string": "The :attribute must be between :min and :max characters.",
            "array": "The :attribute must have between :min and :max items."
        },
        "boolean": "The :attribute field must be true or false.",
        "confirmed": "The :attribute confirmation does not match.",
        "date": "The :attribute is not a valid date.",
        "date_equals": "The :attribute must be a date equal to :date.",
        "date_format": "The :attribute does not match the format :format.",
        "different": "The :attribute and :other must be different.",
        "digits": "The :attribute must be :digits digits.",
        "digits_between": "The :attribute must be between :min and :max digits.",
        "dimensions": "The :attribute has invalid image dimensions.",
        "distinct": "The :attribute field has a duplicate value.",
        "email": "The :attribute must be a valid email address.",
        "ends_with": "The :attribute must end with one of the following: :values.",
        "exists": "The selected :attribute is invalid.",
        "file": "The :attribute must be a file.",
        "filled": "The :attribute field must have a value.",
        "gt": {
            "numeric": "The :attribute must be greater than :value.",
            "file": "The :attribute must be greater than :value kilobytes.",
            "string": "The :attribute must be greater than :value characters.",
            "array": "The :attribute must have more than :value items."
        },
        "gte": {
            "numeric": "The :attribute must be greater than or equal :value.",
            "file": "The :attribute must be greater than or equal :value kilobytes.",
            "string": "The :attribute must be greater than or equal :value characters.",
            "array": "The :attribute must have :value items or more."
        },
        "image": "The :attribute must be an image.",
        "in": "The selected :attribute is invalid.",
        "in_array": "The :attribute field does not exist in :other.",
        "integer": "The :attribute must be an integer.",
        "ip": "The :attribute must be a valid IP address.",
        "ipv4": "The :attribute must be a valid IPv4 address.",
        "ipv6": "The :attribute must be a valid IPv6 address.",
        "json": "The :attribute must be a valid JSON string.",
        "lt": {
            "numeric": "The :attribute must be less than :value.",
            "file": "The :attribute must be less than :value kilobytes.",
            "string": "The :attribute must be less than :value characters.",
            "array": "The :attribute must have less than :value items."
        },
        "lte": {
            "numeric": "The :attribute must be less than or equal :value.",
            "file": "The :attribute must be less than or equal :value kilobytes.",
            "string": "The :attribute must be less than or equal :value characters.",
            "array": "The :attribute must not have more than :value items."
        },
        "max": {
            "numeric": "The :attribute may not be greater than :max.",
            "file": "The :attribute may not be greater than :max kilobytes.",
            "string": "The :attribute may not be greater than :max characters.",
            "array": "The :attribute may not have more than :max items."
        },
        "mimes": "The :attribute must be a file of type: :values.",
        "mimetypes": "The :attribute must be a file of type: :values.",
        "min": {
            "numeric": "The :attribute must be at least :min.",
            "file": "The :attribute must be at least :min kilobytes.",
            "string": "The :attribute must be at least :min characters.",
            "array": "The :attribute must have at least :min items."
        },
        "multiple_of": "The :attribute must be a multiple of :value.",
        "not_in": "The selected :attribute is invalid.",
        "not_regex": "The :attribute format is invalid.",
        "numeric": "The :attribute must be a number.",
        "password": "The password is incorrect.",
        "present": "The :attribute field must be present.",
        "regex": "The :attribute format is invalid.",
        "required": "The :attribute field is required.",
        "required_if": "The :attribute field is required when :other is :value.",
        "required_unless": "The :attribute field is required unless :other is in :values.",
        "required_with": "The :attribute field is required when :values is present.",
        "required_with_all": "The :attribute field is required when :values are present.",
        "required_without": "The :attribute field is required when :values is not present.",
        "required_without_all": "The :attribute field is required when none of :values are present.",
        "same": "The :attribute and :other must match.",
        "size": {
            "numeric": "The :attribute must be :size.",
            "file": "The :attribute must be :size kilobytes.",
            "string": "The :attribute must be :size characters.",
            "array": "The :attribute must contain :size items."
        },
        "starts_with": "The :attribute must start with one of the following: :values.",
        "string": "The :attribute must be a string.",
        "timezone": "The :attribute must be a valid zone.",
        "unique": "The :attribute has already been taken.",
        "uploaded": "The :attribute failed to upload.",
        "url": "The :attribute format is invalid.",
        "uuid": "The :attribute must be a valid UUID.",
        "custom": {
            "attribute-name": {
                "rule-name": "custom-message"
            }
        },
        "attributes": []
    }
}""";
}
