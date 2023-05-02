import requests
import json

def get_game_id_from_name(game_name):
    steam_api_game_list_url = "https://api.steampowered.com/ISteamApps/GetAppList/v2/"
    response = requests.get(steam_api_game_list_url)
    if response.status_code != 200: 
        return None
    all_games_list = response.json()["applist"]["apps"]
    game_name = "".join(game_name.lower().split())
    for game in all_games_list:
        if game_name == "".join(game["name"].lower().split()): 
            return game["appid"]
    return None

def get_game_information_from_id(game_id): 
    steam_api_get_game_url = "https://store.steampowered.com/api/appdetails?appids={game_id}"
    response = requests.get(steam_api_get_game_url.format(game_id=game_id))
    if response.status_code != 200:
        return None
    game_information = response.json()[str(game_id)]["data"]
    return game_information

def get_game_information_from_name(game_name): 
    game_id = get_game_id_from_name(game_name)
    if game_id == None: 
        return None
    game_information = get_game_information_from_id(game_id)
    return game_information