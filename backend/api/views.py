from django.db import connections
from django.db.utils import OperationalError
from django.http import JsonResponse


def health_check(_request):
    health = {"status": "ok", "database": "ok"}
    try:
        db_conn = connections["default"]
        db_conn.cursor()
    except OperationalError:
        health["status"] = "error"
        health["database"] = "down"
        return JsonResponse(health, status=503)

    return JsonResponse(health)
