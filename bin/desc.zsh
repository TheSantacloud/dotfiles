#!/bin/zsh

setting_descriptors=("Dense forest" "Underground cave" "Abandoned city street" "High mountain peak" "Busy market square" "Ancient library" "Darkened alley" "Open field" "Haunted mansion hallway" "Candlelit cathedral")
moods=("Peaceful" "Tense" "Eerie" "Awe-inspiring" "Chaotic" "Reverent" "Suspenseful" "Calm" "Foreboding" "Solemn")
visual_details=("Flickering torchlight" "Thick fog" "Shadows creeping on the walls" "Sparkling water droplets" "Golden sunlight" "Dim lanterns" "Ominous silhouette" "Tattered curtains" "Glowing runes" "Shifting shadows")
temperatures=("Warm" "Cold" "Hot" "Chilly" "Mild" "Humid" "Icy" "Freezing" "Stuffy" "Temperate")
smells=("Incense" "Damp earth" "Blood" "Musty books" "Perfume" "Rotting wood" "Metal" "Burning wood" "Sulfur" "Fresh flowers")
sounds=("Whispering voices" "Distant footsteps" "Silence" "Dripping water" "Clattering in the distance" "Soft humming" "Faint wind" "Rattling chains" "Groaning structure" "Murmuring conversation")
focal_points=("Ancient stone altar" "Ornate mirror" "Small, locked chest" "Dark figure in a cloak" "Twisted tree trunk" "Golden goblet on a pedestal" "Strange glowing crystal" "Old painting on the wall" "Mysterious black book" "Cracked stone statue")
movements=("Dust swirling around it" "Reflection flickering" "Latch twitching" "Breathing softly" "Branches creaking" "Liquid sloshing inside" "Pulsing with light" "Eyes shifting" "Pages fluttering" "Stone crumbling off")
hooks=("Object emanates a low hum" "A hidden door appears" "A figure vanishes quickly" "A cold draft comes from below" "The room feels too quiet" "The floor creaks underfoot" "An unknown symbol glows faintly" "A voice whispers in your ear" "Shadows shift unnaturally" "The ground pulses slightly")
emotions=("Unease" "Curiosity" "Suspicion" "Anxiety" "Tension" "Anticipation" "Confusion" "Dread" "Fear" "Alarm")

get_random_element() {
    local array=("$@")
    if [ ${#array[@]} -eq 0 ]; then
        echo ""
    else
        echo "${array[$RANDOM % ${#array[@]}]}"
    fi
}

elements_count=$((2 + RANDOM % 4))
used_indices=()

for (( i=0; i<$elements_count; i++ )); do
    while :; do
        random_index=$((RANDOM % 10))
        if [[ ! " ${used_indices[@]} " =~ " ${random_index} " ]]; then
            used_indices+=("$random_index")
            break
        fi
    done

    case $random_index in
        0) element="$(get_random_element "${setting_descriptors[@]}")" ;;
        1) element="$(get_random_element "${moods[@]}")" ;;
        2) element="$(get_random_element "${visual_details[@]}")" ;;
        3) element="$(get_random_element "${temperatures[@]}")" ;;
        4) element="$(get_random_element "${smells[@]}")" ;;
        5) element="$(get_random_element "${sounds[@]}")" ;;
        6) element="$(get_random_element "${focal_points[@]}")" ;;
        7) element="$(get_random_element "${movements[@]}")" ;;
        8) element="$(get_random_element "${hooks[@]}")" ;;
        9) element="$(get_random_element "${emotions[@]}")" ;;
    esac

    if [[ -n "$element" ]]; then
        echo "$element"
    else
        i=i-1;
    fi
done

