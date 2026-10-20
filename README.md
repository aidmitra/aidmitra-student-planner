# AidMitra Student Planner — Supabase-configured build — initialization-order fix

This build has AidMitra's existing Supabase project URL and **publishable** client key preconfigured, so students do not need to enter Supabase credentials themselves.

## Publish to the existing GitHub Pages repository

1. Extract this ZIP.
2. Open your repository: https://github.com/aidmitra/aidmitra-student-planner
3. Choose **Add file → Upload files**.
4. Upload the six files from this folder to the repository root, replacing files with the same names.
5. Commit the changes to `main`.
6. Wait for GitHub Pages to redeploy, then refresh https://aidmitra.github.io/aidmitra-student-planner/ . If the old version remains, hard-refresh or clear the site cache.

## Supabase checklist

- The app uses the configured project URL and public publishable key in client-side code. Publishable keys are designed to be public; never use a `service_role` or secret key in the website.
- Ensure `supabase_schema.sql` has been run in the existing project's SQL Editor.
- In Supabase Authentication settings, set the Site URL to `https://aidmitra.github.io` and add `https://aidmitra.github.io/aidmitra-student-planner/**` (or the exact callback URLs required by the project's auth configuration) to allowed redirect URLs.
- Test signup and sign-in. If email confirmation is enabled, confirm the message before signing in.
- Test with two separate student accounts and verify Row Level Security prevents users from reading or changing each other's planner data.

## Important

This change preconfigures the client connection; it does not itself verify that the live Supabase database schema, authentication settings, or row-level security are correct. Keep the public repository limited to client-side publishable credentials. Do not upload database passwords, access tokens, or secret/service-role keys.


## Navigation fix (MVP 3.4)
This version adds direct navigation handlers to the sidebar and updates the service-worker cache strategy so the latest page is fetched on refresh. Upload all six files to the repository root and commit to `main`. After deployment, open the site and hard-refresh with Ctrl+Shift+R. On Android, if the old page remains, clear the site data/cache for aidmitra.github.io or open the site in a private tab once.


## MVP 3.5 button interaction fix
This build explicitly binds the Add class, Add task, Add exam, and Import timetable buttons and exposes app handlers on `window` for reliable browser interaction. The service-worker cache version was bumped to force the updated app shell to replace the previous cached build.

After uploading the files, wait for GitHub Pages to deploy, then hard-refresh the site. If using an installed PWA on Android, fully close it and reopen it; if it still shows the old build, clear site data for `aidmitra.github.io` and reopen the site.


## Fix in this build

The startup failure was caused by `loadCloudConfig()` running before `DEFAULT_CLOUD_CONFIG` was initialized. That exception stopped the rest of the main script, which left `selectedDay`, `modalType`, and `importRows` uninitialized and made navigation/modal/import clicks throw ReferenceErrors. The default config is now declared before startup initialization, and the service-worker cache was bumped to `aidmitra-shell-v7`.
