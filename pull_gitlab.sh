#!/bin/bash

# Ce script clone ton repo GitLab privé dans GitHub Actions
echo "📦 Clonage depuis GitLab..."

git clone https://oauth2:${GITLAB_TOKEN}@GITLAB_LINK gitlab_repo
cd gitlab_repo

echo "✅ Repo GitLab cloné"
python scripts/manga_scraper.py
