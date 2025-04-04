#!/bin/bash
set -e

echo "📦 Clonage du dépôt GitLab privé..."
git clone https://oauth2:${GITLAB_TOKEN}@${GITLAB_LINK} gitlab_repo

cd gitlab_repo

echo "📦 Installation des dépendances Python"
pip install -r requirements.txt

echo "🚀 Lancement du scraper manga + anime"
python scripts/manga_scraper.py
python scripts/anime_scraper.py

echo "🔍 Vérification des modifications sur les fichiers de séries"

# Vérifie uniquement les deux fichiers ciblés
if git diff --exit-code data/manga_series.yaml data/anime_series.yaml > /dev/null; then
  echo "✅ Aucun changement dans les fichiers de suivi. Aucun push effectué."
else
  echo "📝 Changements détectés. Commit & push vers GitLab..."
  git config user.name "GitHub Scraper Bot"
  git config user.email "bot@scraper.com"
  git add data/manga_series.yaml data/anime_series.yaml
  git commit -m "🔄 MAJ automatique via GitHub Actions"
  git push https://oauth2:${GITLAB_TOKEN}@${GITLAB_LINK}
fi
