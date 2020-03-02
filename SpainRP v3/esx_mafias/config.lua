Config = {}

Config.DrawDistance = 140 --[ Marker visibility ]
Config.Locale = 'es'


Config.Gangs = {
    rosa = {
         society = "society_rosa", -- [ esx_Society name ]
         JobName = "rosa", -- [ esx_Job name ]
         JobLabel = "La Rosa Ardiente", -- [ Label ]
         Blip = { -- [ Map Blip for gang house/location ]
             coords = vector3(-1165.7, -2031.69, 14.99),
             sprite = 147,
             scale = 0.8,
             opacity = 0,
             color = 48,
             name = "La Rosa Ardiente",
         },
         Markers = { -- [ Markers for gang management/etc. ]
             boss = { -- [Society actions]
                name = "boss",
                coords = {x = 0.0, y = 0.0, z = 0.0},
                label = "Acciones de Jefe"
             },
             armory = { --[ Item + Weapon storage ]
                name = "armory",
                coords = {x = 0.0, y = 0.0, z = 0.0},
                label = "Armario"
             }
         }
    },
    cni = {
        society = "society_cni", -- [ esx_Society name ]
        JobName = "cni", -- [ esx_Job name ]
        JobLabel = "CNI", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "CNI",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = 124.46, y = -766.96, z = 241.15},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = 118.97, y = -761.62, z = 241.15},
                label = "Armario"
            }
        }
    },
    ballas = {
        society = "society_ballas", -- [ esx_Society name ]
        JobName = "ballas", -- [ esx_Job name ]
        JobLabel = "Ballas", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "Ballas",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = -112.85, y = -13.36, z = 69.52},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = -110.53, y = -14.89, z = 69.52},
                label = "Armario"
            }
        }
    },
    grove = {
        society = "society_grove", -- [ esx_Society name ]
        JobName = "grove", -- [ esx_Job name ]
        JobLabel = "grove", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "grove",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = -18.91, y = -1432.60, z = 30.1},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = -16.01, y = -1430.54, z = 30.1},
                label = "Armario"
            }
        }
    },
    dictadura = {
        society = "society_dictadura", -- [ esx_Society name ]
        JobName = "dictadura", -- [ esx_Job name ]
        JobLabel = "dictadura", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "dictadura",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = -1527.30, y = 833.45, z = 180.59},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = -1521.03, y = 850.14, z = 180.59},
                label = "Armario"
            }
        }
    },
    tgold = {
        society = "society_tgold", -- [ esx_Society name ]
        JobName = "tgold", -- [ esx_Job name ]
        JobLabel = "tgold", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "tgold",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = -99.59, y = 979.81, z = 234.76},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = -101.05, y = 986.40, z = 234.76},
                label = "Armario"
            }
        }
    },
    pawn = {
        society = "society_pawn", -- [ esx_Society name ]
        JobName = "pawn", -- [ esx_Job name ]
        JobLabel = "pawn", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "pawn",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = -1590.02, y = -80.05, z = 53.33},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = -1584.24, y = -80.49, z = 53.33},
                label = "Armario"
            }
        }
    },
    jimenez = {
        society = "society_jimenez", -- [ esx_Society name ]
        JobName = "jimenez", -- [ esx_Job name ]
        JobLabel = "jimenez", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "jimenez",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = 1407.60, y = 1147.64, z = 113.33},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = 1399.72, y = 1139.64, z = 113.33},
                label = "Armario"
            }
        }
    },
    zeltasis = {
        society = "society_zeltasis", -- [ esx_Society name ]
        JobName = "zeltasis", -- [ esx_Job name ]
        JobLabel = "zeltasis", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "zeltasis",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = -806.14, y = 168.32, z = 75.75},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = -811.89, y = 175.06, z = 75.75},
                label = "Armario"
            }
        }
    },
    windowc1 = {
        society = "society_windowc1", -- [ esx_Society name ]
        JobName = "windowc1", -- [ esx_Job name ]
        JobLabel = "Reputation", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "Reputation",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = -1804.84, y = 427.63, z = 127.51},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = -1835.89, y = 447.83, z = 125.51},
                label = "Armario"
            }
        }
    },
    cartel = {
        society = "society_cartel", -- [ esx_Society name ]
        JobName = "cartel", -- [ esx_Job name ]
        JobLabel = "Cartel", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "Cartel",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = -712.60, y = 629.57, z = 154.16},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = -704.43, y = 627.91, z = 154.16},
                label = "Armario"
            }
        }
    },
    bloods = {
        society = "society_bloods", -- [ esx_Society name ]
        JobName = "bloods", -- [ esx_Job name ]
        JobLabel = "The Bloods", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "The Bloods",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = 0.0, y = 0.0, z = 0.0},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = 0.0, y = 0.0, z = 0.0},
                label = "Armario"
            }
        }
    },
    santosblues = {
        society = "society_santosblues", -- [ esx_Society name ]
        JobName = "santosblues", -- [ esx_Job name ]
        JobLabel = "Los Santos Blues", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "Los Santos Blues",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = 1268.77, y = -1710.76, z = 53.77},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = 1275.80, y = -1710.67, z = 53.77},
                label = "Armario"
            }
        }
    },
    caterva = {
        society = "society_caterva", -- [ esx_Society name ]
        JobName = "caterva", -- [ esx_Job name ]
        JobLabel = "La Caterva", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "La Caterva",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = 0.0, y = 0.0, z = 0.0},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = 0.0, y = 0.0, z = 0.0},
                label = "Armario"
            }
        }
    },
    sideserpents = {
        society = "society_sideserpents", -- [ esx_Society name ]
        JobName = "sideserpents", -- [ esx_Job name ]
        JobLabel = "South Side Serpents", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "South Side Serpents",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = 984.11, y = -91.23, z = 73.85},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = 977.32, y = -104.03, z = 73.85},
                label = "Armario"
            }
        }
    },
    briste = {
        society = "society_briste", -- [ esx_Society name ]
        JobName = "briste", -- [ esx_Job name ]
        JobLabel = "Briste", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "briste",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = -1144.34, y = 370.75, z = 73.93},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = -1142.43, y = 365.53, z = 70.32},
                label = "Armario"
            }
        }
    },
    motor = {
        society = "society_motor", -- [ esx_Society name ]
        JobName = "motor", -- [ esx_Job name ]
        JobLabel = "motor", -- [ Label ]
        Blip = { -- [ Map Blip for gang house/location ]
            coords = vector3(-1165.7, -2031.69, 14.99),
            sprite = 147,
            scale = 0.8,
            opacity = 0,
            color = 48,
            name = "motor",
        },
        Markers = { -- [ Markers for gang management/etc. ]
            boss = { -- [Society actions]
                name = "boss",
                coords = {x = -940.01, y = 202.52, z = 66.86},
                label = "Acciones de jefe"
            },
            armory = { --[ Item + Weapon storage ]
                name = "armory",
               coords = {x = -927.85, y = 213.83, z = 66.48},
                label = "Armario"
            }
        }
    },
 }