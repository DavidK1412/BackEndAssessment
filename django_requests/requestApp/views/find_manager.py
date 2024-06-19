from django.views.generic import ListView
from django.http import JsonResponse

from requestApp.utils.api_request import get_data

class Find(ListView):
    def get(self, request, **kwargs):
        search = kwargs['search']
        return JsonResponse(get_data(search))

