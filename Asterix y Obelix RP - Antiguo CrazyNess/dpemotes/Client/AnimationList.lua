DP = {}

DP.Expressions = {
   ["Enfadado"] = {"Expression", "mood_angry_1"},
   ["Borracho"] = {"Expression", "mood_drunk_1"},
   ["enbobado"] = {"Expression", "pose_injured_1"},
   ["Electrocutado"] = {"Expression", "electrocuted_1"},
   ["Serio"] = {"Expression", "effort_1"},
   ["Serio2"] = {"Expression", "mood_drivefast_1"},
   ["Serio3"] = {"Expression", "pose_angry_1"},
   ["Feliz"] = {"Expression", "mood_happy_1"},
   ["desconcentrado"] = {"Expression", "mood_injured_1"},
   ["Joyful"] = {"Expression", "mood_dancing_low_1"},
   ["Enbobado2"] = {"Expression", "smoking_hold_1"},
   ["Never Blink"] = {"Expression", "pose_normal_1"},
   ["Ojo cerrado"] = {"Expression", "pose_aiming_1"},
   ["Shock"] = {"Expression", "shocked_1"},
   ["Shock2"] = {"Expression", "shocked_2"},
   ["Dormido"] = {"Expression", "mood_sleeping_1"},
   ["Dormido2"] = {"Expression", "dead_1"},
   ["Dormido3"] = {"Expression", "dead_2"},
   ["Smug"] = {"Expression", "mood_smug_1"},
   ["Especulador"] = {"Expression", "mood_aiming_1"},
   ["Estresado"] = {"Expression", "mood_stressed_1"},
   ["Berrinche"] = {"Expression", "mood_sulk_1"},
   ["Viejo"] = {"Expression", "effort_2"},
   ["Viejo2"] = {"Expression", "effort_3"},
}

DP.Walks = {
  ["Alien"] = {"move_m@alien"},
  ["Cowboy"] = {"anim_group_move_ballistic"},
  ["Creido"] = {"move_f@arrogant@a"},
  ["Chulo"] = {"move_m@brave"},
  ["Casual"] = {"move_m@casual@a"},
  ["Casual2"] = {"move_m@casual@b"},
  ["Casual3"] = {"move_m@casual@c"},
  ["Casual4"] = {"move_m@casual@d"},
  ["Casual5"] = {"move_m@casual@e"},
  ["Casual6"] = {"move_m@casual@f"},
  ["Sexy"] = {"move_f@chichi"},
  ["Confident"] = {"move_m@confident"},
  ["Poli"] = {"move_m@business@a"},
  ["Poli2"] = {"move_m@business@b"},
  ["Poli3"] = {"move_m@business@c"},
  ["Default Mujer"] = {"move_f@multiplayer"},
  ["Default Hombre"] = {"move_m@multiplayer"},
  ["Borracho"] = {"move_m@drunk@a"},
  ["Borracho"] = {"move_m@drunk@slightlydrunk"},
  ["Borracho2"] = {"move_m@buzzed"},
  ["Borracho3"] = {"move_m@drunk@verydrunk"},
  ["Sexy2"] = {"move_f@femme@"},
  ["Bombero"] = {"move_characters@franklin@fire"},
  ["Bombero2"] = {"move_characters@michael@fire"},
  ["Bombero3"] = {"move_m@fire"},
  ["Flee"] = {"move_f@flee@a"},
  ["Franklin"] = {"move_p_m_one"},
  ["Gangster"] = {"move_m@gangster@generic"},
  ["Gangster2"] = {"move_m@gangster@ng"},
  ["Gangster3"] = {"move_m@gangster@var_e"},
  ["Gangster4"] = {"move_m@gangster@var_f"},
  ["Gangster5"] = {"move_m@gangster@var_i"},
  ["Bailando"] = {"anim@move_m@grooving@"},
  ["Guardia"] = {"move_m@prison_gaurd"},
  ["Esposado"] = {"move_m@prisoner_cuffed"},
  ["Heels"] = {"move_f@heels@c"},
  ["Heels2"] = {"move_f@heels@d"},
  ["Cargando"] = {"move_m@hiking"},
  ["Hipster"] = {"move_m@hipster@a"},
  ["Hobo"] = {"move_m@hobo@a"},
  ["Hurry"] = {"move_f@hurry@a"},
  ["Janitor"] = {"move_p_m_zero_janitor"},
  ["Janitor2"] = {"move_p_m_zero_slow"},
  ["Jog"] = {"move_m@jog@"},
  ["Lemar"] = {"anim_group_move_lemar_alley"},
  ["Lester"] = {"move_heist_lester"},
  ["Lester2"] = {"move_lester_caneup"},
  ["Maneater"] = {"move_f@maneater"},
  ["Michael"] = {"move_ped_bucket"},
  ["Money"] = {"move_m@money"},
  ["Muscle"] = {"move_m@muscle@a"},
  ["Posh"] = {"move_m@posh@"},
  ["Posh2"] = {"move_f@posh@"},
  ["Quick"] = {"move_m@quick"},
  ["Runner"] = {"female_fast_runner"},
  ["Sad"] = {"move_m@sad@a"},
  ["Sassy"] = {"move_m@sassy"},
  ["Sassy2"] = {"move_f@sassy"},
  ["Scared"] = {"move_f@scared"},
  ["Sexy"] = {"move_f@sexy@a"},
  ["Shady"] = {"move_m@shadyped@a"},
  ["Slow"] = {"move_characters@jimmy@slow@"},
  ["Swagger"] = {"move_m@swagger"},
  ["Tough"] = {"move_m@tough_guy@"},
  ["Tough2"] = {"move_f@tough_guy@"},
  ["Trash"] = {"clipset@move@trash_fast_turn"},
  ["Trash2"] = {"missfbi4prepp1_garbageman"},
  ["Trevor"] = {"move_p_m_two"},
  ["Wide"] = {"move_m@bag"},
  -- I cant get these to work for some reason, if anyone knows a fix lmk
  --["Caution"] = {"move_m@caution"},
  --["Chubby"] = {"anim@move_m@chubby@a"},
  --["Crazy"] = {"move_m@crazy"},
  --["Joy"] = {"move_m@joy@a"},
  --["Power"] = {"move_m@power"},
  --["Sad2"] = {"anim@move_m@depression@a"},
  --["Sad3"] = {"move_m@depression@b"},
  --["Sad4"] = {"move_m@depression@d"},
  --["Wading"] = {"move_m@wading"},
}

DP.Shared = {
   --[emotename] = {dictionary, animation, displayname, targetemotename, additionalanimationoptions}
   -- you dont have to specify targetemoteanem, if you do dont it will just play the same animation on both.
   -- targetemote is used for animations that have a corresponding animation to the other player.
   ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handshake", "handshake2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
       SyncOffsetFront = 0.9
   }},
   ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handshake 2", "handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "Hug", "hug2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.05,
   }},
   ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "Hug 2", "hug", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.13
   }},
   ["bro"] = {"mp_ped_interaction", "hugs_guy_a", "Bro", "bro2", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["bro2"] = {"mp_ped_interaction", "hugs_guy_b", "Bro 2", "bro", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["dar"] = {"mp_common", "givetake1_a", "Dar", "give2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["dar2"] = {"mp_common", "givetake1_b", "Dar 2", "give", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["beisbol"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "Beisbol", "baseballthrow"},
   ["beisbol2"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "Beisbol 2", "baseball"},
   ["atracar"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Atracar", "stickupscared", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["atracar2"] = {"missminuteman_1ig_2", "handsup_base", "Ser atracado", "stickup", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["golpear"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "Dar golpe", "punched"},
   ["golpear2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "Recibir golpe", "punch"},
   ["cabezazo"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Dar cabezazo", "Cabezazo"},
   ["cabezazo2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "Recibir cabezazo", "headbutt"},
   ["torta2"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", "Torta 2", "slapped2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["torta"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Torta", "slapped", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["torta3"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "Recibir torta", "slap"},
   ["torta4"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "Recibir reves", "slap2"},
}

DP.Dances = {
   ["baile"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "Baile 1", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "Baile 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Baile 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "Baile 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "Baile 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Baile 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile7"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "Baile 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile8"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "Baile 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile9"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "Baile 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile 10"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "Baile 10", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile 11"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "Baile 11", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile 12"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "Baile 12", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile 13"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "Baile 13", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile 14"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "Baile 14", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["baile 15"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "Baile 15", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["baile 16"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "Baile 16", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile17"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "Baile 17", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile 18"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "Baile 18", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile 19"] = {"rcmnigel1bnmt_1b", "dance_loop_tyler", "Baile 19", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile 20"] = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao", "Baile 20", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile 21"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "Baile 21", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile 22"] = {"missfbi3_sniping", "dance_m_default", "Baile 22", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile 23"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "Baile 23", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile24"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "Baile 24", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile25"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "Baile 25", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile26"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "Baile 26", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile27"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "Baile 27", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile28"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "Baile 28", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile29"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "Baile 29", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["baile30"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "Baile 30", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["baile31"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "Baile 31", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["baile32"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "Baile 32", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["baile33"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_13_mi_hi_sexualgriding_laz", "Baile 33", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["baile34"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_12_mi_hi_bootyshake_laz", "Baile 34", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["baile35"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Baile 35", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["baile36"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "Baile 36", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["baile37"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "crowddance_hi_11_handup_laz", "Baile 37", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["baile38"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_11_hu_shimmy_laz", "Baile 38", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
}

DP.Emotes = {
   ["drink"] = {"mp_player_inteat@pnq", "loop", "Drink", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["rabia"] = {"anim@mp_fm_event@intro", "beast_transform", "Rabia", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000,
   }},
   ["tumbado"] = {"switch@trevor@scares_tramp", "trev_scares_tramp_idle_tramp", "Tumbado", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tumbado2"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl", "Tumbado 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tumbado3"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_guy", "Tumbado 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tumbado4"] = {"missfbi3_sniping", "prone_dave", "Tumbado 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cruzcura"] = {"misscarsteal3pullover", "pull_over_right", "Cura", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["idle"] = {"anim@heists@heist_corona@team_idles@male_a", "idle", "Idle", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle8"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "Idle 8"},
   ["idle9"] = {"friends@fra@ig_1", "base_idle", "Idle 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle10"] = {"mp_move@prostitute@m@french", "idle", "Idle 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["idle11"] = {"random@countrysiderobbery", "idle_a", "Idle 11", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle2"] = {"anim@heists@heist_corona@team_idles@female_a", "idle", "Idle 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle3"] = {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop", "Idle 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle4"] = {"anim@mp_celebration@idles@female", "celebration_idle_f_a", "Idle 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle5"] = {"anim@mp_corona_idles@female_b@idle_a", "idle_a", "Idle 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle6"] = {"anim@mp_corona_idles@male_c@idle_a", "idle_a", "Idle 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle7"] = {"anim@mp_corona_idles@male_d@idle_a", "idle_a", "Idle 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wait3"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "Wait 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd1", "Idle Drunk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk2"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd2", "Idle Drunk 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk3"] = {"missarmenian2", "standing_idle_loop_drunk", "Idle Drunk 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["airguitar"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar", "Air Guitar"},
   ["piano"] = {"anim@mp_player_intcelebrationfemale@air_synth", "air_synth", "Piano"},
   ["noentiendo"] = {"misscarsteal4@actor", "actor_berating_loop", "No entiendo", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["discutir"] = {"oddjobs@assassinate@vice@hooker", "argue_a", "Discutir", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["apoyarse3"] = {"anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", "Apoyarse en barra", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["besos"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "blow_kiss", "Besos"},
   ["besos2"] = {"anim@mp_player_intselfieblow_kiss", "exit", "Besos 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000

   }},
   ["ballet"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "Ballet"},
   ["quepasa"] = {"misscommon@response", "bring_it_on", "Que pasa", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["venbro"] = {"mini@triathlon", "want_some_of_this", "Ven bro", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["poli2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Brazos cruzados", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["radio2"] = {"amb@code_human_police_investigate@idle_a", "idle_b", "Radio policia 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cruzarbrazos"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "Cruzar brazos", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cruzarbrazos2"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "Cruzarbrazos 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["cruzarbrazos3"] = {"anim@heists@heist_corona@single_team", "single_team_loop_boss", "Cruzarbrazos 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cruzarbrazos4"] = {"random@street_race", "_car_b_lookout", "Cruzarbrazos 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cruzarbrazos5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Cruzarbrazos 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cruzarbrazos8"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Cruzarbrazos 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cruzarbrazos6"] = {"random@shop_gunstore", "_idle", "Cruzarbrazos 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cruzarbrazos7"] = {"anim@amb@business@bgen@bgen_no_work@", "stand_phone_phoneputdown_idle_nowork", "Cruzarbrazos 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cruzarbrazos9"] = {"rcmnigel1a_band_groupies", "base_m2", "Cruzarbrazos 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["damn"] = {"gestures@m@standing@casual", "gesture_damn", "Damn", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["damn2"] = {"anim@am_hold_up@male", "shoplift_mid", "Damn 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["pointdown"] = {"gestures@f@standing@casual", "gesture_hand_down", "Point Down", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["rendirse"] = {"random@arrests@busted", "idle_a", "Rendirse", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["facepalm2"] = {"anim@mp_player_intcelebrationfemale@face_palm", "face_palm", "Facepalm 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm"] = {"random@car_thief@agitated@idle_a", "agitated_idle_a", "Facepalm", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm3"] = {"missminuteman_1ig_2", "tasered_2", "Facepalm 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm4"] = {"anim@mp_player_intupperface_palm", "idle_a", "Facepalm 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["borracho"] = {"random@drunk_driver_1", "drunk_fall_over", "Borracho"},
   ["suicidarse"] = {"mp_suicide", "pistol", "Suicidarse"},
   ["suicidarse2"] = {"mp_suicide", "pill", "Suicidarse 2"},
   ["fingir"] = {"friends@frf@ig_2", "knockout_plyr", "Fingir"},
   ["fingirtorta"] = {"anim@gangops@hostage@", "victim_fail", "Fingir torta"},
   ["dormir2"] = {"mp_sleep", "sleep_loop", "Dormir2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["pelea"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "Pelea"},
   ["pelea2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "Pelea 2"},
   ["queteden"] = {"anim@mp_player_intselfiethe_bird", "idle_a", "Que te den", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["queteden2"] = {"anim@mp_player_intupperfinger", "idle_a_fp", "Que te den 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handshake 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["wait4"] = {"amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", "Wait 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wait5"] = {"missclothing", "idle_storeclerk", "Wait 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait6"] = {"timetable@amanda@ig_2", "ig_2_base_amanda", "Wait 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait7"] = {"rcmnigel1cnmt_1c", "base", "Wait 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait8"] = {"rcmjosh1", "idle", "Wait 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait9"] = {"rcmjosh2", "josh_2_intp1_base", "Wait 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait10"] = {"timetable@amanda@ig_3", "ig_3_base_tracy", "Wait 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait11"] = {"misshair_shop@hair_dressers", "keeper_base", "Wait 11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hiking"] = {"move_m@hiking", "idle", "Hiking", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["abrazo"] = {"mp_ped_interaction", "kisses_guy_a", "Abrazo"},
   ["abrazo2"] = {"mp_ped_interaction", "kisses_guy_b", "Abrazo 2"},
   ["hug3"] = {"mp_ped_interaction", "hugs_guy_a", "Hug 3"},
   ["inspect"] = {"random@train_tracks", "idle_e", "Inspect"},
   ["tachan"] = {"anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands", "Tachan", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 6000,
   }},
   ["jog2"] = {"amb@world_human_jog_standing@male@idle_a", "idle_a", "Jog 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog3"] = {"amb@world_human_jog_standing@female@idle_a", "idle_a", "Jog 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog4"] = {"amb@world_human_power_walker@female@idle_a", "idle_a", "Jog 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog5"] = {"move_m@joy@a", "walk", "Jog 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["saltos"] = {"timetable@reunited@ig_2", "jimmy_getknocked", "saltos", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kneel2"] = {"rcmextreme3", "idle", "Kneel 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kneel3"] = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a", "Kneel 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["golpearpuerta"] = {"timetable@jimmy@doorknock@", "knockdoor_idle", "golpearpuerta", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["golpearpuerta2"] = {"missheistfbi3b_ig7", "lift_fibagent_loop", "Golpear Puerta 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["amenazarpuño"] = {"anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", "Amenazar Puños", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gogo"] = {"mp_safehouse", "lap_dance_girl", "Gogo"},
   ["lean2"] = {"amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "Lean 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean3"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", "Lean 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean4"] = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a", "Lean 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean5"] = {"amb@world_human_leaning@male@wall@back@hands_together@idle_b", "idle_b", "Lean 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanflirt"] = {"random@street_race", "_car_a_flirt_girl", "Lean Flirt", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar2"] = {"amb@prop_human_bum_shopping_cart@male@idle_a", "idle_c", "Lean Bar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar3"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", "Lean Bar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar4"] = {"anim@heists@prison_heist", "ped_b_loop_a", "Lean Bar 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanhigh"] = {"anim@mp_ferris_wheel", "idle_a_player_one", "Lean High", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanhigh2"] = {"anim@mp_ferris_wheel", "idle_a_player_two", "Lean High 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["apoyarse6"] = {"timetable@mime@01_gc", "idle_a", "Apoyarse 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["apoyarse5"] = {"misscarstealfinale", "packer_idle_1_trevor", "Apoyarse 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["apoyarse4"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Apoyarse 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["apoyarse7"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Apoyarse 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["apoyarse8"] = {"rcmjosh2", "josh_2_intp1_base", "Apoyarse 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["yo"] = {"gestures@f@standing@casual", "gesture_me_hard", "Yo", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["mecanico"] = {"mini@repair", "fixing_a_ped", "mecanico", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mecanico2"] = {"amb@world_human_vehicle_mechanic@male@base", "idle_a", "mecanico 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mecanico3"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "mecanico 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mecanico4"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "mecanico 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["agacharse"] = {"amb@medic@standing@tendtodead@base", "base", "agacharse", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["meditar"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "meditar", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditar2"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "meditar 2", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditar3"] = {"rcmepsilonism3", "base_loop", "meditar 3", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["rock"] = {"anim@mp_player_intincarrockstd@ps@", "idle_a", "rock", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no3"] = {"anim@heists@ornate_bank@chat_manager", "fail", "No 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no"] = {"mp_player_int_upper_nod", "mp_player_int_nod_no", "No", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nariz"] = {"anim@mp_player_intcelebrationfemale@nose_pick", "nose_pick", "Hurgar nariz", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no2"] = {"gestures@m@standing@casual", "gesture_no_way", "No 2", AnimationOptions =
   {
       EmoteDuration = 1500,
       EmoteMoving = true,
   }},
   ["ok"] = {"anim@mp_player_intselfiedock", "idle_a", "OK", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mareado"] = {"re@construction", "out_of_breath", "Mareado", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["coger"] = {"random@domestic", "pickup_low", "Coger"},
   ["empujar2"] = {"missfinale_c2ig_11", "pushcar_offcliff_f", "empujar2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["empujar"] = {"missfinale_c2ig_11", "pushcar_offcliff_m", "Empujar", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["señalar2"] = {"gestures@f@standing@casual", "gesture_point", "Señalar2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["flexiones"] = {"amb@world_human_push_ups@male@idle_a", "idle_d", "Flexiones", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["animar"] = {"random@street_race", "grid_girl_race_start", "Animar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["señalar"] = {"mp_gun_shop_tut", "indicate_right", "Señalar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["militar"] = {"anim@mp_player_intincarsalutestd@ds@", "idle_a", "Saludo militar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["militar2"] = {"anim@mp_player_intincarsalutestd@ps@", "idle_a", "Saludo militar2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["militar3"] = {"anim@mp_player_intuppersalute", "idle_a", "Saludo militar3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["asustado"] = {"random@domestic", "f_distressed_loop", "Asustado", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["asustado2"] = {"random@homelandsecurity", "knees_loop_girl", "Asustado2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cortemanga"] = {"misscommon@response", "screw_you", "Corte de manga", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sacudirse"] = {"move_m@_idles@shake_off", "shakeoff_1", "Sacudirse", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3500,
   }},
   ["herido"] = {"random@dealgonewrong", "idle_a", "Herido", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dormir3"] = {"timetable@tracy@sleep@", "idle_c", "Dormir3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["quepasa2"] = {"gestures@f@standing@casual", "gesture_shrug_hard", "Que pasa 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["quepasa3"] = {"gestures@m@standing@casual", "gesture_shrug_hard", "Que pasa 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["sentadosuelo"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", "Sentado en el suelo", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentadosuelo2"] = {"rcm_barry3", "barry_3_sit_loop", "Sentado en el suelo 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentadosuelo3"] = {"amb@world_human_picnic@male@idle_a", "idle_a", "Sentado en el suelo 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentadosuelo4"] = {"amb@world_human_picnic@female@idle_a", "idle_a", "Sentado en el suelo 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentadosuelo5"] = {"anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", "Sentado en el suelo 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentadosuelo6"] = {"timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", "Sentado en el suelo 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentadosuelo7"] = {"anim@amb@nightclub@lazlow@lo_alone@", "lowalone_base_laz", "Sentado en el suelo 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentadosuelo8"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", "Sentado em el suelo 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentadosuelo9"] = {"amb@world_human_stupor@male@idle_a", "idle_a", "Sentado en el suelo 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentadotriste2"] = {"timetable@tracy@ig_14@", "ig_14_base_tracy", "Sentado triste 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentadotriste"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "Sentado triste", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentadomiedo"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_b", "Sentado con miedo", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentadomiedo2"] = {"anim@heists@ornate_bank@hostages@ped_c@", "flinch_loop", "Sentado con miedo 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentadomiedo3"] = {"anim@heists@ornate_bank@hostages@ped_e@", "flinch_loop", "Sentado con miedo 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["borrachosentado"] = {"timetable@amanda@drunk@base", "base", "Borracho sentado", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarse2"] = {"timetable@ron@ig_5_p3", "ig_5_p3_base", "Sentarse 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarse3"] = {"timetable@reunited@ig_10", "base_amanda", "Sentarse 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarse4"] = {"timetable@ron@ig_3_couch", "base", "Sentarse 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarse5"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", "Sentarse 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarse6"] = {"timetable@maid@couch@", "base", "Sentarse 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarse7"] = {"timetable@ron@ron_ig_2_alt1", "ig_2_alt1_base", "Sentarse de lado", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["abdominales"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a", "Abdominales", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["aplaudir3"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "Aplaudir 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["aplaudir6"] = {"anim@mp_player_intupperslow_clap", "idle_a", "Aplaudir 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["aplaudir2"] = {"amb@world_human_cheering@male_a", "base", "Aplaudir 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["aplaudir5"] = {"anim@mp_player_intcelebrationfemale@slow_clap", "slow_clap", "Aplaudir 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["aplaudir7"] = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap", "Aplaudir 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["olerdedos"] = {"move_p_m_two_idles@generic", "fidget_sniff_fingers", "Oler dedos", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Stick Up", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mareado2"] = {"misscarsteal4@actor", "stumble", "Mareado 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["taseado"] = {"stungun@standing", "damage", "Taseado", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tomarsol3"] = {"amb@world_human_sunbathe@male@back@base", "base", "Tomarsol 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tomarsol4"] = {"amb@world_human_sunbathe@female@back@base", "base", "Tomarsol 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["t"] = {"missfam5_yoga", "a2_pose", "T", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["t2"] = {"mp_sleep", "bind_pose_180", "T 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pensar2"] = {"mp_cp_welcome_tutthink", "b_think", "Pensar 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["pensar3"] = {"misscarsteal4@aliens", "rehearsal_base_idle_director", "Pensar 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pensar4"] = {"timetable@tracy@ig_8@base", "base", "Pensar 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["pensar5"] = {"missheist_jewelleadinout", "jh_int_outro_loop_a", "Pensar 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bien3"] = {"anim@mp_player_intincarthumbs_uplow@ds@", "enter", "Bien 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["bien2"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "Bien 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bien"] = {"anim@mp_player_intupperthumbs_up", "idle_a", "Bien", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["teclear"] = {"anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", "teclear", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["teclear2"] = {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", "teclear 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["teclear3"] = {"mp_prison_break", "hack_loop", "teclear 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["teclear4"] = {"mp_fbi_heist", "loop", "teclear 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["calentarse"] = {"amb@world_human_stand_fire@male@idle_a", "idle_a", "Calentarse", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["saludar"] = {"random@mugging5", "001445_01_gangintimidation_1_female_idle_b", "Saludar", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["saludar2"] = {"anim@mp_player_intcelebrationfemale@wave", "wave", "Saludar 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["saludar3"] = {"friends@fra@ig_1", "over_here_idle_a", "Saludar 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["saludar4"] = {"friends@frj@ig_1", "wave_a", "Saludar 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["saludar5"] = {"friends@frj@ig_1", "wave_b", "Saludar 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["saludar6"] = {"friends@frj@ig_1", "wave_c", "Saludar 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["saludar7"] = {"friends@frj@ig_1", "wave_d", "Saludar 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["saludar8"] = {"friends@frj@ig_1", "wave_e", "Saludar 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["saludar9"] = {"gestures@m@standing@casual", "gesture_hello", "Saludar 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["silvar"] = {"taxi_hail", "hail_taxi", "Silvar", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["silvar2"] = {"rcmnigel1c", "hailing_whistle_waive_a", "Silvar 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["yeah"] = {"anim@mp_player_intupperair_shagging", "idle_a", "Yeah", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["autostop"] = {"random@hitch_lift", "idle_f", "Autostop", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lol"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "LOL", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lol2"] = {"anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_b", "LOL 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["estatua"] = {"fra_0_int-1", "cs_lamardavis_dual-1", "Estatua", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["estatua2"] = {"club_intro2-0", "csb_englishdave_dual-0", "Estatua 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gestobanda"] = {"mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a", "Gesto banda", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gestobanda2"] = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b", "Gesto banda 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["inconsciente"] = {"missarmenian2", "drunk_loop", "inconsciente", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["inconsciente2"] = {"missarmenian2", "corpse_search_exit_ped", "inconsciente 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["inconsciente3"] = {"anim@gangops@morgue@table@", "body_search", "inconsciente 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["inconsciente4"] = {"mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", "inconsciente 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["inconsciente5"] = {"random@mugging4", "flee_backward_loop_shopkeeper", "inconsciente 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["petting"] = {"creatures@rottweiler@tricks@", "petting_franklin", "Petting", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["arrastrarse"] = {"move_injured_ground", "front_loop", "Arrastrarse", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["capoeira"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "Capoeira"},
   ["mortal"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "Mortal"},
   ["futbol"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "Futbol"},
   ["futbol2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "futbol 2"},
   ["futbol3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "futbol 3"},
   ["batear"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "Batear"},
   ["queteden3"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_a_1st", "Que te den 3", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["queteden4"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_c_1st", "Que te den 4", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["reverencia"] = {"anim@arena@celeb@podium@no_prop@", "regal_c_1st", "Reverencia", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["reverencia2"] = {"anim@arena@celeb@podium@no_prop@", "regal_a_1st", "Reverencia 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mando"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "Mando", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["golf"] = {"rcmnigel1d", "swing_a_mark", "Golf"},
   ["eat"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Eat", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["pistola"] = {"move_m@intimidation@cop@unarmed", "idle", "Pistola", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar2"] = {"random@shop_tattoo", "_idle_a", "Esperar 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar3"] = {"missbigscore2aig_3", "wait_for_van_c", "Esperar 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar4"] = {"rcmjosh1", "idle", "Esperar 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar5"] = {"rcmnigel1a", "base", "Esperar 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lapdance2"] = {"mini@strip_club@private_dance@idle", "priv_dance_idle", "Lapdance 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part2", "priv_dance_p2", "Lapdance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part3", "priv_dance_p3", "Lapdance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["twerk"] = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", "Twerk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tortazo"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "tortazo", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Headbutt"},
   ["bailepez"] = {"anim@mp_player_intupperfind_the_fish", "idle_a", "Baile pez", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["paz"] = {"mp_player_int_upperpeace_sign", "mp_player_int_peace_sign", "Paz", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["paz2"] = {"anim@mp_player_intupperpeace", "idle_a", "Paz 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rcp"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "RCP", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["rcp2"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "RCP 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ledge"] = {"missfbi1", "ledge_loop", "Ledge", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["planear"] = {"missfbi1", "ledge_loop", "Planear", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peek"] = {"random@paparazzi@peek", "left_peek_a", "Peek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["toser"] = {"timetable@gardener@smoking_joint", "idle_cough", "Toser", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["estirar"] = {"mini@triathlon", "idle_e", "estirar", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["estirar2"] = {"mini@triathlon", "idle_f", "estirar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["estirar3"] = {"mini@triathlon", "idle_d", "estirar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["estirar4"] = {"rcmfanatic1maryann_stretchidle_b", "idle_e", "estirar 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["celebrar"] = {"rcmfanatic1celebrate", "celebrate", "Celebrar", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boxeo"] = {"rcmextreme2", "loop_punching", "Boxeo", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["superheroe"] = {"rcmbarry", "base", "Superheroe", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["superheroe2"] = {"rcmbarry", "base", "Superheroe 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["controlmente"] = {"rcmbarry", "mind_control_b_loop", "Controlmente", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["controlmente2"] = {"rcmbarry", "bar_1_attack_idle_aln", "controlmente 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["joker"] = {"rcm_barry2", "clown_idle_0", "Joker", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["joker2"] = {"rcm_barry2", "clown_idle_1", "Joker 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["joker3"] = {"rcm_barry2", "clown_idle_2", "Joker 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["joker4"] = {"rcm_barry2", "clown_idle_3", "Joker 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["joker5"] = {"rcm_barry2", "clown_idle_6", "Joker 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mirarse"] = {"mp_clothing@female@trousers", "try_trousers_neutral_a", "Mirarse", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mirarse2"] = {"mp_clothing@female@shirt", "try_shirt_positive_a", "Mirarse 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mirarse3"] = {"mp_clothing@female@shoes", "try_shoes_positive_a", "Mirarse 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["nervioso"] = {"mp_missheist_countrybank@nervous", "nervous_idle", "nervioso", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervioso2"] = {"amb@world_human_bum_standing@twitchy@idle_a", "idle_c", "nervioso 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervioso3"] = {"rcmme_tracey1", "nervous_loop", "nervioso 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["llave"] = {"mp_arresting", "a_uncuff", "Llave", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["namaste"] = {"timetable@amanda@ig_4", "ig_4_base", "Namaste", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dj"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", "DJ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["threaten"] = {"random@atmrobberygen", "b_atm_mugging", "Threaten", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["radio"] = {"random@arrests", "generic_radio_chatter", "Radio", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tirar"] = {"random@mugging4", "struggle_loop_b_thief", "Tirar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pajaro"] = {"random@peyote@bird", "wakeup", "Pajaro"},
   ["gallina"] = {"random@peyote@chicken", "wakeup", "Gallina", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["perrito"] = {"random@peyote@dog", "wakeup", "Perrito"},
   ["conejo"] = {"random@peyote@rabbit", "wakeup", "Conejo"},
   ["spiderman"] = {"missexile3", "ex03_train_roof_idle", "Spider-Man", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["indicar"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "Indicar", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 3000,
   }},
   ["arreglarse"] = {"missmic4", "michael_tux_fidget", "Arreglarse", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 4000,
   }},
   ["rendirse2"] = {"missminuteman_1ig_2", "handsup_base", "Rendirse 2", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["pee"] = {"misscarsteal2peeing", "peeing_loop", "Pee", AnimationOptions =
   {
       EmoteStuck = true,
       PtfxAsset = "scr_amb_chop",
       PtfxName = "ent_anim_dog_peeing",
       PtfxNoProp = true,
       PtfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['pee'],
       PtfxWait = 3000,
   }},

-----------------------------------------------------------------------------------------------------------
------ These are Scenarios, some of these dont work on women and some other issues, but still good to have.
-----------------------------------------------------------------------------------------------------------

   ["cajero"] = {"Scenario", "PROP_HUMAN_ATM", "ATM"},
   ["bbq"] = {"MaleScenario", "PROP_HUMAN_BBQ", "BBQ"},
   ["ordenar"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "Ordenar"},
   ["domir"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Dormir"},
   ["aplaudir"] = {"Scenario", "WORLD_HUMAN_CHEERING", "Aplaudir"},
   ["dominadas"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "Dominadas"},
   ["documento2"] = {"MaleScenario", "WORLD_HUMAN_CLIPBOARD", "Documento 2"},
   ["poli"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "Manos cinturon"},
   ["trafico"] = {"MaleScenario", "WORLD_HUMAN_CAR_PARK_ATTENDANT", "Trafico"},
   ["grabarmovil"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Grabar con el movil"},
   ["presumir"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "Presumir"},
   ["guardia"] = {"Scenario", "WORLD_HUMAN_GUARD_STAND", "Guardia"},
   ["martillo"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "Martillo"},
   ["esperar"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "Esperar"},
   ["impatiente"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "Impatiente"},
   ["escoba"] = {"Scenario", "WORLD_HUMAN_JANITOR", "Escoba"},
   ["trotar"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "Trotar"},
   ["observar"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "Observar"},
   ["soplador"] = {"MaleScenario", "WORLD_HUMAN_GARDENER_LEAF_BLOWER", "Soplador de hojas"},
   ["apoyarse"] = {"Scenario", "WORLD_HUMAN_LEANING", "Apoyarse"},
   ["apoyarse2"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "Apoyarse en la barra"},
   ["observar2"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "Observar 2"},
   ["limpiar3"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "Limpiar 3"},
   ["analizar"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "Analizar medico"},
   ["tocarinstrumento"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "Tocar instrumento"},
   ["anotar"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "Anotar"},
   ["pagar"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "Pagar"},
   ["fiesta"] = {"Scenario", "WORLD_HUMAN_PARTYING", "Fiesta"},
   ["movil3"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "Movil 3"},
   ["prostituta"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "Prostituta"},
   ["prostituta2"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "Prostituta 2"},
   ["lavarse"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "Lavarse las manos"},
   ["grabarmovil2"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Grabar con el movil 2"},
   -- Sitchair is a litte special, since you want the player to be seated correctly.
   -- So we set it as "ScenarioObject" and do TaskStartScenarioAtPosition() instead of "AtPlace"
   ["sentarse"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "Sentarse"},
   ["fumar5"] = {"Scenario", "WORLD_HUMAN_SMOKING", "Fumar 5"},
   ["fumarcanuto"] = {"MaleScenario", "WORLD_HUMAN_DRUG_DEALER", "Fumar canuto"},
   ["mimo"] = {"Scenario", "WORLD_HUMAN_HUMAN_STATUE", "Estatua mimo"},
   ["tomarsol"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", "Tomar el sol"},
   ["tomarsol2"] = {"Scenario", "WORLD_HUMAN_SUNBATHE_BACK", "Tomar el sol arriba"},
   ["soldar"] = {"Scenario", "WORLD_HUMAN_WELDING", "Soldar"},
   ["mirar"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "Mirar escaparate"},
   ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "Yoga"},
   -- CASINO DLC EMOTES (STREAMED)
   ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "Karate"},
   ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "Karate 2"},
   ["amenazar"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "Amenazar"},
   ["amenazar2"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "Amenazar 2"},
   ["noentiendo2"] = {"anim@mp_player_intcelebrationmale@mind_blown", "mind_blown", "No entiendo 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["noentiendo3"] = {"anim@mp_player_intcelebrationfemale@mind_blown", "mind_blown", "No entiendo 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxear"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "Boxear", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxear2"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "Boxear 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["apesta"] = {"anim@mp_player_intcelebrationfemale@stinker", "stinker", "Apesta", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["pensar"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "Pensar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["arreglarse2"] = {"clothingtie", "try_tie_positive_a", "Arreglarse 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000
   }},
}

DP.PropEmotes = {
   ["paraguas"] = {"amb@world_human_drinking@coffee@male@base", "base", "Paraguas", AnimationOptions =
   {
       Prop = "p_amb_brolly_01",
       PropBone = 57005,
       PropPlacement = {0.15, 0.005, 0.0, 87.0, -20.0, 180.0},
       --
       EmoteLoop = true,
       EmoteMoving = true,
   }},

-----------------------------------------------------------------------------------------------------
------ This is an example of an emote with 2 props, pretty simple! ----------------------------------
-----------------------------------------------------------------------------------------------------

   ["anotar"] = {"missheistdockssetup1clipboard@base", "base", "Anotar", AnimationOptions =
   {
       Prop = 'prop_notepad_01',
       PropBone = 18905,
       PropPlacement = {0.1, 0.02, 0.05, 10.0, 0.0, 0.0},
       SecondProp = 'prop_pencil_01',
       SecondPropBone = 58866,
       SecondPropPlacement = {0.11, -0.02, 0.001, -120.0, 0.0, 0.0},
       -- EmoteLoop is used for emotes that should loop, its as simple as that.
       -- Then EmoteMoving is used for emotes that should only play on the upperbody.
       -- The code then checks both values and sets the MovementType to the correct one
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["caja"] = {"anim@heists@box_carry@", "idle", "Caja", AnimationOptions =
   {
       Prop = "hei_prop_heist_box",
       PropBone = 60309,
       PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rosa"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Rosa", AnimationOptions =
   {
       Prop = "prop_single_rose",
       PropBone = 18905,
       PropPlacement = {0.13, 0.15, 0.0, -100.0, 0.0, -20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["fumar2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "Fumar 2", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["fumar3"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_b", "Fumar 3", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["fumar4"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "Fumar 4", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bong"] = {"anim@safehouse@bong", "bong_stage3", "Bong", AnimationOptions =
   {
       Prop = 'hei_heist_sh_bong_01',
       PropBone = 18905,
       PropPlacement = {0.10,-0.25,0.0,95.0,190.0,180.0},
   }},
   ["maleta"] = {"missheistdocksprep1hold_cellphone", "static", "Maleta", AnimationOptions =
   {
       Prop = "prop_ld_suitcase_01",
       PropBone = 57005,
       PropPlacement = {0.39, 0.0, 0.0, 0.0, 266.0, 60.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["maleta2"] = {"missheistdocksprep1hold_cellphone", "static", "Maleta 2", AnimationOptions =
   {
       Prop = "prop_security_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cartel2"] = {"mp_character_creation@customise@male_a", "loop", "Cartel 2", AnimationOptions =
   {
       Prop = 'prop_police_id_board',
       PropBone = 58868,
       PropPlacement = {0.12, 0.24, 0.0, 5.0, 0.0, 70.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cafe"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Cafe", AnimationOptions =
   {
       Prop = 'p_amb_coffeecup_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whisky"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whisky", AnimationOptions =
   {
       Prop = 'prop_drink_whisky',
       PropBone = 28422,
       PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cerveza"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Cerveza", AnimationOptions =
   {
       Prop = 'prop_amb_beer_bottle',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["vaso"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Vaso", AnimationOptions =
   {
       Prop = 'prop_plastic_cup_02',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut", AnimationOptions =
   {
       Prop = 'prop_amb_donut',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["hamburguesa"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Hamburguesa", AnimationOptions =
   {
       Prop = 'prop_cs_burger_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["sandwich"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandwich", AnimationOptions =
   {
       Prop = 'prop_sandwich_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["cola"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Cola", AnimationOptions =
   {
       Prop = 'prop_ecola_can',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["barrita"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Barrita", AnimationOptions =
   {
       Prop = 'prop_choc_ego',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
   }},
   ["vino"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Vino", AnimationOptions =
   {
       Prop = 'prop_drink_redwine',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["copa"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Copa", AnimationOptions =
   {
       Prop = 'prop_champ_flute',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["champan"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Champan", AnimationOptions =
   {
       Prop = 'prop_drink_champ',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["puro"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Puro", AnimationOptions =
   {
       Prop = 'prop_cigar_02',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["puro2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Puro 2", AnimationOptions =
   {
       Prop = 'prop_cigar_01',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["guitarra"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitarra", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarra2"] = {"switch@trevor@guitar_beatdown", "001370_02_trvs_8_guitar_beatdown_idle_busker", "Guitarra 2", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarra3"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitarra 3", AnimationOptions =
   {
       Prop = 'prop_el_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarra4"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitarra 4", AnimationOptions =
   {
       Prop = 'prop_el_guitar_03',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["libro"] = {"cellphone@", "cellphone_text_read_base", "Libro", AnimationOptions =
   {
       Prop = 'prop_novel_01',
       PropBone = 6286,
       PropPlacement = {0.15, 0.03, -0.065, 0.0, 180.0, 90.0}, -- This positioning isnt too great, was to much of a hassle
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["flores"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Flores", AnimationOptions =
   {
       Prop = 'prop_snow_flower_02',
       PropBone = 24817,
       PropPlacement = {-0.29, 0.40, -0.02, -90.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["peluche"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Peluche", AnimationOptions =
   {
       Prop = 'v_ilev_mr_rasberryclean',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["mochila"] = {"move_p_m_zero_rucksack", "idle", "Mochila", AnimationOptions =
   {
       Prop = 'p_michael_backpack_s',
       PropBone = 24818,
       PropPlacement = {0.07, -0.11, -0.05, 0.0, 90.0, 175.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["documento"] = {"missfam4", "base", "Documento", AnimationOptions =
   {
       Prop = 'p_amb_clipboard_01',
       PropBone = 36029,
       PropPlacement = {0.16, 0.08, 0.1, -130.0, -50.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["mapa"] = {"amb@world_human_tourist_map@male@base", "base", "Mapa", AnimationOptions =
   {
       Prop = 'prop_tourist_map_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["cartel"] = {"amb@world_human_bum_freeway@male@base", "base", "Cartel", AnimationOptions =
   {
       Prop = 'prop_beggers_sign_03',
       PropBone = 58868,
       PropPlacement = {0.19, 0.18, 0.0, 5.0, 0.0, 40.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tirardinero"] = {"anim@mp_player_intupperraining_cash", "idle_a", "Tirar dinero", AnimationOptions =
   {
       Prop = 'prop_anim_cash_pile_01',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 180.0, 0.0, 70.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_xs_celebration",
       PtfxName = "scr_xs_money_rain",
       PtfxPlacement = {0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['makeitrain'],
       PtfxWait = 500,
   }},
   ["camara"] = {"amb@world_human_paparazzi@male@base", "base", "Camara", AnimationOptions =
   {
       Prop = 'prop_pap_camera_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       PtfxAsset = "scr_bike_business",
       PtfxName = "scr_bike_cfid_camera_flash",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
       PtfxWait = 200,
   }},
   ["champan2"] = {"anim@mp_player_intupperspray_champagne", "idle_a", "Champan 2", AnimationOptions =
   {
       Prop = 'ba_prop_battle_champ_open',
       PropBone = 28422,
       PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_ba_club",
       PtfxName = "scr_ba_club_champagne_spray",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['spraychamp'],
       PtfxWait = 500,
   }},
   ["canuto"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Canuto", AnimationOptions =
   {
       Prop = 'p_cs_joint_02',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cigarro"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigarro", AnimationOptions =
   {
       Prop = 'prop_amb_ciggy_01',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["maletin"] = {"missheistdocksprep1hold_cellphone", "static", "Maletin", AnimationOptions =
   {
       Prop = "prop_ld_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet"] = {"amb@world_human_tourist_map@male@base", "base", "Tablet", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {0.0, -0.03, 0.0, 20.0, -90.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mdt"] = {"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "Tablet 2", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["movil2"] = {"cellphone@", "cellphone_call_listen_base", "Llamar", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["movil"] = {"cellphone@", "cellphone_text_read_base", "Movil", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["limpiar"] = {"timetable@floyd@clean_kitchen@base", "base", "Limpiar", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["limpiar2"] = {"amb@world_human_maid_clean@", "base", "Limpiar 2", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
}