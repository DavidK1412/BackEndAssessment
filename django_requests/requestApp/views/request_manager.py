from django.views.generic import ListView
from django.shortcuts import render


class RequestManager(ListView):
    def get(self, request, **kwargs):
        return render(self.request, 'RequestManager/find.html')
