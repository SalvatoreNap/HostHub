"""
URL configuration for sito_hosthub project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/6.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from core import views
# Assicurati di avere queste due importazioni:
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.home, name='home'),
    path('alloggi/', views.lista_alloggi, name='lista_alloggi'),
    path('esperienze/', views.lista_esperienze, name='lista_esperienze'),
    path('registrazione/', views.registrazione, name='registrazione'),
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('alloggio/<int:id_alloggio>/', views.dettaglio_alloggio, name='dettaglio_alloggio'),
    path('esperienza/<int:id_esperienza>/', views.dettaglio_esperienza, name='dettaglio_esperienza'),
    path('profilo/', views.profilo_utente, name='profilo_utente'),
    path('host/dashboard/', views.host_dashboard, name='host_dashboard'),
    path('host/alloggio/<int:id_alloggio>/edit/', views.edit_alloggio, name='edit_alloggio'),
]

# QUESTE RIGHE SONO FONDAMENTALI PER VEDERE LE IMMAGINI
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)