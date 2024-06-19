import requests as request
from django.conf import settings

API_KEY = settings.API_KEY
API_URL = f'http://www.omdbapi.com/?apikey={API_KEY}'
json_response = {
    "Search": "",
    "data": {
        "years": {

        },
        "actors": {

        }
    }
}


def count_movies_by_year(movies):
    for movie in movies:
        if movie['Year'] not in json_response["data"]["years"]:
            json_response["data"]["years"][movie['Year']] = 1
            continue
        json_response["data"]["years"][movie['Year']] += 1


def count_movies_by_actor(movies):
    for movie in movies:
        detailed_movie = request.get(f'{API_URL}&i={movie["imdbID"]}')
        if detailed_movie.status_code == 200:
            detailed_movie = detailed_movie.json()
            actors = detailed_movie['Actors'].split(', ')
            for actor in actors:
                if actor not in json_response["data"]["actors"]:
                    json_response["data"]["actors"][actor] = 1
                    continue
                json_response["data"]["actors"][actor] += 1


def get_data(search_data):
    response = request.get(API_URL + '&s=' + search_data + '&type=movie')
    json_response["Search"] = search_data
    if response.status_code != 200:
        return {"error": "Error in the request, not founded data"}
    response = response.json()
    if 'Error' in response:
        return {"error": response['Error']}
    total_results = int(response['totalResults'])
    pages = total_results // 10
    if total_results % 10 != 0:
        pages += 1
    for page in range(1, pages + 1):
        response = request.get(f'{API_URL}&s={search_data}&type=movie&page={page}')
        if response.status_code == 200:
            response = response.json()
            count_movies_by_year(response['Search'])
            count_movies_by_actor(response['Search'])
    return json_response

