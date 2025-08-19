from django.apps import apps
import logging


logger = logging.getLogger(__name__)

getModel = lambda x: apps.get_model(*x.split(".", 1))

def fetch_random_objects(self, count, model_name):
    model = getModel(model_name)
    return model.objects.all().order_by("?")[:count]
