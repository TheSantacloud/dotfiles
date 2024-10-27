#!/bin/zsh

setting_descriptors=("Dense forest" "Underground cave" "Abandoned city street" "High mountain peak" "Busy market square" "Ancient library" "Darkened alley" "Open field" "Haunted mansion hallway" "Candlelit cathedral" "Desolate desert" "Crumbling castle" "Snow-covered village" "Misty riverbank" "Ancient ruin" "Lush jungle" "Stormy coastline" "Ruined temple" "Flooded valley" "Windy hilltop")
moods=("Peaceful" "Tense" "Eerie" "Awe-inspiring" "Chaotic" "Reverent" "Suspenseful" "Calm" "Foreboding" "Solemn" "Nostalgic" "Melancholic" "Hopeful" "Overwhelming" "Frightening" "Energizing" "Somber" "Oppressive" "Tranquil" "Exciting")
visual_details=("Flickering torchlight" "Thick fog" "Shadows creeping on the walls" "Sparkling water droplets" "Golden sunlight" "Dim lanterns" "Ominous silhouette" "Tattered curtains" "Glowing runes" "Shifting shadows" "Cracked windows" "Faint moonlight" "Rustling leaves" "Dust motes in the air" "Broken glass" "Distant lightning" "Rays of sunlight through clouds" "Rippling water" "Swirling mist" "Falling leaves")
temperatures=("Warm" "Cold" "Hot" "Chilly" "Mild" "Humid" "Icy" "Freezing" "Stuffy" "Temperate" "Sweltering" "Cool" "Breezy" "Frigid" "Boiling" "Brisk" "Oppressively hot" "Crisp" "Tepid" "Scorching")
smells=("Incense" "Damp earth" "Blood" "Musty books" "Perfume" "Rotting wood" "Metal" "Burning wood" "Sulfur" "Fresh flowers" "Salt air" "Wet stone" "Smoke" "Mildew" "Rust" "Stale air" "Leather" "Baking bread" "Sweat" "Faint perfume")
sounds=("Whispering voices" "Distant footsteps" "Silence" "Dripping water" "Clattering in the distance" "Soft humming" "Faint wind" "Rattling chains" "Groaning structure" "Murmuring conversation" "Creaking floorboards" "Rustling leaves" "Thunder rumbling" "Buzzing insects" "Wind howling" "Scratching at the walls" "Loud crash" "Birdsong" "Chiming bells" "Soft sobbing")
focal_points=("Ancient stone altar" "Ornate mirror" "Small, locked chest" "Dark figure in a cloak" "Twisted tree trunk" "Golden goblet on a pedestal" "Strange glowing crystal" "Old painting on the wall" "Mysterious black book" "Cracked stone statue" "Dusty old tome" "Shattered vase" "Forgotten key" "Weathered tombstone" "Faded tapestry" "Ancient throne" "Gleaming sword in the ground" "Enchanted amulet" "Rusty, chained door" "Large, intricate map")
movements=("Dust swirling around it" "Reflection flickering" "Latch twitching" "Breathing softly" "Branches creaking" "Liquid sloshing inside" "Pulsing with light" "Eyes shifting" "Pages fluttering" "Stone crumbling off" "Shadows dancing" "Water rippling" "Leaves drifting down" "Curtains billowing" "Light shimmering" "Smoke curling upward" "Webs quivering" "Handle rattling" "Footsteps approaching" "Light dimming")
hooks=("Object emanates a low hum" "A hidden door appears" "A figure vanishes quickly" "A cold draft comes from below" "The room feels too quiet" "The floor creaks underfoot" "An unknown symbol glows faintly" "A voice whispers in your ear" "Shadows shift unnaturally" "The ground pulses slightly" "A chill runs down your spine" "A loud crash echoes" "A door slams shut" "An eerie light flickers" "Something scurries away" "A sudden gust of wind" "A distant scream is heard" "The ground trembles" "The air grows thick" "An object falls unexpectedly")
emotions=("Unease" "Curiosity" "Suspicion" "Anxiety" "Tension" "Anticipation" "Confusion" "Dread" "Fear" "Alarm" "Hope" "Excitement" "Desperation" "Longing" "Disbelief" "Fascination" "Nervousness" "Regret" "Impatience" "Relief")

get_random_element() {
    local array=("$@")
    local array_size=${#array[@]}

    if (( array_size == 0 )); then
        echo "[Error] Array is empty!" >&2
        return 1
    fi

    local index=$((1 + RANDOM % array_size))
    local element="${array[$index]}"

    if [[ -z "$element" ]]; then
        echo "[Error] Selected element is empty! " $index >&2
        return 1
    fi

    echo "$element"
}

elements_count=$((2 + RANDOM % 3))
used_indices=()

for (( i=0; i<$elements_count; i++ )); do
    while :; do
        random_index=$((RANDOM % 9))
        if [[ ! " ${used_indices[@]} " =~ " ${random_index} " ]]; then
            used_indices+=("$random_index")
            break
        fi
    done

    case $random_index in
        0) element="🏞️🏰 $(get_random_element "${setting_descriptors[@]}")" ;;
        1) element="🌫️🌞 $(get_random_element "${moods[@]}")" ;;
        2) element="🌫️✨ $(get_random_element "${visual_details[@]}")" ;;
        3) element="🔥❄️ $(get_random_element "${temperatures[@]}")" ;;
        4) element="👃🌹 $(get_random_element "${smells[@]}")" ;;
        5) element="🔊🔇 $(get_random_element "${sounds[@]}")" ;;
        6) element="🗝️💎 $(get_random_element "${focal_points[@]}")" ;;
        7) element="🍃💨 $(get_random_element "${movements[@]}")" ;;
        8) element="😨😍 $(get_random_element "${emotions[@]}")" ;;
    esac

    if [[ -n "$element" ]]; then
        echo "$element"
    else
        i=i-1;
    fi

done
echo "> 📷 $(get_random_element "${hooks[@]}")"

