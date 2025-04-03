#!/bin/bash
set -e

echo "📦 Clonage du dépôt GitLab privé..."
git clone https://oauth2:${GITLAB_TOKEN}@${GITLAB_LINK} gitlab_repo

cd gitlab_repo

echo "📦 Installation des dépendances"
pip install -r requirements.txt

echo "🚀 Lancement du scraper manga + anime"
python scripts/manga_scraper.py
python scripts/anime_scraper.py
