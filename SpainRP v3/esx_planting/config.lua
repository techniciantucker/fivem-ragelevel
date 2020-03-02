Config = {}
Config.Locale = "pl"
--You can add here buttons like inventory menu button. When player click this button, then action will be cancel.
Config.cancel_buttons = {289, 170, 168, 56}

options =
{
  ['maria_semilla'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = 'Tu planta se ha marchitado',
        success_msg = 'Ahí tienes tu maria',
        start_msg = 'Has plantado la semilla',
        success_item = 'maria',
        cops = 1,
        first_step = 1,
        steps = 2,
        cords = {
          --[[ {x = -1980.64, y = 2659.87, z = 1.74, distance = 20.25}, ]]
          {x = 2213.05, y = 5576.25, z = 53, distance = 10.25},
         --[[  {x = 1198.05, y = -215.25, z = 55, distance = 20.25}, ]]
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
                title = '¿Quieres continuar plantando?',
                steps = {
                    {label = 'Si', value = 1},
                    {label = 'No', value = 2}
                },
                correct = 1
            },
            {
                title = '¿Seguro? Es posible que se avise a la poli',
                steps = {
                    {label = 'Si', value = 1, min = 10, max = 30},
                    {label = 'No', value = 1, min = 10, max = 15}
                },
                correct = 1
            },
        },
      },

  ['coca_semilla'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = 'Tu planta se ha marchitado',
        success_msg = 'Ahí tienes tus hojas de coca',
        start_msg = 'Has plantado la semilla',
        success_item = 'coca',
        cops = 1,
        first_step = 1,
        steps = 2,
        cords = {
          {x = -1980.64, y = 2659.87, z = 1.74, distance = 20.25},
          {x = 2213.05, y = 5576.25, z = 53, distance = 10.25},
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
                title = '¿Quieres continuar plantando?',
                steps = {
                    {label = 'Si', value = 1},
                    {label = 'No', value = 2}
                },
                correct = 1
            },
            {
                title = '¿Seguro? Es posible que se avise a la poli',
                steps = {
                    {label = 'Si', value = 1, min = 10, max = 30},
                    {label = 'No', value = 1, min = 10, max = 15}
                },
                correct = 1
            },
        },
      },
  
  ['heroina_semilla'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = 'Tu planta se ha marchitado',
        success_msg = 'Ahí tienes tu Heroina',
        start_msg = 'Has plantado la semilla',
        success_item = 'heroina',
        cops = 1,
        first_step = 1,
        steps = 2,
        cords = {
          {x = -1980.64, y = 2659.87, z = 1.74, distance = 20.25},
          {x = 2213.05, y = 5576.25, z = 53, distance = 10.25},
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
                title = '¿Quieres continuar plantando?',
                steps = {
                    {label = 'Si', value = 1},
                    {label = 'No', value = 2}
                },
                correct = 1
            },
            {
                title = '¿Seguro? Es posible que se avise a la poli',
                steps = {
                    {label = 'Si', value = 1, min = 10, max = 30},
                    {label = 'No', value = 1, min = 10, max = 15}
                },
                correct = 1
            },
        },
      },

  ['opio_semilla'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = 'Tu planta se ha marchitado',
        success_msg = 'Ahí tienes tu Opio',
        start_msg = 'Has plantado la semilla',
        success_item = 'opio',
        cops = 1,
        first_step = 1,
        steps = 2,
        cords = {
          {x = -1980.64, y = 2659.87, z = 1.74, distance = 20.25},
          {x = 2213.05, y = 5576.25, z = 53, distance = 10.25},
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
                title = '¿Quieres continuar plantando?',
                steps = {
                    {label = 'Si', value = 1},
                    {label = 'No', value = 2}
                },
                correct = 1
            },
            {
                title = '¿Seguro? Es posible que se avise a la poli',
                steps = {
                    {label = 'Si', value = 1, min = 10, max = 30},
                    {label = 'No', value = 1, min = 10, max = 15}
                },
                correct = 1
            },
        },
      },

      ['meta_semilla'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = 'Tu planta se ha marchitado',
        success_msg = 'Ahí tienes tu componente de meta',
        start_msg = 'Has plantado la semilla',
        success_item = 'meta',
        cops = 1,
        first_step = 1,
        steps = 2,
        cords = {
          {x = -1980.64, y = 2659.87, z = 1.74, distance = 20.25},
          {x = 2213.05, y = 5576.25, z = 53, distance = 10.25},
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
                title = '¿Quieres continuar plantando?',
                steps = {
                    {label = 'Si', value = 1},
                    {label = 'No', value = 2}
                },
                correct = 1
            },
            {
                title = '¿Seguro? Es posible que se avise a la poli',
                steps = {
                    {label = 'Si', value = 1, min = 10, max = 30},
                    {label = 'No', value = 1, min = 10, max = 15}
                },
                correct = 1
            },
        },
      },
}
