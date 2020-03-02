Config = {}
Config.Locale = 'en'
--You can add here buttons like inventory menu button. When player click this button, then action will be cancel.
Config.cancel_buttons = {289, 170, 168, 56}

options =
{
  ['seed_weed'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = '¡Desafortunadamente, su planta está marchita!',
        success_msg = '¡Felicitaciones, has cosechado la planta!',
        start_msg = 'Empieza a cultivar las plantas',
        success_item = 'weed',
        cops = 0,
        first_step = 2.35,
        steps = 7,
        cords = {
          {x = -427.05, y = 1575.25, z = 357, distance = 20.25},
          {x = 1254.7, y = -1989.78, z = 43.42, distance = 12.25},
          {x = 1198.05, y = -215.25, z = 55, distance = 20.25},
          {x = 706.05, y = 1269.25, z = 358, distance = 10.25},
        },
        animations_start = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '2500'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim = 'idle_a', timeout = '2500'},
        },
        animations_end = {
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '2500'},
          {lib = 'amb@world_human_cop_idles@male@idle_a', anim ='idle_a', timeout = '2500'},
        },
        animations_step = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '2500'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim ='idle_a', timeout = '18500'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '2500'},
        },
        grow = {
          2.24, 1.95, 1.65, 1.45, 1.20, 1.00
        },
        questions = {
            {
                title = 'Ve a tu planta y germinala, ¿qué vas a hacer?',
                steps = {
                    {label = 'Regar la Planta', value = 1},
                    {label = 'Cagar en la Planta', value = 2},
                    {label = 'Esperar', value = 3}
                },
                correct = 1
            },
            {
                title = 'Han aparecido puntos amarillos en tu planta, ¿qué vas a hacer?',
                steps = {
                    {label = 'Regar la Planta', value = 1},
                    {label = 'Fertilizar la Planta', value = 2},
                    {label = 'Esperar', value = 3}
                },
                correct = 2
            },
            {
                title = 'Ha aparecido polvo azul en las hojas de tu planta, ¿qué vas a hacer?',
                steps = {
                    {label = 'Recoger Hojas individuales', value = 1},
                    {label = 'Espolvorear las hojas con cocaina', value = 2},
                    {label = 'Esperar', value = 3}
                },
                correct = 3
            },
            {
                title = 'Tu planta tiene las primeras cimas, ¿qué vas a hacer?',
                steps = {
                    {label = 'Regar la Planta', value = 1},
                    {label = 'Romper la Planta', value = 2},
                    {label = 'Fertilizar la Planta', value = 3}
                },
                correct = 1
            },
            {
                title = 'Después de regar su planta, comenzaron a aparecer hojas extrañas, ¿qué vas a hacer?',
                steps = {
                    {label = 'Regar la Planta', value = 1},
                    {label = 'Fertilizar la Planta', value = 2},
                    {label = 'Esperar', value = 3}
                },
                correct = 2
            },
            {
                title = 'Su planta está casi lista para cortar, ¿qué vas a hacer?',
                steps = {
                    {label = 'Orinar la Planta', value = 1},
                    {label = 'Fertilizar la Planta', value = 2},
                    {label = 'Esperar', value = 3}
                },
                correct = 3
            },
            {
                title = 'Tu planta está lista para la cosecha, ¿qué estás haciendo?',
                steps = {
                    {label = 'Recogerla usando las tijeras', value = 1, min = 10, max = 25},
                    {label = 'Recoger la planta con tus manos', value = 1, min = 3, max = 15},
                    {label = 'Cortar las plantas con tijeras del chino', value = 1, min = 5, max = 20}
                },
                correct = 1
            },
        },
      },




  ['cocaseed'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = '¡Desafortunadamente, su planta está marchita!',
        success_msg = '¡Felicitaciones, has cosechado la planta!',
        start_msg = 'Empieza a cultivar las plantas',
        success_item = 'cocaplant',
        cops = 0,
        first_step = 2.35,
        steps = 4,
        cords = {
          {x = 1954.22, y = 4795.6, z = 43.65, distance = 20.25},
        },
        animations_start = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '2500'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim = 'idle_a', timeout = '2500'},
        },
        animations_end = {
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '2500'},
          {lib = 'amb@world_human_cop_idles@male@idle_a', anim ='idle_a', timeout = '2500'},
        },
        animations_step = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '2500'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim ='idle_a', timeout = '18500'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '2500'},
        },
        grow = {
          2.24, 1.65, 1.45, 1.00
        },
        questions = {
            {
                title = 'Acabas de plantar la planta, ¿qué vas a hacer?',
                steps = {
                    {label = 'Regar la Planta', value = 1},
                    {label = 'Cagar en la Planta', value = 2},
                    {label = 'Esperar', value = 3}
                },
                correct = 1
            },
            
     
            {
                title = 'Tu planta tiene ya un buen tiempo, ¿qué vas a hacer?',
                steps = {
                    {label = 'Regar la Planta', value = 1},
                    {label = 'Romper la Planta', value = 2},
                    {label = 'Fertilizarla con Nitrogeno y Potasio', value = 3}
                },
                correct = 3
            },
           
            {
                title = 'Su planta está casi lista para cortar, ¿qué vas a hacer?',
                steps = {
                    {label = 'Orinar la Planta', value = 1},
                    {label = 'Quitar los frutos', value = 2},
                    {label = 'Quitar las hojas', value = 3}
                },
                correct = 3
            },
            {
                title = 'Tu planta está lista para la cosecha, ¿qué estás haciendo?',
                steps = {
                    {label = 'Recogerla usando las tijeras', value = 1, min = 3, max = 3},
                    {label = 'Recoger la planta con tus manos', value = 1, min = 2, max = 2},
                    {label = 'Cortar las plantas con tijeras del chino', value = 1, min = 1, max = 1}
                },
                correct = 1
            },
        },
      },
}
