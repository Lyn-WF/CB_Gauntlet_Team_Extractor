This is a piece of Ruby code quickly hacked-together in a couple hours to parse the tapes and stickers of characters in Magikrab's Gauntlet in the game Cassette Beasts

Written for my personal use, but I realized it'd probably be useful to wiki writers and whatnot. Do what you please with it. You can contact @lyn_8662 on Discord if you need to.

Requires the extraced game files, see the Cassette Beasts wiki on Modding for how to do this.

Lists the species, stickers, bootleg type, and requires/denied difficulty of tapes.
Supports extracting teams of one or two characters. Not three, sorry Joel.

Example Input:
ruby Reader.rb '[your extracted file path]/data/gauntlet_encounters/captain_ianthe_scene.tscn'

Example Output:
Character: IANTHE

Tape: gearyu
Stickers:
 -custom_starter
 -sure_fire
 -custom_starter
 -ap_boost
 -ap_starter
 -acorn_mortar
 -ap_refund
 -radiation_breath
 -gear_shear
 -shield_bash
 -ricochet
 -custom_starter
 -defend
 -spit

Tape: robindam
Stickers:
 -spit
 -spring_load
 -return_fire
 -ap_refund
 -revenge_strike
 -return_fire
 -suction_cup_dart
 -ap_steal
 -custom_starter
 -ap_boost
 -custom_starter
 -raise_arms
 -headshot

Tape: folklord
Stickers:
 -custom_starter
 -abramacabra
 -custom_starter
 -ap_boost
 -custom_starter
 -sharpen
 -custom_starter
 -raise_arms
 -custom_starter
 -dejavu
 -custom_starter
 -mind_meld
 -custom_starter
 -ritual
 -custom_starter
 -copy_that
require_gauntlet_difficulty = 1

Tape: anathema
Stickers:
 -smack
 -custom_starter
 -fission_power
 -neutralise
 -multicopy
 -status_resistance
 -sturdy_armour
 -vengeful_curse
 -self_destruct
 -phase_shift
 -automation
 -parry_stance
 -bite
 -carnivore
 -trap_jaw
 -critical_ap
 -vampire
require_gauntlet_difficulty = 2

- - - - - PARTNER - - - - -

Character: RANGER_TRADER

Tape: djinn_entonic
Stickers:
 -spit
 -custom_starter
 -haunt
 -new_leaf
 -ap_refund
 -ap_starter
 -custom_starter
 -ap_boost
 -moonshine
 -djinntoxicate
 -bottle_volley
 -breathing_technique
 -chemical_imbalance
 -dejavu

Tape: decibelle
Stickers:
 -spit
 -ap_refund
 -ap_starter
 -custom_starter
 -ap_boost
 -custom_starter
 -call_for_help
 -taunt
 -echolocation
 -hurricane
 -metal_riff
 -nurse
