# Utilisation de Python comme base
FROM python:3.10-slim

# Définir le répertoire de travail
WORKDIR /app

# Installer Pipenv
RUN pip install --no-cache-dir pipenv

# Ajouter /usr/local/bin au PATH
ENV PATH="/usr/local/bin:$PATH"

# Copier les fichiers nécessaires
COPY src/Pipfile /app/Pipfile
COPY src/Pipfile.lock /app/Pipfile.lock
COPY src/front /app/front

# Installer les dépendances via Pipenv et vérifier l'installation de Streamlit
RUN pipenv install --system --deploy && streamlit --version

# Exposer le port Streamlit
EXPOSE 8501

# Démarrer l'application Streamlit
CMD ["streamlit", "run", "/app/front/app.py", "--server.port=8501", "--server.enableCORS=false"]
