<?php


function pick_emoji($planet) {
    $planetEmojis = [
        "Earth" => "🌎",
        "Moon" => "🌕"
    ];
    return $planetEmojis[$planet] ?? "🪐";
}
