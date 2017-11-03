
#!/bin/sh -e
APP_NAME=$protected-crag-75076

git remote add heroku git@heroku.com:$APP_NAME.git
git fetch heroku
MIGRATION_CHANGES=$(git diff HEAD heroku/master --name-only -- db | wc -l)
echo "$MIGRATION_CHANGES db changes since last deploy."

rake assets:precompile
git config user.name "CircleCi"
git config user.email "ci@example.com"
git add public/assets
git commit -m "Precompile assets"

PREV_WORKERS=$(heroku ps --app $APP_NAME | grep "^worker." | wc -l | tr -d ' ')

# migrations require downtime so enter maintenance mode
if test $MIGRATION_CHANGES -gt 0; then
  heroku maintenance:on --app $APP_NAME

  # Make sure workers are not running during a migration
  heroku scale worker=0 --app $APP_NAME
fi

# deploy code changes (and implicitly restart the app and any running workers)
git push heroku HEAD:refs/heads/master -f

# run database migrations if needed and restart background workers once finished
if test $MIGRATION_CHANGES -gt 0; then
  heroku run rake db:migrate db:seed --app $APP_NAME
  heroku restart --app $APP_NAME
  heroku scale worker=$PREV_WORKERS --app $APP_NAME
fi

heroku run rake cache:flush --app $APP_NAME
heroku maintenance:off --app $APP_NAME
